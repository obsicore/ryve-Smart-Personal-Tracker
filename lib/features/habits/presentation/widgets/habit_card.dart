import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/features/habits/data/models/habit_model.dart';
import 'package:hybrid_tracker/features/habits/domain/providers/habit_providers.dart';
import 'package:hybrid_tracker/shared/widgets/xp_float_overlay.dart';

// Category → background tint mapping
Color _categoryColor(String category, bool isDark) {
  switch (category.toLowerCase()) {
    case 'health':
      return isDark
          ? const Color(0xFF1E3828)
          : const Color(0xFFD4EDDA);
    case 'productivity':
      return isDark
          ? const Color(0xFF1A2E3F)
          : const Color(0xFFD1ECF1);
    case 'learning':
      return isDark
          ? const Color(0xFF2A2010)
          : const Color(0xFFFFF3CD);
    case 'mindfulness':
      return isDark
          ? const Color(0xFF261A32)
          : const Color(0xFFE2D9F3);
    case 'fitness':
      return isDark
          ? const Color(0xFF2A1410)
          : const Color(0xFFF8D7DA);
    default:
      return isDark
          ? const Color(0xFF1E3828)
          : const Color(0xFFE8F5E9);
  }
}

class HabitCard extends ConsumerStatefulWidget {
  const HabitCard({super.key, required this.habit, this.onTap});

  final HabitModel habit;
  final VoidCallback? onTap;

  @override
  ConsumerState<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends ConsumerState<HabitCard>
    with SingleTickerProviderStateMixin {
  final _logButtonKey = GlobalKey();
  bool _shimmerActive = false;

  Future<void> _handleLogTap() async {
    if (widget.habit.completedToday) return;

    setState(() => _shimmerActive = true);

    // Show XP float from log button position
    final ctx = _logButtonKey.currentContext;
    if (ctx != null && ctx.mounted) {
      XpFloatOverlay.show(ctx, 5);
    }

    await ref
        .read(habitNotifierProvider.notifier)
        .logHabit(widget.habit.id, value: 1.0);

    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) setState(() => _shimmerActive = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final disableAnimations = MediaQuery.of(context).disableAnimations;

    final habit = widget.habit;
    final cardBg = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final catColor = _categoryColor(habit.category, isDark);

    Widget card = GestureDetector(
      onTap: widget.onTap,
      child: Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm / 2,
      ),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Stack(
          children: [
            // Shimmer overlay on completion
            if (_shimmerActive && !disableAnimations)
              Positioned.fill(
                child: Container(color: AppColors.darkSecondary.withOpacity(0))
                    .animate()
                    .shimmer(
                      duration: 400.ms,
                      color: AppColors.darkSecondary.withOpacity(0.15),
                    ),
              ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Emoji icon in category-coloured circle
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: catColor,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      habit.iconEmoji,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  // Name, category chip, week dots
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          habit.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: cs.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        _CategoryChip(category: habit.category, isDark: isDark),
                        const SizedBox(height: AppSpacing.sm),
                        _WeekDots(completedDates: habit.completedDates),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  // Streak count + log button
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '🔥 ${habit.currentStreak}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: cs.onSurface.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _LogButton(
                        key: _logButtonKey,
                        isDone: habit.completedToday,
                        onTap: _handleLogTap,
                        disableAnimations: disableAnimations,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),   // closes Container
    );   // closes GestureDetector

    return card;
  }
}

// ---------------------------------------------------------------------------
// Category chip
// ---------------------------------------------------------------------------
class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.category, required this.isDark});

  final String category;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final label = category[0].toUpperCase() + category.substring(1);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: (isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceBright),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isDark
                  ? AppColors.darkOnSurfaceMuted
                  : AppColors.lightOnSurfaceMuted,
              fontSize: 10,
            ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Week streak dots — Mon to Sun
// ---------------------------------------------------------------------------
class _WeekDots extends StatelessWidget {
  const _WeekDots({required this.completedDates});

  final List<DateTime> completedDates;

  static const _dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final today = DateTime.now();
    final todayNorm = DateTime(today.year, today.month, today.day);
    // Monday = weekday 1 → offset = weekday - 1
    final weekStart = todayNorm.subtract(Duration(days: todayNorm.weekday - 1));

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(7, (i) {
        final day = weekStart.add(Duration(days: i));
        final isToday = _isSameDay(day, todayNorm);
        final isFuture = day.isAfter(todayNorm);
        final isCompleted =
            completedDates.any((d) => _isSameDay(d, day));

        Color dotColor;
        double size;
        bool filled;

        if (isCompleted) {
          dotColor = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;
          size = isToday ? 10 : 8;
          filled = true;
        } else if (isToday) {
          dotColor = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
          size = 10;
          filled = true;
        } else if (isFuture) {
          dotColor = (isDark
                  ? AppColors.darkOnSurfaceMuted
                  : AppColors.lightOnSurfaceMuted)
              .withOpacity(0.25);
          size = 8;
          filled = false;
        } else {
          // past, not completed
          dotColor = (isDark
                  ? AppColors.darkOnSurfaceMuted
                  : AppColors.lightOnSurfaceMuted)
              .withOpacity(0.4);
          size = 8;
          filled = false;
        }

        return Padding(
          padding: const EdgeInsets.only(right: AppSpacing.xs),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: filled ? dotColor : Colors.transparent,
                  border: filled
                      ? null
                      : Border.all(color: dotColor, width: 1),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _dayLabels[i],
                style: TextStyle(
                  fontSize: 8,
                  color: (isDark
                          ? AppColors.darkOnSurfaceMuted
                          : AppColors.lightOnSurfaceMuted)
                      .withOpacity(isFuture ? 0.3 : 0.6),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// ---------------------------------------------------------------------------
// Log button — circular gold, checkmark when done, spring pulse on tap
// ---------------------------------------------------------------------------
class _LogButton extends StatefulWidget {
  const _LogButton({
    super.key,
    required this.isDone,
    required this.onTap,
    required this.disableAnimations,
  });

  final bool isDone;
  final VoidCallback onTap;
  final bool disableAnimations;

  @override
  State<_LogButton> createState() => _LogButtonState();
}

class _LogButtonState extends State<_LogButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 100),
    );
    _scaleAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.08), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.08, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _tap() {
    if (!widget.disableAnimations) {
      _controller.forward(from: 0);
    }
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final secondary = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;

    final bgColor = widget.isDone ? secondary : primary;
    final iconColor = widget.isDone
        ? (isDark ? AppColors.darkBackground : Colors.white)
        : AppColors.darkBackground;

    return GestureDetector(
      onTap: _tap,
      child: AnimatedBuilder(
        animation: _scaleAnim,
        builder: (_, child) =>
            Transform.scale(scale: _scaleAnim.value, child: child),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bgColor,
          ),
          child: Icon(
            widget.isDone ? Icons.check_rounded : Icons.add_rounded,
            color: iconColor,
            size: 18,
          ),
        ),
      ),
    );
  }
}
