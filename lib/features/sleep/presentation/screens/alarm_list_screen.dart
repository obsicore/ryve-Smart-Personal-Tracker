import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:hybrid_tracker/core/services/notification_service.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/sleep/data/models/alarm_model.dart';
import 'package:hybrid_tracker/features/sleep/domain/providers/sleep_providers.dart';
import 'package:hybrid_tracker/features/sleep/presentation/screens/alarm_screen.dart';
import 'package:hybrid_tracker/features/sleep/presentation/widgets/alarm_card_widget.dart';
import 'package:hybrid_tracker/shared/widgets/ryve_bottom_nav.dart';
import 'package:hybrid_tracker/shared/widgets/skeleton_widget.dart';

class AlarmListScreen extends ConsumerStatefulWidget {
  const AlarmListScreen({super.key});

  @override
  ConsumerState<AlarmListScreen> createState() => _AlarmListScreenState();
}

class _AlarmListScreenState extends ConsumerState<AlarmListScreen> {
  bool? _exactAlarmGranted;
  bool? _batteryOptimized;

  @override
  void initState() {
    super.initState();
    NotificationService.instance.hasExactAlarmPermission().then((granted) {
      if (mounted) setState(() => _exactAlarmGranted = granted);
    });
    NotificationService.instance.isIgnoringBatteryOptimizations().then((ignoring) {
      if (mounted) setState(() => _batteryOptimized = !ignoring);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    final alarmsAsync = ref.watch(alarmsProvider);

    return PopScope(
      canPop: context.canPop(),
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.go('/');
      },
      child: Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: context.canPop()
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded, color: onBg, size: 20),
                onPressed: () => context.pop(),
              )
            : null,
        title: Text('Alarms', style: AppTypography.titleLarge(onBg)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            fullscreenDialog: true,
            builder: (_) => const AlarmScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ).animate().scale(delay: 150.ms, duration: 200.ms),
      body: Column(
        children: [
          if (_exactAlarmGranted == false)
            _WarningBanner(
              isDark: isDark,
              message: 'Exact alarms are off in system settings — alarms may fire late.',
              onFix: () async {
                await NotificationService.instance.requestPermissions();
                final granted =
                    await NotificationService.instance.hasExactAlarmPermission();
                if (mounted) setState(() => _exactAlarmGranted = granted);
              },
            ),
          if (_batteryOptimized == true)
            _WarningBanner(
              isDark: isDark,
              message: 'Battery optimization active — alarms may not ring. Tap Fix. On Samsung, also check Settings → Device Care → Battery → App Power Management → remove Ryve from sleeping apps.',
              onFix: () async {
                await NotificationService.instance.requestIgnoreBatteryOptimizations();
                final ignoring =
                    await NotificationService.instance.isIgnoringBatteryOptimizations();
                if (mounted) setState(() => _batteryOptimized = !ignoring);
              },
            ),
          Expanded(child: _AlarmList(alarmsAsync: alarmsAsync, muted: muted)),
        ],
      ),
      bottomNavigationBar: RyveBottomNav(
        currentIndex: 2,
        onTap: (i) {
          switch (i) {
            case 0: context.go('/'); break;
            case 1: context.go('/tasks'); break;
            case 2: break;
            case 3: context.go('/sleep'); break;
            case 4: context.go('/focus'); break;
            case 5: context.go('/profile'); break;
          }
        },
      ),
      ),
    );
  }
}

class _WarningBanner extends StatelessWidget {
  final bool isDark;
  final String message;
  final VoidCallback onFix;

  const _WarningBanner({
    required this.isDark,
    required this.message,
    required this.onFix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: isDark ? 0.16 : 0.12),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodySmall(
                isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground,
              ),
            ),
          ),
          TextButton(
            onPressed: onFix,
            child: const Text('Fix'),
          ),
        ],
      ),
    );
  }
}

class _AlarmList extends StatelessWidget {
  final AsyncValue<List<AlarmModel>> alarmsAsync;
  final Color muted;

  const _AlarmList({required this.alarmsAsync, required this.muted});

  @override
  Widget build(BuildContext context) {
    return alarmsAsync.when(
        loading: () => ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: const [
            SkeletonWidget(width: double.infinity, height: 72),
            SizedBox(height: AppSpacing.md),
            SkeletonWidget(width: double.infinity, height: 72),
          ],
        ),
        error: (_, __) => Center(
          child: Text('Failed to load alarms', style: AppTypography.bodyMedium(muted)),
        ),
        data: (alarms) {
          if (alarms.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.alarm_off, size: 56, color: muted),
                    const SizedBox(height: AppSpacing.md),
                    Text('No alarms set', style: AppTypography.bodyMedium(muted)),
                    const SizedBox(height: AppSpacing.sm),
                    Text('Tap + to add a wake-up alarm', style: AppTypography.bodySmall(muted)),
                  ],
                ),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.x4l,
            ),
            children: alarms.asMap().entries.map((entry) {
              return AlarmCardWidget(alarm: entry.value)
                  .animate(delay: (entry.key * 30).ms)
                  .fadeIn(duration: 220.ms)
                  .slideY(begin: 0.05, end: 0);
            }).toList(),
          );
        },
      );
  }
}
