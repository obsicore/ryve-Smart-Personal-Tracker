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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.read(smartReminderNotifierProvider.notifier).evaluateNow();
    _reminderTimer = Timer.periodic(
      const Duration(minutes: 15),
      (_) => ref.read(smartReminderNotifierProvider.notifier).evaluateNow(),
    );
    // XP float overlays are triggered per-screen at each award call site
    // (see XpFloatOverlay.show usages) since they need a precise on-screen
    // anchor; only level-up is global since it has no natural anchor.
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final consumerRef = ref;
    if (state == AppLifecycleState.paused) {
      LockGate.onPause(consumerRef);
    } else if (state == AppLifecycleState.resumed) {
      LockGate.onResume(consumerRef);
      ref.read(smartReminderNotifierProvider.notifier).evaluateNow();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _levelSub?.close();
    _reminderTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locked = ref.watch(appLockedProvider);
    return Stack(
      children: [
        widget.child ?? const SizedBox.shrink(),
        if (locked) const PinLockScreen(),
      ],
    );
  }
}
