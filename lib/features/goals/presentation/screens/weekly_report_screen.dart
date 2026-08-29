import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/goals/data/models/weekly_report_model.dart';
import 'package:hybrid_tracker/features/goals/domain/providers/goals_providers.dart';
import 'package:hybrid_tracker/shared/widgets/empty_state_widget.dart';
import 'package:hybrid_tracker/shared/widgets/skeleton_widget.dart';

class WeeklyReportScreen extends ConsumerWidget {
  const WeeklyReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    final reportAsync = ref.watch(latestWeeklyReportProvider);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: onBg, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Weekly Report', style: AppTypography.titleLarge(onBg)),
      ),
      body: reportAsync.when(
        loading: () => Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(children: [
            const SkeletonWidget(width: double.infinity, height: 180),
            const SizedBox(height: AppSpacing.lg),
            const SkeletonWidget(width: double.infinity, height: 240),
          ]),
        ),
        error: (_, __) => Center(
          child: Text('Failed to load weekly report', style: AppTypography.bodyMedium(muted)),
        ),
        data: (report) {
          if (report == null) {
            return const EmptyStateWidget(
              svgAssetPath: 'assets/illustrations/goals_empty.svg',
              title: 'No report yet',
              subtitle: 'Keep logging habits, tasks and mood — your first weekly report generates automatically',
            );
          }
          return _ReportBody(report: report);
        },
      ),
    );
  }
}

class _ReportBody extends StatelessWidget {
  final WeeklyReportModel report;

  const _ReportBody({required this.report});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    final habitsPct = report.habitsTotal == 0 ? 0.0 : report.habitsCompleted / report.habitsTotal;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_fmt(report.weekStart)} – ${_fmt(report.weekEnd)}',
            style: AppTypography.bodyMedium(muted),
          ).animate().fadeIn(duration: 220.ms),
          const SizedBox(height: AppSpacing.lg),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.6,
            children: [
              _StatTile(
                label: 'Habits',
                value: '${report.habitsCompleted}/${report.habitsTotal}',
                sub: '${(habitsPct * 100).toStringAsFixed(0)}%',
                surface: surface,
                onSurface: onSurface,
                muted: muted,
                accent: primary,
              ),
              _StatTile(
                label: 'Tasks Done',
                value: '${report.tasksCompleted}',
                surface: surface,
                onSurface: onSurface,
                muted: muted,
                accent: primary,
              ),
              _StatTile(
                label: 'Focus Time',
                value: '${report.focusMinutes}m',
                surface: surface,
                onSurface: onSurface,
                muted: muted,
                accent: primary,
              ),
              _StatTile(
                label: 'Avg Mood',
                value: report.avgMood.toStringAsFixed(1),
                sub: '/ 10',
                surface: surface,
                onSurface: onSurface,
                muted: muted,
                accent: primary,
              ),
              _StatTile(
                label: 'Avg Sleep',
                value: '${report.avgSleepHours.toStringAsFixed(1)}h',
                surface: surface,
                onSurface: onSurface,
                muted: muted,
                accent: primary,
              ),
              _StatTile(
                label: 'XP Earned',
                value: '${report.xpEarned}',
                surface: surface,
                onSurface: onSurface,
                muted: muted,
                accent: primary,
              ),
            ],
          ).animate(delay: 60.ms).fadeIn(duration: 250.ms),
          if (report.aiSummary != null) ...[
            const SizedBox(height: AppSpacing.xxl),
            Text('Summary', style: AppTypography.titleMedium(onBg)),
            const SizedBox(height: AppSpacing.sm),
            _TextCard(text: report.aiSummary!, surface: surface, onSurface: onSurface),
          ],
          if (report.aiWins != null) ...[
            const SizedBox(height: AppSpacing.lg),
            Text('Wins', style: AppTypography.titleMedium(onBg)),
            const SizedBox(height: AppSpacing.sm),
            _TextCard(text: report.aiWins!, surface: surface, onSurface: onSurface),
          ],
          if (report.aiSuggestions != null) ...[
            const SizedBox(height: AppSpacing.lg),
            Text('Suggestions', style: AppTypography.titleMedium(onBg)),
            const SizedBox(height: AppSpacing.sm),
            _TextCard(text: report.aiSuggestions!, surface: surface, onSurface: onSurface),
          ],
          const SizedBox(height: AppSpacing.x4l),
        ],
      ),
    );
  }

  String _fmt(DateTime d) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[d.month - 1]} ${d.day}';
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  final String? sub;
  final Color surface;
  final Color onSurface;
  final Color muted;
  final Color accent;

  const _StatTile({
    required this.label,
    required this.value,
    this.sub,
    required this.surface,
    required this.onSurface,
    required this.muted,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: isDark ? Border.all(color: AppColors.darkSurfaceBright) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: AppTypography.labelSmall(muted)),
          const SizedBox(height: AppSpacing.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: AppTypography.titleLarge(onSurface)),
              if (sub != null) ...[
                const SizedBox(width: AppSpacing.xs),
                Text(sub!, style: AppTypography.labelSmall(accent)),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _TextCard extends StatelessWidget {
  final String text;
  final Color surface;
  final Color onSurface;

  const _TextCard({required this.text, required this.surface, required this.onSurface});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: isDark ? Border.all(color: AppColors.darkSurfaceBright) : null,
      ),
      child: Text(text, style: AppTypography.bodyMedium(onSurface)),
    );
  }
}
