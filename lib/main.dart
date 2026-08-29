import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/core/router/app_router.dart';
import 'package:hybrid_tracker/core/services/home_widget_service.dart';
import 'package:hybrid_tracker/core/services/notification_service.dart';
import 'package:hybrid_tracker/core/services/xp_service.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/features/auth/data/models/app_user_model.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/customization/domain/providers/customization_providers.dart';
import 'package:hybrid_tracker/features/focus/domain/providers/focus_providers.dart';
import 'package:hybrid_tracker/core/theme/app_theme.dart';
import 'package:hybrid_tracker/core/theme/theme_provider.dart';
import 'package:hybrid_tracker/features/ai/domain/providers/smart_reminder_providers.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/pin_providers.dart';
import 'package:hybrid_tracker/features/auth/presentation/screens/pin_lock_screen.dart';
import 'package:alarm/alarm.dart' as alarm_pkg;
import 'package:hybrid_tracker/features/sleep/data/models/alarm_model.dart';
import 'package:hybrid_tracker/features/sleep/domain/providers/sleep_providers.dart';
import 'package:hybrid_tracker/features/sleep/presentation/screens/alarm_ring_screen.dart';
import 'package:hybrid_tracker/shared/widgets/level_up_overlay.dart';
import 'dart:async';

// Database provider
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await NotificationService.instance.init();
  await NotificationService.instance.requestPermissions();
  await HomeWidgetService.registerBackgroundCallback();

  runApp(const ProviderScope(child: RyveApp()));
}

class RyveApp extends ConsumerWidget {
  const RyveApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    // A selected `app_themes` row re-skins AppColors' mutable palette fields
    // (see AppColors.applyTheme) and forces the brightness that theme was
    // designed for — the manual dark/light toggle only applies when no
    // custom theme is picked. The KeyedSubtree below forces every screen in
    // the tree to rebuild from scratch when the theme id changes, which is
    // what makes already-mounted widgets pick up the newly-applied colors.
    final activeTheme = ref.watch(resolvedActiveThemeProvider).valueOrNull;
    AppColors.applyTheme(activeTheme);
    final effectiveThemeMode = activeTheme == null
        ? themeMode
        : (activeTheme.isDark ? ThemeMode.dark : ThemeMode.light);

    return MaterialApp.router(
      title: 'Ryve',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: effectiveThemeMode,
      routerConfig: router,
      builder: (context, child) => KeyedSubtree(
        key: ValueKey(activeTheme?.id),
        child: _GamificationOverlayHost(child: child),
      ),
    );
  }
}

class _GamificationOverlayHost extends ConsumerStatefulWidget {
  const _GamificationOverlayHost({required this.child});

  final Widget? child;

  @override
  ConsumerState<_GamificationOverlayHost> createState() =>
      _GamificationOverlayHostState();
}

