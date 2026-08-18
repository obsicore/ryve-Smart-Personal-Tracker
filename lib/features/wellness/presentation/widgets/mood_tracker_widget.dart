import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';

const moodFaces = ['😭', '😢', '😟', '😕', '😐', '🙂', '😊', '😄', '😁', '🤩'];

const moodFactors = [
  'stress',
  'family',
  'work',
  'health',
  'social',
  'sleep',
];

class MoodTrackerWidget extends StatelessWidget {
  final int? moodScore;
  final ValueChanged<int> onMoodChanged;
  final List<String> selectedFactors;
  final ValueChanged<String> onFactorToggled;

  const MoodTrackerWidget({
    super.key,
    required this.moodScore,
    required this.onMoodChanged,
    required this.selectedFactors,
    required this.onFactorToggled,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

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
          Text('How are you feeling?', style: AppTypography.titleMedium(onBg)),
          const SizedBox(height: AppSpacing.lg),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: moodFaces.asMap().entries.map((entry) {
                final rating = entry.key + 1;
                final isSelected = moodScore == rating;
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      onMoodChanged(rating);
                    },
                    child: AnimatedScale(
                      scale: isSelected ? 1.3 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.elasticOut,
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? primary.withOpacity(0.15) : Colors.transparent,
                        ),
                        child: Text(entry.value, style: const TextStyle(fontSize: 24)),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Factors', style: AppTypography.labelMedium(muted)),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: moodFactors.map((factor) {
              final isSelected = selectedFactors.contains(factor);
              return GestureDetector(
                onTap: () => onFactorToggled(factor),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: isSelected ? primary.withOpacity(0.15) : (isDark ? AppColors.darkSurfaceBright : AppColors.lightSurfaceVariant),
                    borderRadius: BorderRadius.circular(AppRadius.full),
                    border: Border.all(color: isSelected ? primary : Colors.transparent),
                  ),
                  child: Text(
                    factor,
                    style: AppTypography.labelMedium(isSelected ? primary : muted),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
