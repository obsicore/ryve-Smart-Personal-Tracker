import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';

void showLevelUpCelebration(BuildContext context, int newLevel) {
  final overlay = Overlay.maybeOf(context, rootOverlay: true);
  if (overlay == null) return;

  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => _LevelUpScreen(
      level: newLevel,
      onContinue: () {
        if (entry.mounted) entry.remove();
      },
    ),
  );
  overlay.insert(entry);
}

class _LevelUpScreen extends StatelessWidget {
  const _LevelUpScreen({required this.level, required this.onContinue});

  final int level;
  final VoidCallback onContinue;

  bool get _isMilestone => level % 5 == 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.85),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: Lottie.asset(
                'assets/animations/level_up.json',
                repeat: false,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'LEVEL $level',
                style: AppTypography.displayLarge(AppColors.darkPrimary),
              )
                  .animate()
                  .scale(
                    delay: 500.ms,
                    begin: const Offset(0, 0),
                    end: const Offset(1, 1),
                    duration: 400.ms,
                    curve: Curves.elasticOut,
                  )
                  .fadeIn(delay: 500.ms, duration: 200.ms),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Unlocked!',
                style: AppTypography.titleMedium(AppColors.darkOnBackground),
              ).animate().fadeIn(delay: 900.ms, duration: 300.ms),
              if (_isMilestone) ...[
                const SizedBox(height: AppSpacing.md),
                Text(
                  '🏅 Milestone badge unlocked',
                  style: AppTypography.bodyMedium(AppColors.darkSecondary),
                ).animate().fadeIn(delay: 1200.ms, duration: 250.ms),
              ],
              const SizedBox(height: AppSpacing.x4l),
              ElevatedButton(
                onPressed: onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkPrimary,
                  foregroundColor: AppColors.darkOnPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.x3l,
                    vertical: AppSpacing.md,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text('Continue'),
              ).animate().fadeIn(delay: 3000.ms, duration: 300.ms),
            ],
          ),
        ],
      ),
    );
  }
}