class _GamificationOverlayHostState
    extends ConsumerState<_GamificationOverlayHost> with WidgetsBindingObserver {
  ProviderSubscription<AsyncValue<int>>? _levelSub;
  Timer? _reminderTimer;
  StreamSubscription<alarm_pkg.AlarmSettings>? _ringSub;
  StreamSubscription<dynamic>? _ringingStateSub;

  // When non-null, the alarm ring overlay is shown on top of everything.
  alarm_pkg.AlarmSettings? _ringingAlarm;
  AlarmModel? _matchedAlarm;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _rescheduleAlarms();
    _listenAlarmRings();
    ref.read(smartReminderNotifierProvider.notifier).evaluateNow();
    _reminderTimer = Timer.periodic(
      const Duration(minutes: 15),
      (_) => ref.read(smartReminderNotifierProvider.notifier).evaluateNow(),
    );
    _levelSub = ref.listenManual<AsyncValue<int>>(levelUpEventsProvider, (_, next) {
      final level = next.valueOrNull;
      if (level != null) showLevelUpCelebration(context, level);
    });
    HomeWidgetService.listenForClicks(
      onFocusAutoStart: () {
        final router = ref.read(appRouterProvider);
        router.go(Routes.focus);
        ref.read(focusTimerNotifierProvider.notifier).start();
      },
    );
    ref.listenManual<AsyncValue<AppUser?>>(authStateProvider, (_, next) {
      HomeWidgetService.saveCurrentUserId(next.valueOrNull?.uid);
    }, fireImmediately: true);
  }

  void _listenAlarmRings() {
    // Cold-start: Alarm.init() (called before runApp) populates Alarm.ringing
    // even though ringStream's broadcast event is already gone.
    final alreadyRinging = alarm_pkg.Alarm.ringing.value.alarms;
    if (alreadyRinging.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _activateRingOverlay(alreadyRinging.first);
      });
    }

    // Hot-path: app in foreground or background, Dart isolate alive.
    _ringSub = alarm_pkg.Alarm.ringStream.stream.listen(_activateRingOverlay);

    // Track ringing state changes to clear the overlay when alarm stops.
    _ringingStateSub = alarm_pkg.Alarm.ringing.listen((set) {
      if ((set.alarms as Iterable).isEmpty && mounted && _ringingAlarm != null) {
        setState(() {
          _ringingAlarm = null;
          _matchedAlarm = null;
        });
      }
    });
  }

  Future<void> _activateRingOverlay(alarm_pkg.AlarmSettings alarmSettings) async {
    if (!mounted) return;
    // Resolve the AlarmModel for math level / snooze settings.
    AlarmModel? matched;
    final userId = ref.read(authStateProvider).valueOrNull?.uid;
    if (userId != null) {
      try {
        final repo = ref.read(sleepRepositoryProvider);
        final alarms = await repo.watchAlarms(userId).first;
        matched = _findAlarmByIntId(alarms, alarmSettings.id);
      } catch (_) {}
    }
    if (!mounted) return;
    setState(() {
      _ringingAlarm = alarmSettings;
      _matchedAlarm = matched;
    });
  }

  void _onAlarmDismissed() {
    if (!mounted) return;
    setState(() {
      _ringingAlarm = null;
      _matchedAlarm = null;
    });
  }

  void _onAlarmSnoozed() {
    if (!mounted) return;
    setState(() {
      _ringingAlarm = null;
      _matchedAlarm = null;
    });
  }

  AlarmModel? _findAlarmByIntId(List<AlarmModel> alarms, int intId) {
    for (final alarm in alarms) {
      for (var w = 1; w <= 7; w++) {
        if ((Object.hash(alarm.id, w) & 0x7fffffff) == intId) return alarm;
      }
      if (((0x40000000 + alarm.id.hashCode) & 0x7fffffff) == intId) {
        return alarm;
      }
    }
    return null;
  }

  void _rescheduleAlarms() {
    final userId = ref.read(authStateProvider).valueOrNull?.uid;
    if (userId == null) return;
    final repo = ref.read(sleepRepositoryProvider);
    repo.watchAlarms(userId).first.then((alarms) {
      for (final alarm in alarms) {
        if (alarm.isEnabled) {
          NotificationService.instance.scheduleAlarm(alarm).ignore();
        }
      }
    }).ignore();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final consumerRef = ref;
    if (state == AppLifecycleState.paused) {
      LockGate.onPause(consumerRef);
    } else if (state == AppLifecycleState.resumed) {
      LockGate.onResume(consumerRef);
      ref.read(smartReminderNotifierProvider.notifier).evaluateNow();
      // Re-check ringing state on resume (covers the case where the alarm
      // rang while the app was fully backgrounded and the ring event was
      // processed before this widget was listening).
      final stillRinging = alarm_pkg.Alarm.ringing.value.alarms;
      if (stillRinging.isNotEmpty && _ringingAlarm == null && mounted) {
        _activateRingOverlay(stillRinging.first);
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _levelSub?.close();
    _reminderTimer?.cancel();
    _ringSub?.cancel();
    _ringingStateSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locked = ref.watch(appLockedProvider);
    final ringing = _ringingAlarm;
    return Stack(
      children: [
        widget.child ?? const SizedBox.shrink(),
        // Suppress PIN lock while alarm is active — math challenge IS the gate.
        if (locked && ringing == null) const PinLockScreen(),
        // Alarm ring overlay — shown directly in the Stack so no Navigator
        // route can be popped/redirected by GoRouter or auth state changes.
        if (ringing != null)
          AlarmRingScreen(
            key: ValueKey(ringing.id),
            alarmSettings: ringing,
            alarm: _matchedAlarm,
            onDismiss: _onAlarmDismissed,
            onSnooze: _onAlarmSnoozed,
          ),
      ],
    );
  }
}
