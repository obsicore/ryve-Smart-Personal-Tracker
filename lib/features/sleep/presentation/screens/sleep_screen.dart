import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/sleep/data/models/sleep_log_model.dart';
import 'package:hybrid_tracker/features/sleep/domain/providers/sleep_providers.dart';
import 'package:hybrid_tracker/features/sleep/presentation/screens/alarm_screen.dart';
import 'package:hybrid_tracker/features/sleep/presentation/screens/log_sleep_screen.dart';
import 'package:hybrid_tracker/features/sleep/presentation/widgets/alarm_card_widget.dart';
import 'package:hybrid_tracker/shared/widgets/ryve_bottom_nav.dart';
import 'package:hybrid_tracker/shared/widgets/skeleton_widget.dart';

class SleepScreen extends ConsumerWidget {
  const SleepScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondary = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    final lastLogAsync = ref.watch(lastSleepLogProvider);
    final recentLogsAsync = ref.watch(recentSleepLogsProvider);
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
        title: Text('Sleep', style: AppTypography.titleLarge(onBg)),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: primary),
            tooltip: 'Log sleep',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                fullscreenDialog: true,
                builder: (_) => const LogSleepScreen(),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Last night card
            lastLogAsync.when(
              loading: () => SkeletonWidget(width: double.infinity, height: 120),
              error: (_, __) => const SizedBox.shrink(),
              data: (log) => _LastNightCard(log: log, isDark: isDark, primary: primary, secondary: secondary, muted: muted),
            ).animate().fadeIn(duration: 280.ms).slideY(begin: 0.06, end: 0),

            const SizedBox(height: AppSpacing.xxl),

            // Weekly chart
            Text('This Week', style: AppTypography.titleMedium(onBg)),
            const SizedBox(height: AppSpacing.md),
            recentLogsAsync.when(
              loading: () => SkeletonWidget(width: double.infinity, height: 160),
              error: (_, __) => const SizedBox.shrink(),
              data: (logs) => _WeeklyChart(logs: logs, isDark: isDark),
            ).animate(delay: 80.ms).fadeIn(duration: 250.ms),

            const SizedBox(height: AppSpacing.xxl),

            // Alarms section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Alarms', style: AppTypography.titleMedium(onBg)),
                TextButton.icon(
                  icon: Icon(Icons.add, size: 18, color: primary),
                  label: Text('Add', style: AppTypography.labelMedium(primary)),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      fullscreenDialog: true,
                      builder: (_) => const AlarmScreen(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            alarmsAsync.when(
              loading: () => SkeletonWidget(width: double.infinity, height: 72),
              error: (_, __) => const SizedBox.shrink(),
              data: (alarms) {
                if (alarms.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
                      child: Column(
                        children: [
                          Icon(Icons.alarm_off, size: 48, color: muted),
                          const SizedBox(height: AppSpacing.sm),
                          Text('No alarms set', style: AppTypography.bodyMedium(muted)),
                        ],
                      ),
                    ),
                  );
                }
                return Column(
                  children: alarms.asMap().entries.map((entry) {
                    return AlarmCardWidget(alarm: entry.value)
                        .animate(delay: (entry.key * 30).ms)
                        .fadeIn(duration: 220.ms)
                        .slideY(begin: 0.05, end: 0);
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: AppSpacing.x4l),
          ],
        ),
      ),
      bottomNavigationBar: RyveBottomNav(
        currentIndex: 3,
        onTap: (i) {
          switch (i) {
            case 0: context.go('/'); break;
            case 1: context.go('/tasks'); break;
            case 2: context.go('/alarms'); break;
            case 3: break;
            case 4: context.go('/focus'); break;
            case 5: context.go('/profile'); break;
          }
        },
      ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Last night card
// ---------------------------------------------------------------------------
class _LastNightCard extends StatelessWidget {
  final SleepLogModel? log;
  final bool isDark;
  final Color primary;
  final Color secondary;
  final Color muted;

  const _LastNightCard({
    required this.log,
    required this.isDark,
    required this.primary,
    required this.secondary,
    required this.muted,
  });

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;

    if (log == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: isDark ? Border.all(color: AppColors.darkSurfaceBright) : null,
        ),
        child: Column(
          children: [
            Icon(Icons.bedtime_outlined, size: 40, color: muted),
            const SizedBox(height: AppSpacing.sm),
            Text('No sleep logged yet', style: AppTypography.bodyMedium(muted)),
            const SizedBox(height: AppSpacing.sm),
            Text('Tap + to log last night\'s sleep', style: AppTypography.bodySmall(muted)),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: isDark ? Border.all(color: AppColors.darkSurfaceBright) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Last Night', style: AppTypography.labelMedium(muted)),
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(log!.formattedDuration, style: AppTypography.displayMedium(secondary)),
              const SizedBox(width: AppSpacing.md),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: _QualityStars(rating: log!.qualityRating, primary: primary),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(Icons.bedtime_outlined, size: 14, color: muted),
              const SizedBox(width: AppSpacing.xs),
              Text(_formatTime(log!.bedtime), style: AppTypography.bodySmall(onSurface)),
              const SizedBox(width: AppSpacing.lg),
              Icon(Icons.wb_sunny_outlined, size: 14, color: muted),
              const SizedBox(width: AppSpacing.xs),
              Text(_formatTime(log!.wakeTime), style: AppTypography.bodySmall(onSurface)),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour;
    final m = dt.minute;
    final period = h >= 12 ? 'PM' : 'AM';
    final displayH = h > 12 ? h - 12 : (h == 0 ? 12 : h);
    return '$displayH:${m.toString().padLeft(2, '0')} $period';
  }
}

class _QualityStars extends StatelessWidget {
  final int rating;
  final Color primary;
  const _QualityStars({required this.rating, required this.primary});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        return Icon(
          i < rating ? Icons.star_rounded : Icons.star_outline_rounded,
          size: 16,
          color: i < rating ? primary : AppColors.darkOnSurfaceMuted,
        );
      }),
    );
  }
}

