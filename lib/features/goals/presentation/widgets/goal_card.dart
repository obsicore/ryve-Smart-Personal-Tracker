import 'package:flutter/material.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/goals/data/models/goal_model.dart';
import 'package:hybrid_tracker/features/goals/domain/life_area_meta.dart';

class GoalCard extends StatelessWidget {
  final GoalModel goal;
  final VoidCallback onTap;

  const GoalCard({super.key, required this.goal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final meta = metaFor(goal.lifeArea);
    final progress = goal.progress;

    final daysLeft = goal.daysLeft;
    final overdue = goal.isOverdue;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
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
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
                  decoration: BoxDecoration(
                    color: meta.color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                  child: Text('${meta.emoji} ${meta.label}', style: AppTypography.labelSmall(meta.color)),
                ),
                const Spacer(),
                _StatusBadge(status: goal.status, overdue: overdue),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              goal.title,
              style: AppTypography.titleMedium(onSurface),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.full),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: isDark ? AppColors.darkSurfaceBright : AppColors.lightSurfaceVariant,
                valueColor: AlwaysStoppedAnimation(meta.color),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${goal.currentValue.toStringAsFixed(goal.currentValue % 1 == 0 ? 0 : 1)}/${goal.targetValue.toStringAsFixed(goal.targetValue % 1 == 0 ? 0 : 1)}${goal.unit != null ? ' ${goal.unit}' : ''} · ${(progress * 100).toStringAsFixed(0)}%',
                    style: AppTypography.bodySmall(muted),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (goal.milestones.isNotEmpty) _MilestoneDots(milestones: goal.milestones),
              ],
            ),
            if (daysLeft != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                overdue ? 'Overdue' : (daysLeft >= 0 ? '$daysLeft days left' : 'Overdue'),
                style: AppTypography.labelSmall(overdue ? AppColors.error : muted),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MilestoneDots extends StatelessWidget {
  final List milestones;
  const _MilestoneDots({required this.milestones});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondary = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final shown = milestones.take(5).toList();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: shown.map((m) {
        final complete = m.isComplete as bool;
        return Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: complete ? secondary : muted.withOpacity(0.3),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  final bool overdue;
  const _StatusBadge({required this.status, required this.overdue});

  @override
  Widget build(BuildContext context) {
    final color = overdue
        ? AppColors.error
        : switch (status) {
            'completed' => AppColors.success,
            'paused' => AppColors.warning,
            _ => AppColors.info,
          };
    final label = overdue ? 'Overdue' : status[0].toUpperCase() + status.substring(1);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 3),
      decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(AppRadius.full)),
      child: Text(label, style: AppTypography.labelSmall(color)),
    );
  }
}
