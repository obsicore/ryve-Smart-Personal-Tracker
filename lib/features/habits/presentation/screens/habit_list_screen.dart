import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/habits/domain/providers/habit_providers.dart';
import 'package:hybrid_tracker/features/habits/presentation/widgets/habit_card.dart';
import 'package:hybrid_tracker/shared/widgets/empty_state_widget.dart';
import 'package:hybrid_tracker/shared/widgets/skeleton_widget.dart';

class HabitListScreen extends ConsumerWidget {
  const HabitListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondary = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final disableAnims = MediaQuery.of(context).disableAnimations;

    final habitsAsync = ref.watch(allHabitsProvider);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        leading: context.canPop()
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded, color: onBg, size: 20),
                onPressed: () => context.pop(),
              )
            : null,
        title: Text('Habits', style: AppTypography.titleLarge(onBg)),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: primary),
            onPressed: () => context.push('/habits/create'),
          ),
        ],
      ),
      body: habitsAsync.when(
        loading: () => _buildSkeleton(isDark),
        error: (e, _) => Center(
          child: Text('Error loading habits', style: AppTypography.bodyMedium(AppColors.error)),
        ),
        data: (habits) {
          if (habits.isEmpty) {
            return EmptyStateWidget(
              svgAssetPath: 'assets/illustrations/habits_empty.svg',
              title: 'No habits yet',
              subtitle: 'Build consistent habits to track your progress.',
              ctaLabel: 'Create your first habit',
              onCta: () => context.push('/habits/create'),
            );
          }

          final completed = habits.where((h) => h.completedToday).length;

          return Column(
            children: [
              _CompletionHeader(
                completed: completed,
                total: habits.length,
                isDark: isDark,
                primary: primary,
                secondary: secondary,
                muted: muted,
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.x4l,
                  ),
                  itemCount: habits.length,
                  separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, i) {
                    final habit = habits[i];
                    Widget card = HabitCard(
                      habit: habit,
                      onTap: () => context.push('/habits/${habit.id}'),
                    );

                    if (!disableAnims) {
                      card = card
                          .animate(delay: (i * 30).ms)
                          .fadeIn(duration: 220.ms, curve: Curves.easeOut)
                          .slideY(begin: 0.06, end: 0, duration: 220.ms, curve: Curves.easeOut);
                    }
                    return card;
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/habits/create'),
        backgroundColor: primary,
        child: Icon(Icons.add, color: isDark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary),
      ),
    );
  }

  Widget _buildSkeleton(bool isDark) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: 3,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (_, __) => SkeletonWidget(width: double.infinity, height: 88),
    );
  }
}

class _CompletionHeader extends StatelessWidget {
  final int completed;
  final int total;
  final bool isDark;
  final Color primary;
  final Color secondary;
  final Color muted;

  const _CompletionHeader({
    required this.completed,
    required this.total,
    required this.isDark,
    required this.primary,
    required this.secondary,
    required this.muted,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = total == 0 ? 0.0 : completed / total;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surfaceBright = isDark ? AppColors.darkSurfaceBright : AppColors.lightSurfaceBright;

    return Container(
      margin: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: isDark ? Border.all(color: AppColors.darkSurfaceBright, width: 1) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Today's Progress", style: AppTypography.titleMedium(isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface)),
              Text(
                '$completed / $total',
                style: AppTypography.labelLarge(completed == total && total > 0 ? secondary : primary),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.full),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: ratio),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              builder: (_, value, __) => LinearProgressIndicator(
                value: value,
                minHeight: 6,
                backgroundColor: surfaceBright,
                valueColor: AlwaysStoppedAnimation(secondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

