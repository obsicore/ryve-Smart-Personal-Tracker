import 'package:flutter/material.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';

class EnergySliderWidget extends StatelessWidget {
  final int energyLevel;
  final ValueChanged<int> onChanged;

  const EnergySliderWidget({
    super.key,
    required this.energyLevel,
    required this.onChanged,
  });

  static const _labels = {
    1: 'Running on empty',
    2: 'Running on empty',
    3: 'Drained',
    4: 'Drained',
    5: 'Steady',
    6: 'Steady',
    7: 'Energized',
    8: 'Energized',
    9: 'Fully energized',
    10: 'Fully energized',
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Energy', style: AppTypography.titleMedium(onBg)),
              Text('$energyLevel/10', style: AppTypography.labelMedium(muted)),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppColors.warning,
              inactiveTrackColor: (isDark ? AppColors.darkSurfaceBright : AppColors.lightSurfaceVariant),
              thumbColor: AppColors.warning,
              overlayColor: AppColors.warning.withOpacity(0.15),
              trackHeight: 6,
            ),
            child: Slider(
              value: energyLevel.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (v) => onChanged(v.round()),
            ),
          ),
          Center(
            child: Text(_labels[energyLevel] ?? '', style: AppTypography.bodySmall(muted)),
          ),
        ],
      ),
    );
  }
}
