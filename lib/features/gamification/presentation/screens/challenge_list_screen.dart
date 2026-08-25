import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/gamification/data/models/challenge_model.dart';
import 'package:hybrid_tracker/features/gamification/domain/providers/gamification_providers.dart';

class ChallengeListScreen extends ConsumerStatefulWidget {
  const ChallengeListScreen({super.key});

  @override
  ConsumerState<ChallengeListScreen> createState() => _ChallengeListScreenState();
}

class _ChallengeListScreenState extends ConsumerState<ChallengeListScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    final challengesAsync = ref.watch(allChallengesProvider);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Text('Challenges', style: AppTypography.titleLarge(onBg)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: gold,
          unselectedLabelColor: muted,
          indicatorColor: gold,
          tabs: const [Tab(text: 'Active'), Tab(text: 'Completed'), Tab(text: 'Available')],
        ),
      ),
      body: challengesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(
          child: Text('Could not load challenges', style: AppTypography.bodyMedium(muted)),
        ),
        data: (challenges) {
          final active = challenges.where((c) => c.status == 'active').toList();
          final completed = challenges.where((c) => c.status == 'completed').toList();
          final available = challenges.where((c) => c.status == 'available').toList();

          return TabBarView(
            controller: _tabController,
            children: [
              _ChallengeList(challenges: active, muted: muted),
              _ChallengeList(challenges: completed, muted: muted),
              _ChallengeList(challenges: available, muted: muted),
            ],
          );
        },
      ),
    );
  }
}

class _ChallengeList extends StatelessWidget {
  const _ChallengeList({required this.challenges, required this.muted});
  final List<ChallengeModel> challenges;
  final Color muted;

  @override
  Widget build(BuildContext context) {
    if (challenges.isEmpty) {
      return Center(
        child: Text('Nothing here yet', style: AppTypography.bodyMedium(muted)),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: challenges.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, i) => _ChallengeCard(challenge: challenges[i])
          .animate(delay: Duration(milliseconds: i * 40))
          .fadeIn(duration: 250.ms)
          .slideY(begin: 0.05, end: 0),
    );
  }
}

class _ChallengeCard extends ConsumerWidget {
  const _ChallengeCard({required this.challenge});
  final ChallengeModel challenge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final secondary = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            challenge.title,
            style: AppTypography.titleMedium(onSurface),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(challenge.description, style: AppTypography.bodySmall(muted)),
          const SizedBox(height: AppSpacing.md),
          if (challenge.isJoined) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.full),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: challenge.progress),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
                builder: (context, value, _) => LinearProgressIndicator(
                  value: value,
                  minHeight: 8,
                  backgroundColor: muted.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation(
                    challenge.status == 'completed' ? secondary : gold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${challenge.currentValue}/${challenge.targetValue} · ${(challenge.progress * 100).round()}%',
                    style: AppTypography.bodySmall(muted),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  challenge.status == 'completed'
                      ? 'Completed'
                      : '${challenge.daysRemaining}d left',
                  style: AppTypography.bodySmall(muted),
                ),
              ],
            ),
          ] else
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () =>
                    ref.read(challengeNotifierProvider.notifier).join(challenge.id),
                style: ElevatedButton.styleFrom(
                  backgroundColor: gold,
                  foregroundColor: AppColors.darkOnPrimary,
                ),
                child: const Text('Join Challenge'),
              ),
            ),
        ],
      ),
    );
  }
}
