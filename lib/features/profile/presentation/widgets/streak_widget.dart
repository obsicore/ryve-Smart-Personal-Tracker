import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';

class StreakWidget extends StatelessWidget {
  const StreakWidget({
    super.key,
    required this.currentStreak,
    required this.bestStreak,
  });

  final int currentStreak;
  final int bestStreak;

  double get _flameScale {
    // 1.0 at 1 day → 1.3 at 30 days → 1.5 at 100 days, clamped
    final t = math.min(currentStreak, 100) / 100.0;
    return 1.0 + (t * 0.5);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final disableAnimations = MediaQuery.of(context).disableAnimations;

    final surfaceVariant =
        isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant;
    final textColor =
        isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final mutedColor =
        isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final goldColor =
        isDark ? AppColors.darkPrimary : AppColors.lightAccent;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: surfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: goldColor.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Flame Lottie
          Transform.scale(
            scale: _flameScale.clamp(1.0, 1.5),
            child: SizedBox(
              width: 60,
              height: 60,
              child: disableAnimations
                  ? const Text('🔥', style: TextStyle(fontSize: 36))
                  : Lottie.asset(
                      'assets/animations/flame.json',
                      width: 60,
                      height: 60,
                      repeat: true,
                      animate: true,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) =>
                          const Text('🔥', style: TextStyle(fontSize: 36)),
                    ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),

          // Center: label + streak count
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Streak',
                  style: TextStyle(
                    color: mutedColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '$currentStreak days',
                  style: TextStyle(
                    color: goldColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),

          // Right: best streak
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Best',
                style: TextStyle(
                  color: mutedColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '$bestStreak days',
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
