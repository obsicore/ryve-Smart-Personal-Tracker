import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/features/wellness/data/models/mood_log_model.dart';

class MoodHistoryChart extends StatelessWidget {
  final List<MoodLogModel> logs;

  const MoodHistoryChart({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    final now = DateTime.now();
    final days = List.generate(7, (i) => DateTime(now.year, now.month, now.day - (6 - i)));
    final labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    final spots = days.asMap().entries.map((entry) {
      final day = entry.value;
      final dayLogs = logs.where((l) => l.logDate.year == day.year && l.logDate.month == day.month && l.logDate.day == day.day);
      final avg = dayLogs.isEmpty ? null : dayLogs.map((l) => l.moodScore).reduce((a, b) => a + b) / dayLogs.length;
      return avg == null ? null : FlSpot(entry.key.toDouble(), avg);
    }).whereType<FlSpot>().toList();

    return Container(
      height: 160,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: isDark ? Border.all(color: AppColors.darkSurfaceBright) : null,
      ),
      child: spots.isEmpty
          ? Center(child: Text('No mood logs yet', style: TextStyle(color: muted, fontSize: 13)))
          : LineChart(
              LineChartData(
                minY: 0,
                maxY: 10,
                lineTouchData: const LineTouchData(enabled: false),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) => Text(labels[v.toInt() % 7], style: TextStyle(fontSize: 11, color: muted)),
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: primary,
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(show: true, color: primary.withOpacity(0.1)),
                  ),
                ],
              ),
              duration: const Duration(milliseconds: 400),
            ),
    );
  }
}
