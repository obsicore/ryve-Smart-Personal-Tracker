import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/goals/data/models/goal_model.dart';
import 'package:hybrid_tracker/features/goals/data/models/milestone_model.dart';
import 'package:hybrid_tracker/features/goals/domain/life_area_meta.dart';
import 'package:hybrid_tracker/features/goals/domain/providers/goals_providers.dart';
import 'package:hybrid_tracker/shared/widgets/skeleton_widget.dart';

class GoalDetailScreen extends ConsumerWidget {
  final String goalId;

  const GoalDetailScreen({super.key, required this.goalId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;

    final goalAsync = ref.watch(goalByIdProvider(goalId));

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Text('Goal', style: AppTypography.titleLarge(onBg)),
      ),
      body: goalAsync.when(
        loading: () => Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(children: [
            const SkeletonWidget(width: double.infinity, height: 200),
            const SizedBox(height: AppSpacing.lg),
            const SkeletonWidget(width: double.infinity, height: 120),
          ]),
        ),
        error: (_, __) => Center(child: Text('Failed to load goal', style: AppTypography.bodyMedium(onBg))),
        data: (goal) {
          if (goal == null) {
            return Center(child: Text('Goal not found', style: AppTypography.bodyMedium(onBg)));
          }
          return _GoalDetailBody(goal: goal);
        },
      ),
    );
  }
}

class _GoalDetailBody extends ConsumerWidget {
  final GoalModel goal;

  const _GoalDetailBody({required this.goal});

  Future<void> _updateProgress(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController(text: goal.currentValue.toString());
    final result = await showDialog<double>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Update progress'),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          autofocus: true,
          decoration: InputDecoration(suffixText: goal.unit),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(double.tryParse(controller.text)),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null) {
      await ref.read(goalNotifierProvider.notifier).updateProgress(goal.id, result);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final meta = metaFor(goal.lifeArea);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: meta.color.withOpacity(0.15), shape: BoxShape.circle),
                child: Text(goal.icon ?? meta.emoji, style: const TextStyle(fontSize: 28)),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal.title,
                      style: AppTypography.titleLarge(onBg),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('${meta.emoji} ${meta.label}', style: AppTypography.bodySmall(muted)),
                  ],
                ),
              ),
            ],
          ).animate().fadeIn(duration: 250.ms),
          if (goal.description != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(goal.description!, style: AppTypography.bodyMedium(muted)),
          ],
          const SizedBox(height: AppSpacing.xxl),

          Center(
            child: SizedBox(
              width: 160,
              height: 160,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: goal.progress),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, value, _) => CircularProgressIndicator(
                      value: value,
                      strokeWidth: 10,
                      backgroundColor: isDark ? AppColors.darkSurfaceBright : AppColors.lightSurfaceVariant,
                      valueColor: AlwaysStoppedAnimation(meta.color),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${(goal.progress * 100).toStringAsFixed(0)}%', style: AppTypography.headlineLarge(onBg)),
                      Text('${goal.currentValue.toStringAsFixed(0)}/${goal.targetValue.toStringAsFixed(0)}${goal.unit != null ? ' ${goal.unit}' : ''}', style: AppTypography.bodySmall(muted)),
                    ],
                  ),
                ],
              ),
            ),
          ).animate(delay: 60.ms).fadeIn(duration: 250.ms),

          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => _updateProgress(context, ref),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
                side: BorderSide(color: meta.color),
              ),
              child: Text('Update Progress', style: AppTypography.labelLarge(meta.color)),
            ),
          ),

          if (goal.milestones.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xxl),
            Text('Milestones', style: AppTypography.titleMedium(onBg)),
            const SizedBox(height: AppSpacing.md),
            ...goal.milestones.map((m) => _MilestoneTile(goalId: goal.id, milestone: m, surface: surface, onSurface: onSurface, muted: muted, accent: meta.color)),
          ],

          if (goal.linkedHabitIds.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xxl),
            Text('Linked Habits', style: AppTypography.titleMedium(onBg)),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              children: goal.linkedHabitIds
                  .map((id) => GestureDetector(
                        onTap: () => context.push('/habits/$id'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                          decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(AppRadius.full)),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.eco_outlined, size: 14, color: meta.color),
                            const SizedBox(width: AppSpacing.xs),
                            Text('Habit', style: AppTypography.labelSmall(onSurface)),
                          ]),
                        ),
                      ))
                  .toList(),
            ),
          ],

          if (goal.linkedTaskIds.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xxl),
            Text('Linked Tasks', style: AppTypography.titleMedium(onBg)),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              children: goal.linkedTaskIds
                  .map((id) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                        decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(AppRadius.full)),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(Icons.check_circle_outline, size: 14, color: meta.color),
                          const SizedBox(width: AppSpacing.xs),
                          Text('Task', style: AppTypography.labelSmall(onSurface)),
                        ]),
                      ))
                  .toList(),
            ),
          ],

          if (goal.milestones.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xxl),
            Text('Progress Over Time', style: AppTypography.titleMedium(onBg)),
            const SizedBox(height: AppSpacing.md),
            _ProgressChart(goal: goal, accent: meta.color, surface: surface, muted: muted),
          ],

          const SizedBox(height: AppSpacing.x4l),
        ],
      ),
    );
  }
}

String _formatDate(DateTime date) {
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${months[date.month - 1]} ${date.day}';
}

class _MilestoneTile extends ConsumerWidget {
  final String goalId;
  final MilestoneModel milestone;
  final Color surface;
  final Color onSurface;
  final Color muted;
  final Color accent;

  const _MilestoneTile({
    required this.goalId,
    required this.milestone,
    required this.surface,
    required this.onSurface,
    required this.muted,
    required this.accent,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(AppRadius.md)),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => ref.read(goalNotifierProvider.notifier).toggleMilestone(milestone.id, !milestone.isComplete),
            child: Icon(
              milestone.isComplete ? Icons.check_circle_rounded : Icons.circle_outlined,
              color: milestone.isComplete ? accent : muted,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  milestone.title,
                  style: AppTypography.bodyMedium(onSurface).copyWith(
                    decoration: milestone.isComplete ? TextDecoration.lineThrough : null,
                  ),
                ),
                if (milestone.isComplete && milestone.completedAt != null)
                  Text(
                    'Completed ${_formatDate(milestone.completedAt!)}',
                    style: AppTypography.labelSmall(muted),
                  ),
              ],
            ),
          ),
          Text('${milestone.targetValue}', style: AppTypography.bodySmall(muted)),
        ],
      ),
    );
  }
}

class _ProgressChart extends StatelessWidget {
  final GoalModel goal;
  final Color accent;
  final Color surface;
  final Color muted;

  const _ProgressChart({required this.goal, required this.accent, required this.surface, required this.muted});

  @override
  Widget build(BuildContext context) {
    final completed = goal.milestones.where((m) => m.isComplete && m.completedAt != null).toList()
      ..sort((a, b) => a.completedAt!.compareTo(b.completedAt!));

    if (completed.isEmpty) {
      return Container(
        height: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(AppRadius.md)),
        child: Text('Complete milestones to see progress', style: AppTypography.bodySmall(muted)),
      );
    }

    final spots = completed.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.targetValue)).toList();

    return Container(
      height: 140,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(AppRadius.md)),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: const FlTitlesData(show: false),
          lineTouchData: const LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: accent,
              barWidth: 3,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: true, color: accent.withOpacity(0.15)),
            ),
          ],
        ),
      ),
    );
  }
}
