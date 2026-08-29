import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/features/habits/data/models/habit_model.dart';
import 'package:hybrid_tracker/features/habits/domain/providers/habit_providers.dart';
import 'package:hybrid_tracker/shared/widgets/ryve_button.dart';
import 'package:hybrid_tracker/shared/widgets/xp_float_overlay.dart';

const _moodEmoji = ['😞', '😕', '😐', '🙂', '😄'];

class LogHabitBottomSheet extends ConsumerStatefulWidget {
  const LogHabitBottomSheet({super.key, required this.habit});

  final HabitModel habit;

  static Future<void> show(BuildContext context, HabitModel habit) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
        child: LogHabitBottomSheet(habit: habit),
      ),
    );
  }

  @override
  ConsumerState<LogHabitBottomSheet> createState() =>
      _LogHabitBottomSheetState();
}

class _LogHabitBottomSheetState extends ConsumerState<LogHabitBottomSheet> {
  int? _selectedMood;
  double _countValue = 1;
  bool _saving = false;

  bool get _isCountHabit => widget.habit.targetValue > 1;

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await ref.read(habitNotifierProvider.notifier).logHabit(
            widget.habit.id,
            value: _countValue,
            moodAfter: _selectedMood,
          );
      if (mounted) {
        XpFloatOverlay.show(context, 5);
        Navigator.of(context).pop();
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final disableAnimations = MediaQuery.of(context).disableAnimations;

    final sheetBg = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final handleColor =
        isDark ? AppColors.darkSurfaceBright : AppColors.lightSurfaceVariant;

    Widget sheet = Container(
      decoration: BoxDecoration(
        color: sheetBg,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.xl),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xxl,
        AppSpacing.md,
        AppSpacing.xxl,
        AppSpacing.xxl,
      ),
      child: SingleChildScrollView(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: handleColor,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Header
          Row(
            children: [
              Text(
                widget.habit.iconEmoji,
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Log Habit',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: cs.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      widget.habit.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          // Count stepper (only for count habits)
          if (_isCountHabit) ...[
            Text(
              'How many ${widget.habit.unit ?? 'times'}?',
              style: theme.textTheme.labelMedium?.copyWith(
                color: cs.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _CountStepper(
              value: _countValue,
              max: (widget.habit.targetValue * 3).toDouble(),
              unit: widget.habit.unit,
              isDark: isDark,
              onChanged: (v) => setState(() => _countValue = v),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
          // Mood selector
          Text(
            'How do you feel after?',
            style: theme.textTheme.labelMedium?.copyWith(
              color: cs.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _MoodSelector(
            selected: _selectedMood,
            onSelect: (i) => setState(() => _selectedMood = i),
            disableAnimations: disableAnimations,
          ),
          const SizedBox(height: AppSpacing.x3l),
          // Save button
          SizedBox(
            width: double.infinity,
            child: RyveButton(
              label: 'Save Log',
              isLoading: _saving,
              onPressed: _saving ? null : _save,
            ),
          ),
        ],
        ),
      ),
    );

    if (!disableAnimations) {
      sheet = sheet
          .animate()
          .slideY(begin: 0.15, end: 0, duration: 280.ms, curve: Curves.easeOut)
          .fadeIn(duration: 200.ms);
    }

    return sheet;
  }
}

// ---------------------------------------------------------------------------
// Count stepper
// ---------------------------------------------------------------------------
class _CountStepper extends StatelessWidget {
  const _CountStepper({
    required this.value,
    required this.max,
    required this.unit,
    required this.isDark,
    required this.onChanged,
  });

  final double value;
  final double max;
  final String? unit;
  final bool isDark;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final surface =
        isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant;

    return Row(
      children: [
        // Decrement
        _StepperButton(
          icon: Icons.remove_rounded,
          isDark: isDark,
          onTap: value > 1 ? () => onChanged(value - 1) : null,
        ),
        const SizedBox(width: AppSpacing.md),
        // Value display
        Expanded(
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value.toInt().toString(),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (unit != null) ...[
                  const SizedBox(width: 4),
                  Text(
                    unit!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: primary.withOpacity(0.7),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        // Increment
        _StepperButton(
          icon: Icons.add_rounded,
          isDark: isDark,
          onTap: value < max ? () => onChanged(value + 1) : null,
        ),
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({
    required this.icon,
    required this.isDark,
    required this.onTap,
  });

  final IconData icon;
  final bool isDark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final surface =
        isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant;
    final enabled = onTap != null;

    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          HapticFeedback.selectionClick();
          onTap!();
        }
      },
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: enabled ? primary : surface,
        ),
        child: Icon(
          icon,
          color: enabled
              ? AppColors.darkBackground
              : (isDark
                  ? AppColors.darkOnSurfaceMuted
                  : AppColors.lightOnSurfaceMuted),
          size: 20,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Mood selector — 5 emoji row
// ---------------------------------------------------------------------------
class _MoodSelector extends StatelessWidget {
  const _MoodSelector({
    required this.selected,
    required this.onSelect,
    required this.disableAnimations,
  });

  final int? selected;
  final ValueChanged<int> onSelect;
  final bool disableAnimations;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_moodEmoji.length, (i) {
        final isSelected = selected == i;

        Widget emoji = GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            onSelect(i);
          },
          child: AspectRatio(
            aspectRatio: 1,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 52, maxHeight: 52),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? (Theme.of(context).brightness == Brightness.dark
                          ? AppColors.darkSurfaceBright
                          : AppColors.lightSurfaceBright)
                      : Colors.transparent,
                  border: isSelected
                      ? Border.all(
                          color: AppColors.darkPrimary,
                          width: 2,
                        )
                      : null,
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  child: Text(
                    _moodEmoji[i],
                    style: TextStyle(
                      fontSize: isSelected ? 26 : 22,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

        if (!disableAnimations && isSelected) {
          emoji = emoji
              .animate(key: ValueKey('mood_$i'))
              .scale(
                begin: const Offset(0.85, 0.85),
                end: const Offset(1.0, 1.0),
                duration: 200.ms,
                curve: Curves.elasticOut,
              );
        }

        return Expanded(child: Center(child: emoji));
      }),
    );
  }
}
