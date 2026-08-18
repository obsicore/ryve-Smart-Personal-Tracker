import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hybrid_tracker/core/theme/app_animations.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/wellness/domain/providers/wellness_providers.dart';

class StepCountWidget extends ConsumerWidget {
  const StepCountWidget({super.key, this.goalSteps = 8000});

  final int goalSteps;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final disableAnims = MediaQuery.of(context).disableAnimations;

    final todayAsync = ref.watch(todayStepsProvider);
    final yesterdayAsync = ref.watch(yesterdayStepsProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: isDark ? Border.all(color: AppColors.darkSurfaceBright) : null,
      ),
      child: todayAsync.when(
        loading: () => const SizedBox(height: 140, child: Center(child: CircularProgressIndicator())),
        error: (_, __) => const SizedBox.shrink(),
        data: (today) {
          final steps = today?.stepCount ?? 0;
          final progress = (steps / goalSteps).clamp(0.0, 1.0);
          final yesterday = yesterdayAsync.valueOrNull?.stepCount ?? 0;
          final trendUp = steps >= yesterday;

          return Row(
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progress),
                duration: disableAnims ? Duration.zero : AppAnimations.slow,
                curve: AppAnimations.smooth,
                builder: (context, value, _) => CustomPaint(
                  size: const Size(84, 84),
                  painter: _StepArcPainter(progress: value, color: primary, track: isDark ? AppColors.darkSurfaceBright : AppColors.lightSurfaceVariant),
                  child: SizedBox(
                    width: 84,
                    height: 84,
                    child: Center(child: Icon(Icons.directions_walk_rounded, color: primary, size: 28)),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Steps', style: AppTypography.labelMedium(muted)),
                    Text('$steps', style: AppTypography.headlineLarge(onBg)),
                    Row(
                      children: [
                        Icon(trendUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, size: 14, color: trendUp ? AppColors.success : AppColors.error),
                        const SizedBox(width: 4),
                        Text('vs yesterday: $yesterday', style: AppTypography.bodySmall(muted)),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    GestureDetector(
                      onTap: () => _showManualEntryDialog(context, ref, steps),
                      child: Row(
                        children: [
                          Icon(Icons.edit_outlined, size: 14, color: primary),
                          const SizedBox(width: 4),
                          Text('Log manually', style: AppTypography.labelSmall(primary)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showManualEntryDialog(BuildContext context, WidgetRef ref, int current) async {
    final controller = TextEditingController(text: current > 0 ? current.toString() : '');
    final result = await showDialog<int>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log steps'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: const InputDecoration(suffixText: 'steps'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(int.tryParse(controller.text)),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null && result >= 0) {
      await ref.read(wellnessNotifierProvider.notifier).logSteps(result);
    }
  }
}

class _StepArcPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color track;

  const _StepArcPainter({required this.progress, required this.color, required this.track});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(5, 5, size.width - 10, size.height - 10);
    const startAngle = -math.pi / 2;
    const sweepFull = math.pi * 2;

    final trackPaint = Paint()
      ..color = track
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweepFull, false, trackPaint);
    canvas.drawArc(rect, startAngle, sweepFull * progress, false, progressPaint);
  }

  @override
  bool shouldRepaint(_StepArcPainter old) => old.progress != progress;
}
