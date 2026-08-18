import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';

class TimerRing extends StatelessWidget {
  const TimerRing({
    super.key,
    required this.progress,
    required this.timeText,
    required this.label,
    required this.ringColor,
    this.strokeWidth = 12.0,
  });

  final double progress;
  final String timeText;
  final String label;
  final Color ringColor;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final trackColor =
        isDark ? AppColors.darkSurfaceBright : AppColors.lightSurfaceBright;
    final textColor =
        isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final mutedColor =
        isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: progress, end: progress),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
      builder: (context, animated, _) {
        return CustomPaint(
          painter: _TimerRingPainter(
            progress: animated,
            trackColor: trackColor,
            ringColor: ringColor,
            strokeWidth: strokeWidth,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(timeText, style: AppTypography.displayLarge(textColor)),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  label,
                  style: AppTypography.labelMedium(mutedColor),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TimerRingPainter extends CustomPainter {
  const _TimerRingPainter({
    required this.progress,
    required this.trackColor,
    required this.ringColor,
    required this.strokeWidth,
  });

  final double progress;
  final Color trackColor;
  final Color ringColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    if (progress > 0) {
      final progressPaint = Paint()
        ..color = ringColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        rect,
        -math.pi / 2,
        2 * math.pi * progress.clamp(0.0, 1.0),
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_TimerRingPainter old) =>
      old.progress != progress ||
      old.ringColor != ringColor ||
      old.trackColor != trackColor;
}
