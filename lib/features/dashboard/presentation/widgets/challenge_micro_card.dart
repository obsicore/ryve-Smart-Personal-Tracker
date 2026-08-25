import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:hybrid_tracker/core/router/app_router.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/gamification/data/models/challenge_model.dart';
import 'package:hybrid_tracker/features/gamification/domain/providers/gamification_providers.dart';

class ChallengeMicroCard extends ConsumerWidget {
  const ChallengeMicroCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengesAsync = ref.watch(allChallengesProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final secondary = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;

    return challengesAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (challenges) {
        final active = challenges.where((c) => c.status == 'active').toList()
          ..sort((a, b) => b.progress.compareTo(a.progress));
        if (active.isEmpty) return const SizedBox.shrink();
        final top = active.first;

        return InkWell(
          borderRadius: BorderRadius.circular(AppRadius.md),
          onTap: () => context.push(Routes.challenges),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Row(
              children: [
                Icon(Icons.emoji_events_outlined, color: secondary, size: 20),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        top.title,
                        style: AppTypography.bodyMedium(onSurface),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.full),
                        child: LinearProgressIndicator(
                          value: top.progress,
                          minHeight: 6,
                          backgroundColor: muted.withValues(alpha: 0.2),
                          valueColor: AlwaysStoppedAnimation(secondary),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text('${(top.progress * 100).round()}%', style: AppTypography.labelMedium(secondary)),
              ],
            ),
          ),
        );
      },
    );
  }
}
