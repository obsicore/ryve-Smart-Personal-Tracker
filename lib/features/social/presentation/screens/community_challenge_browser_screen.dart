import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/social/data/models/community_challenge_model.dart';
import 'package:hybrid_tracker/features/social/domain/providers/social_providers.dart';

class CommunityChallengeBrowserScreen extends ConsumerWidget {
  const CommunityChallengeBrowserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    final challengesAsync = ref.watch(communityChallengesProvider);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Text('Community Challenges', style: AppTypography.titleLarge(onBg)),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(communityChallengesProvider),
        child: challengesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Text('Could not load challenges.\nCheck your connection.',
                textAlign: TextAlign.center, style: AppTypography.bodyMedium(muted)),
          ),
          data: (challenges) {
            if (challenges.isEmpty) {
              return Center(
                child: Text('No community challenges right now', style: AppTypography.bodyMedium(muted)),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: challenges.length,
              itemBuilder: (context, i) {
                final c = challenges[i];
                return _CommunityChallengeCard(challenge: c, surface: surface, onBg: onBg, muted: muted, gold: gold)
                    .animate(delay: (i * 60).ms)
                    .fadeIn(duration: 250.ms)
                    .slideY(begin: 0.15, end: 0);
              },
            );
          },
        ),
      ),
    );
  }
}

class _CommunityChallengeCard extends ConsumerWidget {
  const _CommunityChallengeCard({
    required this.challenge,
    required this.surface,
    required this.onBg,
    required this.muted,
    required this.gold,
  });

  final CommunityChallengeModel challenge;
  final Color surface, onBg, muted, gold;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = challenge.targetValue == 0
        ? 0.0
        : (challenge.myProgress / challenge.targetValue).clamp(0.0, 1.0);
    final daysLeft = challenge.endDate.difference(DateTime.now()).inDays;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(AppSpacing.md)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(challenge.title, style: AppTypography.titleMedium(onBg)),
          const SizedBox(height: 4),
          Text(challenge.description, style: AppTypography.bodySmall(muted)),
          const SizedBox(height: AppSpacing.sm),
          Text('${challenge.participantCount} joined · ${daysLeft > 0 ? '$daysLeft days left' : 'ended'}',
              style: AppTypography.bodySmall(muted)),
          if (challenge.hasJoined) ...[
            const SizedBox(height: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progress),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
                builder: (context, value, _) => LinearProgressIndicator(
                  value: value,
                  minHeight: 6,
                  backgroundColor: muted.withValues(alpha: 0.15),
                  valueColor: AlwaysStoppedAnimation(gold),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text('${challenge.myProgress}/${challenge.targetValue}', style: AppTypography.bodySmall(muted)),
          ] else
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => ref.read(socialActionsProvider.notifier).joinChallenge(challenge.id),
                child: Text('Join Challenge', style: TextStyle(color: gold)),
              ),
            ),
        ],
      ),
    );
  }
}
