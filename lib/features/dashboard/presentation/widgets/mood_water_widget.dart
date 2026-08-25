import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_animations.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/core/utils/wellness_constants.dart';
import 'package:hybrid_tracker/features/wellness/domain/providers/wellness_providers.dart';
import 'package:hybrid_tracker/shared/widgets/xp_float_overlay.dart';

class MoodWaterWidget extends ConsumerWidget {
  const MoodWaterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(child: _MoodCard()),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: _WaterCard()),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Mood Card
// ---------------------------------------------------------------------------

class _MoodCard extends ConsumerWidget {
  static const _moods = [
    (emoji: '😫', rating: 1),
    (emoji: '😕', rating: 3),
    (emoji: '😐', rating: 5),
    (emoji: '🙂', rating: 7),
    (emoji: '😄', rating: 10),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final todayMoodAsync = ref.watch(todayMoodProvider);
    final selectedMood = todayMoodAsync.valueOrNull?.moodScore;
    final disableAnims = MediaQuery.of(context).disableAnimations;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: isDark
              ? AppColors.darkSurfaceBright
              : Colors.transparent,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mood',
            style: AppTypography.labelMedium(muted),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            selectedMood == null
                ? 'How are you?'
                : _moodLabel(selectedMood),
            style: AppTypography.bodyMedium(onSurface)
                .copyWith(fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _moods.map((mood) {
              final isSelected = selectedMood == mood.rating;
              final neighborDist = selectedMood != null
                  ? (_moods.indexWhere((m) => m.rating == mood.rating) -
                          _moods.indexWhere((m) => m.rating == selectedMood))
                      .abs()
                  : 0;
              final scale = isSelected
                  ? 1.4
                  : (neighborDist == 1 ? 0.9 : 1.0);

              return GestureDetector(
                onTap: () {
                  ref.read(wellnessNotifierProvider.notifier).logMood(moodScore: mood.rating);
                  XpFloatOverlay.show(context, 2);
                },
                child: AnimatedScale(
                  scale: scale,
                  duration: disableAnims
                      ? Duration.zero
                      : AppAnimations.moderate,
                  curve: AppAnimations.spring,
                  child: Text(
                    mood.emoji,
                    style: TextStyle(
                      fontSize: 22,
                      shadows: isSelected
                          ? [
                              Shadow(
                                color: AppColors.darkPrimary,
                                blurRadius: 8,
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _moodLabel(int rating) => switch (rating) {
        1 => 'Exhausted',
        3 => 'Not great',
        5 => 'Okay',
        7 => 'Good',
        10 => 'Amazing!',
        _ => '',
      };
}

// ---------------------------------------------------------------------------
// Water Card
// ---------------------------------------------------------------------------

class _WaterCard extends ConsumerWidget {
  static const _goalMl = defaultWaterGoalMl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final secondary = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;
    final logsAsync = ref.watch(todayWaterLogsProvider);
    final waterMl = logsAsync.valueOrNull?.fold<int>(0, (sum, l) => sum + l.amountMl) ?? 0;
    final disableAnims = MediaQuery.of(context).disableAnimations;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: isDark
              ? AppColors.darkSurfaceBright
              : Colors.transparent,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Water', style: AppTypography.labelMedium(muted)),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${waterMl}ml',
            style: AppTypography.bodyMedium(onSurface)
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: _WaterArc(
              waterMl: waterMl,
              goalMl: _goalMl,
              color: secondary,
              disableAnims: disableAnims,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              _QuickAddButton(
                label: '+150',
                onTap: () {
                  ref.read(wellnessNotifierProvider.notifier).logWater(150);
                  XpFloatOverlay.show(context, 2);
                },
                color: secondary,
              ),
              const SizedBox(width: AppSpacing.xs),
              _QuickAddButton(
                label: '+250',
                onTap: () {
                  ref.read(wellnessNotifierProvider.notifier).logWater(250);
                  XpFloatOverlay.show(context, 2);
                },
                color: secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WaterArc extends StatelessWidget {
  final int waterMl;
  final int goalMl;
  final Color color;
  final bool disableAnims;

  const _WaterArc({
    required this.waterMl,
    required this.goalMl,
    required this.color,
    required this.disableAnims,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (waterMl / goalMl).clamp(0.0, 1.0);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: progress),
      duration: disableAnims ? Duration.zero : AppAnimations.slow,
      curve: AppAnimations.smooth,
      builder: (context, value, _) {
        return CustomPaint(
          size: const Size(72, 72),
          painter: _ArcPainter(progress: value, color: color),
          child: SizedBox(
            width: 72,
            height: 72,
            child: Center(
              child: Text(
                '💧',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;
  final Color color;

  const _ArcPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(4, 4, size.width - 8, size.height - 8);
    const startAngle = math.pi * 0.75;
    const sweepFull = math.pi * 1.5;

    final trackPaint = Paint()
      ..color = color.withOpacity(0.15)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweepFull, false, trackPaint);
    canvas.drawArc(
        rect, startAngle, sweepFull * progress, false, progressPaint);
  }

  @override
  bool shouldRepaint(_ArcPainter old) => old.progress != progress;
}

class _QuickAddButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _QuickAddButton({
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTypography.labelMedium(color),
          ),
        ),
      ),
    );
  }
}
