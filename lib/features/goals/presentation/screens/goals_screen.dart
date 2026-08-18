import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:hybrid_tracker/core/router/app_router.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/goals/data/models/goal_model.dart' show lifeAreas;
import 'package:hybrid_tracker/features/goals/data/models/weekly_report_model.dart';
import 'package:hybrid_tracker/features/goals/domain/life_area_meta.dart';
import 'package:hybrid_tracker/features/goals/domain/providers/goals_providers.dart';
import 'package:hybrid_tracker/features/goals/presentation/widgets/goal_card.dart';
import 'package:hybrid_tracker/features/goals/presentation/widgets/life_area_radar_chart.dart';
import 'package:hybrid_tracker/shared/widgets/empty_state_widget.dart';
import 'package:hybrid_tracker/shared/widgets/skeleton_widget.dart';

class GoalsScreen extends ConsumerStatefulWidget {
  const GoalsScreen({super.key});

  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  static final _tabs = ['All', ...lifeAreas.map((a) => metaFor(a).label)];

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
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Text('Goals', style: AppTypography.titleLarge(onBg)),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: primary),
            tooltip: 'New goal',
            onPressed: () => context.push(Routes.goalCreate),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: primary,
          unselectedLabelColor: muted,
          indicatorColor: primary,
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _GoalsTabBody(lifeArea: null),
          ...lifeAreas.map((area) => _GoalsTabBody(lifeArea: area)),
        ],
      ),
    );
  }
}

class _GoalsTabBody extends ConsumerWidget {
  final String? lifeArea;

  const _GoalsTabBody({required this.lifeArea});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalsAsync = lifeArea == null
        ? ref.watch(allGoalsProvider)
        : ref.watch(goalsByLifeAreaProvider(lifeArea!));
    final scoreAsync = ref.watch(latestLifeAreaScoreProvider);
    final reportAsync = ref.watch(latestWeeklyReportProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (lifeArea == null) ...[
            Text('Life Balance', style: AppTypography.titleMedium(onBg)),
            const SizedBox(height: AppSpacing.md),
            scoreAsync.when(
              loading: () => const SkeletonWidget(width: double.infinity, height: 280),
              error: (_, __) => const SizedBox.shrink(),
              data: (score) => LifeAreaRadarChart(score: score),
            ).animate().fadeIn(duration: 250.ms),
            const SizedBox(height: AppSpacing.lg),
            reportAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (report) {
                if (report == null) return const SizedBox.shrink();
                return _WeeklyReportCard(report: report);
              },
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text('Goals', style: AppTypography.titleMedium(onBg)),
            const SizedBox(height: AppSpacing.md),
          ],
          goalsAsync.when(
            loading: () => Column(children: List.generate(3, (_) => const Padding(padding: EdgeInsets.only(bottom: AppSpacing.md), child: SkeletonWidget(width: double.infinity, height: 120)))),
            error: (_, __) => Text('Failed to load goals', style: AppTypography.bodyMedium(muted)),
            data: (goals) {
              if (goals.isEmpty) {
                return const EmptyStateWidget(
                  svgAssetPath: 'assets/illustrations/goals_empty.svg',
                  title: 'No goals yet',
                  subtitle: 'Set a goal to start tracking your progress',
                );
              }
              return Column(
                children: goals.asMap().entries.map((entry) {
                  return GoalCard(
                    goal: entry.value,
                    onTap: () => context.push('/goals/${entry.value.id}'),
                  ).animate(delay: (entry.key * 30).ms).fadeIn(duration: 220.ms).slideY(begin: 0.05, end: 0);
                }).toList(),
              );
            },
          ),
          const SizedBox(height: AppSpacing.x4l),
        ],
      ),
    );
  }
}

class _WeeklyReportCard extends StatelessWidget {
  final WeeklyReportModel report;

  const _WeeklyReportCard({required this.report});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    return Container(
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
              Icon(Icons.insights_rounded, color: primary, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Text('Weekly Report', style: AppTypography.titleMedium(onBg)),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.lg,
            runSpacing: AppSpacing.sm,
            children: [
              _Stat(label: 'Habits', value: '${report.habitsCompleted}/${report.habitsTotal}', muted: muted, onBg: onBg),
              _Stat(label: 'Tasks', value: '${report.tasksCompleted}', muted: muted, onBg: onBg),
              _Stat(label: 'Focus', value: '${report.focusMinutes}m', muted: muted, onBg: onBg),
              _Stat(label: 'Mood', value: report.avgMood.toStringAsFixed(1), muted: muted, onBg: onBg),
              _Stat(label: 'XP', value: '${report.xpEarned}', muted: muted, onBg: onBg),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 250.ms);
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  final Color muted;
  final Color onBg;

  const _Stat({required this.label, required this.value, required this.muted, required this.onBg});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: AppTypography.titleMedium(onBg)),
        Text(label, style: AppTypography.labelSmall(muted)),
      ],
    );
  }
}