// ---------------------------------------------------------------------------
// Weekly bar chart
// ---------------------------------------------------------------------------
class _WeeklyChart extends StatelessWidget {
  final List<SleepLogModel> logs;
  final bool isDark;

  const _WeeklyChart({required this.logs, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    final now = DateTime.now();
    final days = List.generate(7, (i) => DateTime(now.year, now.month, now.day - (6 - i)));
    final labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    final barGroups = days.asMap().entries.map((entry) {
      final day = entry.value;
      final log = logs.where((l) {
        final ld = l.bedtime;
        return ld.year == day.year && ld.month == day.month && ld.day == day.day;
      }).firstOrNull;

      final hours = log?.hours ?? 0.0;
      final color = hours >= 7 ? AppColors.darkSecondary : hours >= 5 ? AppColors.warning : hours > 0 ? AppColors.error : AppColors.darkSurfaceBright;

      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: hours.clamp(0, 12),
            color: color,
            width: 18,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ],
      );
    }).toList();

    return Container(
      height: 160,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: isDark ? Border.all(color: AppColors.darkSurfaceBright) : null,
      ),
      child: BarChart(
        BarChartData(
          maxY: 12,
          barGroups: barGroups,
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) => Text(
                  labels[v.toInt() % 7],
                  style: TextStyle(fontSize: 11, color: muted),
                ),
              ),
            ),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(
                y: 8,
                color: AppColors.darkPrimary.withValues(alpha: 0.5),
                strokeWidth: 1,
                dashArray: [4, 4],
              ),
            ],
          ),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
          barTouchData: BarTouchData(enabled: false),
        ),
        duration: const Duration(milliseconds: 400),
      ),
    );
  }
}
