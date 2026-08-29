import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:hybrid_tracker/core/router/app_router.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/wellness/domain/providers/wellness_providers.dart';
import 'package:hybrid_tracker/features/wellness/presentation/widgets/energy_slider_widget.dart';
import 'package:hybrid_tracker/features/wellness/presentation/widgets/mood_history_chart.dart';
import 'package:hybrid_tracker/features/wellness/presentation/widgets/mood_tracker_widget.dart';
import 'package:hybrid_tracker/features/wellness/presentation/widgets/step_count_widget.dart';
import 'package:hybrid_tracker/features/wellness/presentation/widgets/water_tracker_widget.dart';
import 'package:hybrid_tracker/features/wellness/presentation/widgets/workout_log_sheet.dart';
import 'package:hybrid_tracker/shared/widgets/skeleton_widget.dart';

class WellnessScreen extends ConsumerStatefulWidget {
  const WellnessScreen({super.key});

  @override
  ConsumerState<WellnessScreen> createState() => _WellnessScreenState();
}

class _WellnessScreenState extends ConsumerState<WellnessScreen> {
  int? _moodScore;
  int _energyLevel = 5;
  final List<String> _factors = [];
  bool _saving = false;

  Future<void> _saveCheckIn() async {
    if (_moodScore == null) return;
    setState(() => _saving = true);
    await ref.read(wellnessNotifierProvider.notifier).logMood(
          moodScore: _moodScore!,
          energyScore: _energyLevel,
          factors: _factors,
        );
    await ref.read(wellnessNotifierProvider.notifier).logEnergy(_energyLevel);
    if (mounted) {
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Check-in saved'), duration: Duration(seconds: 1)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondary = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    final moodLogsAsync = ref.watch(recentMoodLogsProvider);
    final todayMoodAsync = ref.watch(todayMoodProvider);

    return Scaffold(
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
        title: Text('Wellness', style: AppTypography.titleLarge(onBg)),
        actions: [
          IconButton(
            icon: Icon(Icons.self_improvement_outlined, color: primary),
            tooltip: 'Breathing exercise',
            onPressed: () => context.push(Routes.breathing),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            todayMoodAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (todayMood) {
                _moodScore ??= todayMood?.moodScore;
                return MoodTrackerWidget(
                  moodScore: _moodScore,
                  onMoodChanged: (m) => setState(() => _moodScore = m),
                  selectedFactors: _factors,
                  onFactorToggled: (f) => setState(() {
                    _factors.contains(f) ? _factors.remove(f) : _factors.add(f);
                  }),
                );
              },
            ).animate().fadeIn(duration: 280.ms).slideY(begin: 0.06, end: 0),

            const SizedBox(height: AppSpacing.lg),

            EnergySliderWidget(
              energyLevel: _energyLevel,
              onChanged: (v) => setState(() => _energyLevel = v),
            ).animate(delay: 60.ms).fadeIn(duration: 250.ms),

            const SizedBox(height: AppSpacing.lg),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_moodScore == null || _saving) ? null : _saveCheckIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
                ),
                child: Text(
                  'Save Check-in',
                  style: AppTypography.labelLarge(isDark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary),
                ),
              ),
            ).animate(delay: 100.ms).fadeIn(duration: 250.ms),

            const SizedBox(height: AppSpacing.xxl),

            const WaterTrackerWidget().animate(delay: 120.ms).fadeIn(duration: 250.ms).slideY(begin: 0.05, end: 0),

            const SizedBox(height: AppSpacing.lg),

            const StepCountWidget().animate(delay: 160.ms).fadeIn(duration: 250.ms).slideY(begin: 0.05, end: 0),

            const SizedBox(height: AppSpacing.xxl),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mood Trend', style: AppTypography.titleMedium(onBg)),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            moodLogsAsync.when(
              loading: () => const SkeletonWidget(width: double.infinity, height: 160),
              error: (_, __) => const SizedBox.shrink(),
              data: (logs) => MoodHistoryChart(logs: logs),
            ).animate(delay: 200.ms).fadeIn(duration: 250.ms),

            const SizedBox(height: AppSpacing.xxl),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Workouts', style: AppTypography.titleMedium(onBg)),
                TextButton.icon(
                  icon: Icon(Icons.add, size: 18, color: secondary),
                  label: Text('Log', style: AppTypography.labelMedium(secondary)),
                  onPressed: () => showWorkoutLogSheet(context),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            _RecentWorkouts(secondary: secondary, muted: muted, onBg: onBg),

            const SizedBox(height: AppSpacing.x4l),
          ],
        ),
      ),
    );
  }
}

class _RecentWorkouts extends ConsumerWidget {
  final Color secondary;
  final Color muted;
  final Color onBg;

  const _RecentWorkouts({required this.secondary, required this.muted, required this.onBg});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final workoutsAsync = ref.watch(recentWorkoutsProvider);

    return workoutsAsync.when(
      loading: () => const SkeletonWidget(width: double.infinity, height: 72),
      error: (_, __) => const SizedBox.shrink(),
      data: (workouts) {
        if (workouts.isEmpty) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
            alignment: Alignment.center,
            child: Text('No workouts logged yet', style: AppTypography.bodyMedium(muted)),
          );
        }
        return Column(
          children: workouts.take(5).map((w) {
            return Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: isDark ? Border.all(color: AppColors.darkSurfaceBright) : null,
              ),
              child: Row(
                children: [
                  Icon(Icons.fitness_center_rounded, color: secondary, size: 20),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      w.workoutType[0].toUpperCase() + w.workoutType.substring(1),
                      style: AppTypography.bodyMedium(onBg),
                    ),
                  ),
                  if (w.durationMin != null)
                    Text('${w.durationMin} min', style: AppTypography.bodySmall(muted)),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
