import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/ai/data/models/coaching_insight_model.dart';
import 'package:hybrid_tracker/features/ai/domain/providers/ai_providers.dart';

const _categoryIcons = {
  'focus': Icons.timer_outlined,
  'habit': Icons.repeat_rounded,
  'wellness': Icons.favorite_outline_rounded,
  'goal': Icons.flag_outlined,
  'sleep': Icons.bedtime_outlined,
  'reschedule': Icons.event_repeat_rounded,
};

class CoachingInsightsWidget extends ConsumerWidget {
  const CoachingInsightsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(coachingInsightsNotifierProvider);
    final insightsAsync = ref.watch(coachingInsightsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;

    return insightsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (insights) {
        if (insights.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb_outline, color: gold, size: 18),
                const SizedBox(width: AppSpacing.sm),
                Text('Coaching Insights', style: AppTypography.labelMedium(gold)),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            for (final entry in insights.take(3).toList().asMap().entries)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: _InsightCard(insight: entry.value)
                    .animate(delay: (entry.key * 60).ms)
                    .fadeIn(duration: 220.ms)
                    .slideY(begin: 0.08, end: 0),
              ),
          ],
        );
      },
    );
  }
}

class _InsightCard extends ConsumerWidget {
  const _InsightCard({required this.insight});
  final CoachingInsightModel insight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final notifier = ref.read(coachingInsightsNotifierProvider.notifier);

    return Dismissible(
      key: ValueKey(insight.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: const Icon(Icons.close_rounded, color: AppColors.error),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: const Icon(Icons.bookmark_outline_rounded, color: AppColors.success),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          await notifier.dismiss(insight.id);
        } else {
          await notifier.markRead(insight.id);
        }
        return direction == DismissDirection.startToEnd;
      },
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: isDark ? AppColors.darkSurfaceBright : Colors.transparent,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  _categoryIcons[insight.category] ?? Icons.info_outline,
                  size: 18,
                  color: muted,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(insight.content, style: AppTypography.bodySmall(onSurface)),
                ),
              ],
            ),
            if (insight.category == 'reschedule' && insight.contextJson != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => notifier.rescheduleTaskToTomorrow(
                    insight.id,
                    insight.contextJson!,
                  ),
                  icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                  label: const Text('Move to tomorrow'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
