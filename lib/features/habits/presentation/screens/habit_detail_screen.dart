import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/habits/domain/providers/habit_providers.dart';
import 'package:hybrid_tracker/shared/widgets/skeleton_widget.dart';
import 'package:hybrid_tracker/shared/widgets/xp_float_overlay.dart';

class HabitDetailScreen extends ConsumerWidget {
  final String habitId;
  const HabitDetailScreen({super.key, required this.habitId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    // Derive this habit from the already-generated allHabitsProvider stream
    final habitAsync = ref.watch(allHabitsProvider).whenData(
          (habits) => habits.where((h) => h.id == habitId).firstOrNull,
        );

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        title: Text('Habit Detail', style: AppTypography.titleLarge(onBg)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: habitAsync.when(
        loading: () => _buildSkeleton(),
        error: (e, _) => Center(
          child: Text('Error loading habit', style: AppTypography.bodyMedium(AppColors.error)),
        ),
        data: (habit) {
          if (habit == null) {
            return Center(child: Text('Habit not found', style: AppTypography.bodyMedium(onBg)));
          }

          final isDark2 = isDark;
          final primary = isDark2 ? AppColors.darkPrimary : AppColors.lightPrimary;
          final secondary = isDark2 ? AppColors.darkSecondary : AppColors.lightSecondary;
          final onSurface = isDark2 ? AppColors.darkOnSurface : AppColors.lightOnSurface;
          final muted = isDark2 ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
          final disableAnims = MediaQuery.of(context).disableAnimations;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: secondary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: Center(child: Text(habit.iconEmoji, style: const TextStyle(fontSize: 28))),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(habit.name, style: AppTypography.headlineLarge(onBg)),
                          Text(habit.category, style: AppTypography.bodySmall(muted)),
                        ],
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 280.ms).slideY(begin: 0.06, end: 0),

                const SizedBox(height: AppSpacing.xxl),

                // Stats row
                Row(
                  children: [
                    _StatCard(
                      label: 'Current',
                      value: '${habit.currentStreak}',
                      unit: 'days',
                      color: primary,
                      isDark: isDark,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    _StatCard(
                      label: 'Best',
                      value: '${habit.longestStreak}',
                      unit: 'days',
                      color: secondary,
                      isDark: isDark,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    _StatCard(
                      label: 'Total Logs',
                      value: '${habit.completedDates.length}',
                      unit: 'times',
                      color: muted,
                      isDark: isDark,
                    ),
                  ],
                ).animate(delay: 60.ms).fadeIn(duration: 250.ms).slideY(begin: 0.06, end: 0),

                const SizedBox(height: AppSpacing.xxl),

                // Heatmap
                Text('30-Day Activity', style: AppTypography.titleMedium(onSurface)),
                const SizedBox(height: AppSpacing.md),
                _HabitHeatmap(
                  completedDates: habit.completedDates,
                  primary: primary,
                  secondary: secondary,
                  isDark: isDark,
                  disableAnims: disableAnims,
                ).animate(delay: 120.ms).fadeIn(duration: 250.ms),

                const SizedBox(height: AppSpacing.xxl),

                // Log button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: habit.completedToday
                        ? null
                        : () async {
                            await ref.read(habitNotifierProvider.notifier).logHabit(habitId);
                            if (context.mounted) {
                              final box = context.findRenderObject() as RenderBox?;
                              final pos = box?.localToGlobal(Offset(box.size.width / 2, box.size.height - 60));
                              XpFloatOverlay.show(context, 5, position: pos);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Habit logged! +5 XP')),
                              );
                            }
                          },
                    icon: Icon(habit.completedToday ? Icons.check_circle : Icons.check_circle_outline),
                    label: Text(habit.completedToday ? 'Completed Today!' : 'Log Habit'),
                  ),
                ).animate(delay: 200.ms).fadeIn(duration: 250.ms).slideY(begin: 0.1, end: 0),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSkeleton() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          SkeletonWidget(width: double.infinity, height: 60),
          const SizedBox(height: AppSpacing.xxl),
          Row(children: [
            Expanded(child: SkeletonWidget(width: double.infinity, height: 80)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: SkeletonWidget(width: double.infinity, height: 80)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: SkeletonWidget(width: double.infinity, height: 80)),
          ]),
          const SizedBox(height: AppSpacing.xxl),
          SkeletonWidget(width: double.infinity, height: 160),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color color;
  final bool isDark;

  const _StatCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: isDark ? Border.all(color: AppColors.darkSurfaceBright, width: 1) : null,
        ),
        child: Column(
          children: [
            Text(value, style: AppTypography.displayMedium(color)),
            Text(unit, style: AppTypography.bodySmall(muted)),
            const SizedBox(height: AppSpacing.xs),
            Text(label, style: AppTypography.labelSmall(onSurface)),
          ],
        ),
      ),
    );
  }
}

class _HabitHeatmap extends StatelessWidget {
  final List<DateTime> completedDates;
  final Color primary;
  final Color secondary;
  final bool isDark;
  final bool disableAnims;

  const _HabitHeatmap({
    required this.completedDates,
    required this.primary,
    required this.secondary,
    required this.isDark,
    required this.disableAnims,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final surfaceBright = isDark ? AppColors.darkSurfaceBright : AppColors.lightSurfaceBright;

    final days = List.generate(30, (i) => today.subtract(Duration(days: 29 - i)));

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      itemCount: 30,
      itemBuilder: (context, i) {
        final day = days[i];
        final isDone = completedDates.any(
          (d) => d.year == day.year && d.month == day.month && d.day == day.day,
        );
        final isToday = day == today;

        Widget cell = Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDone
                ? secondary.withOpacity(isToday ? 1.0 : 0.7)
                : isToday
                    ? primary.withOpacity(0.3)
                    : surfaceBright,
            border: isToday
                ? Border.all(color: primary, width: 1.5)
                : null,
          ),
          child: isDone
              ? Icon(Icons.check, size: 12, color: Colors.white)
              : null,
        );

        if (!disableAnims) {
          final col = i % 6;
          final row = i ~/ 6;
          final delay = ((row * 6 + col) * 15).ms;
          cell = cell
              .animate(delay: delay)
              .scale(begin: const Offset(0, 0), end: const Offset(1, 1), duration: 200.ms, curve: Curves.elasticOut);
        }

        return cell;
      },
    );
  }
}

