import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_animations.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';

class StreakCardWidget extends StatefulWidget {
  final int streak;

  const StreakCardWidget({super.key, required this.streak});

  @override
  State<StreakCardWidget> createState() => _StreakCardWidgetState();
}

class _StreakCardWidgetState extends State<StreakCardWidget> {
  double _scale = 1.0;

  double get _flameScale =>
      0.8 + (math.min(widget.streak, 100) / 100) * 0.7;

  @override
  Widget build(BuildContext context) {
    final disableAnims = MediaQuery.of(context).disableAnimations;

    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.97),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: AppAnimations.fast,
        curve: AppAnimations.smooth,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF2A1F00),
                Color(0xFF3D2D00),
                Color(0xFF4A3500),
              ],
            ),
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: AppColors.darkPrimary.withOpacity(0.6),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('🔥', style: TextStyle(fontSize: 22)),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            '${widget.streak}-Day Streak',
                            style: AppTypography.titleLarge(
                              AppColors.darkPrimary,
                            ).copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        widget.streak >= 7
                            ? 'On fire! Keep it up! 🚀'
                            : 'Keep building the habit!',
                        style: AppTypography.bodyMedium(
                          AppColors.darkPrimaryVariant.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _StreakProgressBar(streak: widget.streak),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: widget.streak > 0 && !disableAnims
                      ? Transform.scale(
                          scale: _flameScale,
                          child: Lottie.asset(
                            'assets/animations/flame.json',
                            repeat: true,
                            animate: true,
                          ),
                        )
                      : const Center(
                          child: Text('🔥', style: TextStyle(fontSize: 48)),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StreakProgressBar extends StatelessWidget {
  final int streak;

  const _StreakProgressBar({required this.streak});

  @override
  Widget build(BuildContext context) {
    final progress = math.min(streak / 30.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.full),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.darkPrimary.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.darkPrimary,
            ),
            minHeight: 6,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          '${streak} / 30 days',
          style: AppTypography.bodySmall(
            AppColors.darkPrimary.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
