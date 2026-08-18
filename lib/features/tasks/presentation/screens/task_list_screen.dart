import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hybrid_tracker/core/router/app_router.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/features/tasks/data/models/task_model.dart';
import 'package:hybrid_tracker/features/tasks/domain/providers/task_providers.dart';
import 'package:hybrid_tracker/features/tasks/presentation/widgets/create_task_bottom_sheet.dart';
import 'package:hybrid_tracker/features/tasks/presentation/widgets/task_card.dart';
import 'package:hybrid_tracker/shared/widgets/empty_state_widget.dart';
import 'package:hybrid_tracker/shared/widgets/skeleton_widget.dart';

class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  static const _tabs = ['All', 'Today', 'Upcoming', 'Priority'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tasks',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
        ),
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // placeholder for search
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Search coming in Phase 2'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            icon: Icon(
              Icons.search_rounded,
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
          unselectedLabelColor: colorScheme.onSurface.withOpacity(0.5),
          indicatorColor:
              isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
          indicatorWeight: 2.5,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TaskTabBody(
            provider: allTasksProvider,
            emptySubtitle: 'Add your first task to get started',
          ),
          _TaskTabBody(
            provider: todayTasksProvider,
            emptySubtitle: 'Nothing due today — enjoy your day!',
          ),
          _TaskTabBody(
            provider: upcomingTasksProvider,
            emptySubtitle: 'No upcoming tasks scheduled',
          ),
          _TaskTabBody(
            provider: highPriorityTasksProvider,
            emptySubtitle: 'No high-priority tasks',
          ),
        ],
      ),
      floatingActionButton: _GoldFab(
        onTap: () => CreateTaskBottomSheet.show(context),
      ),
      bottomNavigationBar: _BottomNav(currentIndex: 1),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab body — handles loading / error / empty / data states
// ---------------------------------------------------------------------------
class _TaskTabBody extends ConsumerWidget {
  const _TaskTabBody({
    required this.provider,
    required this.emptySubtitle,
  });

  final ProviderListenable<AsyncValue<List<TaskModel>>> provider;
  final String emptySubtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTasks = ref.watch(provider);

    return asyncTasks.when(
      loading: () => const _TaskSkeletonList(),
      error: (err, _) => _ErrorState(message: err.toString()),
      data: (tasks) {
        if (tasks.isEmpty) {
          return Center(
            child: EmptyStateWidget(
              svgAssetPath: 'assets/illustrations/tasks_empty.svg',
              title: 'No tasks yet',
              subtitle: emptySubtitle,
              ctaLabel: 'Add your first task',
              onCta: () => CreateTaskBottomSheet.show(context),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(
            top: AppSpacing.md,
            bottom: 120,
          ),
          itemCount: tasks.length,
          itemBuilder: (context, i) {
            final task = tasks[i];
            return GestureDetector(
              onTap: () => context.push('/tasks/${task.id}'),
              child: TaskCard(
                key: ValueKey(task.id),
                task: task,
                animationIndex: i,
              ),
            );
          },
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Skeleton loading
// ---------------------------------------------------------------------------
class _TaskSkeletonList extends StatelessWidget {
  const _TaskSkeletonList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      itemCount: 3,
      itemBuilder: (context, _) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm / 2,
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 72,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(AppRadius.md),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 72,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(AppRadius.md),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SkeletonWidget(
                      width: double.infinity,
                      height: 14,
                      borderRadius: AppRadius.xs,
                    ),
                    SkeletonWidget(
                      width: 90,
                      height: 11,
                      borderRadius: AppRadius.xs,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Error state
// ---------------------------------------------------------------------------
class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.x3l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: AppColors.priorityUrgent.withOpacity(0.7),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Gold FAB
// ---------------------------------------------------------------------------
class _GoldFab extends StatelessWidget {
  const _GoldFab({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final goldColor =
        isDark ? AppColors.darkPrimary : AppColors.lightAccent;

    return FloatingActionButton(
      onPressed: onTap,
      backgroundColor: goldColor,
      foregroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      elevation: 4,
      shape: const CircleBorder(),
      child: const Icon(Icons.add_rounded, size: 28),
    )
        .animate()
        .scale(
          begin: const Offset(0, 0),
          end: const Offset(1, 1),
          duration: 400.ms,
          delay: 200.ms,
          curve: Curves.elasticOut,
        )
        .fadeIn(duration: 200.ms, delay: 200.ms);
  }
}

// ---------------------------------------------------------------------------
// Bottom navigation
// ---------------------------------------------------------------------------
class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final activeColor =
        isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    return NavigationBar(
      selectedIndex: currentIndex,
      backgroundColor: colorScheme.surface,
      indicatorColor: activeColor.withOpacity(0.12),
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
          icon: Icon(Icons.home_outlined, color: colorScheme.onSurface.withOpacity(0.5)),
          selectedIcon: Icon(Icons.home_rounded, color: activeColor),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.check_circle_outline_rounded, color: colorScheme.onSurface.withOpacity(0.5)),
          selectedIcon: Icon(Icons.check_circle_rounded, color: activeColor),
          label: 'Tasks',
        ),
        NavigationDestination(
          icon: Icon(Icons.eco_outlined, color: colorScheme.onSurface.withOpacity(0.5)),
          selectedIcon: Icon(Icons.eco_rounded, color: activeColor),
          label: 'Habits',
        ),
        NavigationDestination(
          icon: Icon(Icons.timer_outlined, color: colorScheme.onSurface.withOpacity(0.5)),
          selectedIcon: Icon(Icons.timer_rounded, color: activeColor),
          label: 'Focus',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline_rounded, color: colorScheme.onSurface.withOpacity(0.5)),
          selectedIcon: Icon(Icons.person_rounded, color: activeColor),
          label: 'Profile',
        ),
      ],
    );
  }
}
