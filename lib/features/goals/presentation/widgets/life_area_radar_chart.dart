import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/features/goals/data/models/life_area_score_model.dart';
import 'package:hybrid_tracker/features/goals/domain/life_area_meta.dart';

class LifeAreaRadarChart extends StatelessWidget {
  final LifeAreaScoreModel? score;

  const LifeAreaRadarChart({super.key, this.score});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    final values = score?.asMap ??
        {
          'health': 0,
          'work': 0,
          'finance': 0,
          'relationships': 0,
          'personal_growth': 0,
          'learning': 0,
          'recreation': 0,
        };

    return Container(
      height: 280,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: isDark ? Border.all(color: AppColors.darkSurfaceBright) : null,
      ),
      child: RadarChart(
        RadarChartData(
          radarShape: RadarShape.polygon,
          tickCount: 5,
          ticksTextStyle: const TextStyle(fontSize: 0, color: Colors.transparent),
          radarBorderData: BorderSide(color: muted.withOpacity(0.3)),
          gridBorderData: BorderSide(color: muted.withOpacity(0.2)),
          tickBorderData: BorderSide(color: muted.withOpacity(0.15)),
          titlePositionPercentageOffset: 0.15,
          getTitle: (index, angle) {
            final key = values.keys.elementAt(index);
            final meta = metaFor(key);
            return RadarChartTitle(text: '${meta.emoji}');
          },
          titleTextStyle: TextStyle(fontSize: 14, color: muted),
          dataSets: [
            RadarDataSet(
              fillColor: primary.withOpacity(0.2),
              borderColor: primary,
              entryRadius: 3,
              dataEntries: values.values.map((v) => RadarEntry(value: v.toDouble())).toList(),
            ),
            RadarDataSet(
              fillColor: Colors.transparent,
              borderColor: muted.withOpacity(0.3),
              entryRadius: 0,
              dataEntries: List.generate(values.length, (_) => const RadarEntry(value: 10)),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 400),
      ),
    );
  }
}
