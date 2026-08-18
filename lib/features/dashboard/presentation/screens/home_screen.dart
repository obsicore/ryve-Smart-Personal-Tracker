import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:hybrid_tracker/core/router/app_router.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_animations.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/dashboard/data/models/dashboard_models.dart';
import 'package:hybrid_tracker/features/dashboard/domain/providers/dashboard_providers.dart';
import 'package:hybrid_tracker/features/dashboard/presentation/widgets/ai_suggestion_banner_widget.dart';
import 'package:hybrid_tracker/features/dashboard/presentation/widgets/mood_water_widget.dart';
import 'package:hybrid_tracker/features/dashboard/presentation/widgets/notification_bell_widget.dart';
import 'package:hybrid_tracker/features/dashboard/presentation/widgets/streak_card_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final disableAnims = MediaQuery.of(context).disableAnimations;

    final user = ref.watch(authStateProvider).valueOrNull;
    final firstName = _extractFirstName(user?.displayName ?? user?.email);
    final greeting = _buildGreeting(firstName);

    final statsAsync = ref.watch(dashboardStatsProvider);
    final habitsAsync = ref.watch(habitPreviewsProvider);
    final tasksAsync = ref.watch(taskPreviewsProvider);

    return Scaffold(
      backgroundColor: bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.lg),

                    // ── Header ──────────────────────────────────────────────
                    _buildHeader(context, greeting, isDark, disableAnims),

                    const SizedBox(height: AppSpacing.xxl),

                    // ── Streak Card ──────────────────────────────────────────
                    _AnimatedSection(
                      delay: disableAnims
                          ? Duration.zero
                          : const Duration(milliseconds: 80),
                      slideX: -0.04,
                      disableAnims: disableAnims,
                      child: statsAsync.when(
                        data: (stats) =>
                            StreakCardWidget(streak: stats.currentStreak),
                        loading: () => _SkeletonCard(height: 120),
                        error: (_, __) => _SkeletonCard(height: 120),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    // ── Habits Preview ───────────────────────────────────────
                    _AnimatedSection(
                      delay: disableAnims
                          ? Duration.zero
                          : const Duration(milliseconds: 160),
                      slideY: 0.04,
                      disableAnims: disableAnims,
                      child: _SectionHeader(
                        title: "Today's Habits",
                        onViewAll: () => context.push(Routes.habits),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _AnimatedSection(
                      delay: disableAnims
                          ? Duration.zero
                          : const Duration(milliseconds: 160),
                      slideY: 0.04,
                      disableAnims: disableAnims,
                      child: habitsAsync.when(
                        data: (habits) => _HabitsPreview(habits: habits),
                        loading: () => _HabitsPreviewSkeleton(),
                        error: (_, __) => _HabitsPreviewSkeleton(),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    // ── Tasks Preview ────────────────────────────────────────
                    _AnimatedSection(
                      delay: disableAnims
                          ? Duration.zero
                          : const Duration(milliseconds: 240),
                      slideY: 0.04,
                      disableAnims: disableAnims,
                      child: _SectionHeader(
                        title: "Today's Tasks",
                        onViewAll: () => context.push(Routes.tasks),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _AnimatedSection(
                      delay: disableAnims
                          ? Duration.zero
                          : const Duration(milliseconds: 240),
                      slideY: 0.04,
                      disableAnims: disableAnims,
                      child: tasksAsync.when(
                        data: (tasks) =>
                            _TasksPreview(tasks: tasks, isDark: isDark),
                        loading: () => _TasksPreviewSkeleton(isDark: isDark),
                        error: (_, __) => _TasksPreviewSkeleton(isDark: isDark),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    // ── Mood + Water ─────────────────────────────────────────
                    _AnimatedSection(
                      delay: disableAnims
                          ? Duration.zero
                          : const Duration(milliseconds: 320),
                      disableAnims: disableAnims,
                      child: const MoodWaterWidget(),
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    // ── Quick Actions ────────────────────────────────────────
                    _AnimatedSection(
                      delay: disableAnims ? Duration.zero : const Duration(milliseconds: 380),
                      disableAnims: disableAnims,
                      child: _QuickActions(isDark: isDark),
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    // ── AI Suggestion ────────────────────────────────────────
                    _AnimatedSection(
                      delay: disableAnims
                          ? Duration.zero
                          : const Duration(milliseconds: 440),
                      disableAnims: disableAnims,
                      child: const AiSuggestionBannerWidget(),
                    ),

                    const SizedBox(height: AppSpacing.x4l),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _RyveBottomNav(currentIndex: 0),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    String greeting,
    bool isDark,
    bool disableAnims,
  ) {
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final now = DateTime.now();
    final dateStr = DateFormat('EEEE, MMMM d').format(now);

    Widget header = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: AppTypography.headlineMedium(onBg),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                dateStr,
                style: AppTypography.bodyMedium(muted),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.calendar_month_outlined, color: muted),
          onPressed: () => context.push(Routes.calendar),
          tooltip: 'Calendar',
        ),
        const NotificationBellWidget(),
      ],
    );

    if (!disableAnims) {
      header = header
          .animate()
          .fadeIn(duration: AppAnimations.moderate, curve: AppAnimations.enter)
          .slideY(
            begin: -0.08,
            end: 0,
            duration: AppAnimations.moderate,
            curve: AppAnimations.enter,
          );
    }

    return header;
  }

  String _buildGreeting(String firstName) {
    final hour = DateTime.now().hour;
    final timeGreeting = hour < 12
        ? 'Good morning'
        : hour < 17
            ? 'Good afternoon'
            : 'Good evening';
    return '$timeGreeting, $firstName! 👋';
  }

  String _extractFirstName(String? name) {
    if (name == null || name.isEmpty) return 'there';
    // If it looks like an email, use the part before @
    if (name.contains('@')) return name.split('@').first;
    return name.split(' ').first;
  }
}

// ---------------------------------------------------------------------------
// Section header with "View all" link
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const _SectionHeader({required this.title, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTypography.titleMedium(onSurface)),
        GestureDetector(
          onTap: onViewAll,
          child: Text(
            'View all',
            style: AppTypography.labelMedium(gold),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Habits horizontal scroll preview
// ---------------------------------------------------------------------------

class _HabitsPreview extends StatelessWidget {
  final List<HabitPreview> habits;

  const _HabitsPreview({required this.habits});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: habits.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, i) => _HabitPreviewChip(habit: habits[i]),
      ),
    );
  }
}

class _HabitPreviewChip extends StatelessWidget {
  final HabitPreview habit;

  const _HabitPreviewChip({required this.habit});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final secondary = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;

    return Container(
      width: 76,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: habit.completed
            ? secondary.withOpacity(0.12)
            : surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: habit.completed
              ? secondary.withOpacity(0.4)
              : isDark
                  ? AppColors.darkSurfaceBright
                  : Colors.transparent,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Text(habit.emoji, style: const TextStyle(fontSize: 28)),
              if (habit.completed)
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: secondary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 9,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            habit.name,
            style: AppTypography.bodySmall(
              habit.completed ? secondary : onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _HabitsPreviewSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (_, __) => _SkeletonCard(width: 76, height: 84),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tasks vertical list preview
// ---------------------------------------------------------------------------

class _TasksPreview extends StatelessWidget {
  final List<TaskPreview> tasks;
  final bool isDark;

  const _TasksPreview({required this.tasks, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    return Container(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: isDark ? AppColors.darkSurfaceBright : Colors.transparent,
          width: 1,
        ),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tasks.length,
        separatorBuilder: (_, __) => Divider(
          height: 1,
          thickness: 1,
          color: isDark
              ? AppColors.darkSurfaceBright
              : AppColors.lightSurfaceVariant,
        ),
        itemBuilder: (_, i) => _TaskPreviewRow(task: tasks[i], isDark: isDark),
      ),
    );
  }
}

class _TaskPreviewRow extends StatelessWidget {
  final TaskPreview task;
  final bool isDark;

  const _TaskPreviewRow({required this.task, required this.isDark});

  // priority: 0=low, 1=medium, 2=high, 3=urgent
  Color _priorityColor(int p) => switch (p) {
        3 => AppColors.priorityUrgent,
        2 => AppColors.priorityHigh,
        1 => AppColors.priorityMed,
        _ => AppColors.priorityLow,
      };

  @override
  Widget build(BuildContext context) {
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final dotColor = _priorityColor(task.priority);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Icon(
            task.completed
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            size: 20,
            color: task.completed ? AppColors.success : muted,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              task.title,
              style: AppTypography.bodyMedium(
                task.completed ? muted : onSurface,
              ).copyWith(
                decoration:
                    task.completed ? TextDecoration.lineThrough : null,
                decorationColor: muted,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}

class _TasksPreviewSkeleton extends StatelessWidget {
  final bool isDark;

  const _TasksPreviewSkeleton({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _SkeletonCard(height: 140);
  }
}

// ---------------------------------------------------------------------------
// Bottom nav bar
// ---------------------------------------------------------------------------

class _RyveBottomNav extends StatelessWidget {
  final int currentIndex;

  const _RyveBottomNav({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    return NavigationBar(
      selectedIndex: currentIndex,
      backgroundColor: surface,
      indicatorColor: primary.withOpacity(0.15),
      onDestinationSelected: (i) {
        switch (i) {
          case 0: context.go(Routes.home);
          case 1: context.go(Routes.tasks);
          case 2: context.go(Routes.habits);
          case 3: context.go(Routes.focus);
          case 4: context.go(Routes.profile);
        }
      },
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home_outlined, color: muted),
          selectedIcon: Icon(Icons.home_rounded, color: primary),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.check_circle_outline_rounded, color: muted),
          selectedIcon: Icon(Icons.check_circle_rounded, color: primary),
          label: 'Tasks',
        ),
        NavigationDestination(
          icon: Icon(Icons.eco_outlined, color: muted),
          selectedIcon: Icon(Icons.eco_rounded, color: primary),
          label: 'Habits',
        ),
        NavigationDestination(
          icon: Icon(Icons.timer_outlined, color: muted),
          selectedIcon: Icon(Icons.timer_rounded, color: primary),
          label: 'Focus',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline_rounded, color: muted),
          selectedIcon: Icon(Icons.person_rounded, color: primary),
          label: 'Profile',
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Reusable animation wrapper
// ---------------------------------------------------------------------------

class _AnimatedSection extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final double slideX;
  final double slideY;
  final bool disableAnims;

  const _AnimatedSection({
    required this.child,
    required this.delay,
    this.slideX = 0,
    this.slideY = 0,
    required this.disableAnims,
  });

  @override
  Widget build(BuildContext context) {
    if (disableAnims) return child;

    return child
        .animate(delay: delay)
        .fadeIn(duration: AppAnimations.moderate, curve: AppAnimations.enter)
        .slideX(
          begin: slideX,
          end: 0,
          duration: AppAnimations.moderate,
          curve: AppAnimations.enter,
        )
        .slideY(
          begin: slideY,
          end: 0,
          duration: AppAnimations.moderate,
          curve: AppAnimations.enter,
        );
  }
}

// ---------------------------------------------------------------------------
// Skeleton placeholder
// ---------------------------------------------------------------------------

class _SkeletonCard extends StatelessWidget {
  final double height;
  final double? width;

  const _SkeletonCard({required this.height, this.width});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark
        ? AppColors.darkSurfaceVariant
        : AppColors.lightSurfaceVariant;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Quick action chips: Sleep + Calendar
// ---------------------------------------------------------------------------
class _QuickActions extends StatelessWidget {
  final bool isDark;
  const _QuickActions({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondary = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _QuickActionChip(
            icon: Icons.bedtime_outlined,
            label: 'Sleep',
            color: secondary,
            surface: surface,
            isDark: isDark,
            onTap: () => context.push(Routes.sleep),
          ),
          const SizedBox(width: AppSpacing.md),
          _QuickActionChip(
            icon: Icons.calendar_month_outlined,
            label: 'Calendar',
            color: primary,
            surface: surface,
            isDark: isDark,
            onTap: () => context.push(Routes.calendar),
          ),
          const SizedBox(width: AppSpacing.md),
          _QuickActionChip(
            icon: Icons.favorite_outline_rounded,
            label: 'Wellness',
            color: secondary,
            surface: surface,
            isDark: isDark,
            onTap: () => context.push(Routes.wellness),
          ),
          const SizedBox(width: AppSpacing.md),
          _QuickActionChip(
            icon: Icons.flag_outlined,
            label: 'Goals',
            color: primary,
            surface: surface,
            isDark: isDark,
            onTap: () => context.push(Routes.goals),
          ),
        ],
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color surface;
  final bool isDark;
  final VoidCallback onTap;

  const _QuickActionChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.surface,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: isDark ? Border.all(color: AppColors.darkSurfaceBright) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: AppSpacing.sm),
            Text(label, style: AppTypography.labelMedium(color)),
          ],
        ),
      ),
    );
  }
}
