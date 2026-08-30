import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/focus/data/models/focus_session_model.dart';
import 'package:hybrid_tracker/features/focus/domain/providers/focus_providers.dart';
import 'package:hybrid_tracker/features/focus/presentation/widgets/timer_ring.dart';
import 'package:hybrid_tracker/shared/widgets/ryve_bottom_nav.dart';
import 'package:hybrid_tracker/shared/widgets/skeleton_widget.dart';
import 'package:hybrid_tracker/shared/widgets/xp_float_overlay.dart';

class FocusScreen extends ConsumerStatefulWidget {
  const FocusScreen({super.key});

  @override
  ConsumerState<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends ConsumerState<FocusScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _showCustomTimerSheet(
    BuildContext context,
    FocusTimerNotifier notifier,
    Color primary,
    Color surface,
    Color onBg,
    Color muted,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _CustomTimerSheet(
        primaryColor: primary,
        surfaceColor: surface,
        onBg: onBg,
        muted: muted,
        onConfirm: (minutes) {
          notifier.setCustomDuration(minutes);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _onNavTap(int index) {
    switch (index) {
      case 0:
        context.go('/');
      case 1:
        context.go('/tasks');
      case 2:
        context.go('/alarms');
      case 3:
        context.go('/sleep');
      case 5:
        context.go('/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondary = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;

    ref.listen<FocusTimerState>(focusTimerNotifierProvider, (previous, next) {
      if (next.sessionType != FocusSessionType.work &&
          (previous?.completedSessions ?? 0) < next.completedSessions) {
        XpFloatOverlay.show(context, 15);
      }
    });

    final timerState = ref.watch(focusTimerNotifierProvider);
    final notifier = ref.read(focusTimerNotifierProvider.notifier);
    final settingsAsync = ref.watch(focusSettingsProvider);
    final settings = settingsAsync.valueOrNull;

    if (timerState.isRunning) {
      if (!_pulseController.isAnimating) {
        _pulseController.repeat(reverse: true);
      }
    } else {
      if (_pulseController.isAnimating) {
        _pulseController.stop();
        _pulseController.reset();
      }
    }

    final ringColor = timerState.sessionType == FocusSessionType.work
        ? primary
        : secondary;

    final sessionLabel = switch (timerState.sessionType) {
      FocusSessionType.work => 'Work',
      FocusSessionType.shortBreak => 'Short Break',
      FocusSessionType.longBreak => 'Long Break',
    };

    final sessionsBeforeLong = settings?.sessionsBeforeLongBreak ?? 4;

    return PopScope(
      canPop: context.canPop(),
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.go('/');
      },
      child: Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        surfaceTintColor: Colors.transparent,
        title: Text('Focus', style: AppTypography.headlineMedium(onBg)),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: AppSpacing.xl),

            // ----------------------------------------------------------------
            // Session type chips
            // ----------------------------------------------------------------
            _SessionChips(
              current: timerState.sessionType,
              isCustom: timerState.isCustom,
              enabled: !timerState.isRunning,
              primaryColor: primary,
              secondaryColor: secondary,
              surfaceColor: surface,
              onSurface: onSurface,
              muted: muted,
              onSelect: notifier.switchType,
              onCustomTap: () => _showCustomTimerSheet(context, notifier, primary, surface, onBg, muted),
            ),

            const SizedBox(height: AppSpacing.x3l),

            // ----------------------------------------------------------------
            // Timer ring
            // ----------------------------------------------------------------
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: child,
                );
              },
              child: SizedBox(
                width: 260,
                height: 260,
                child: TimerRing(
                  key: ValueKey(timerState.sessionType),
                  progress: timerState.progress,
                  timeText: timerState.formattedTime,
                  label: sessionLabel,
                  ringColor: ringColor,
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.04, end: 0, curve: Curves.easeOut),

            const SizedBox(height: AppSpacing.x3l),

            // ----------------------------------------------------------------
            // Controls
            // ----------------------------------------------------------------
            _ControlRow(
              timerState: timerState,
              primaryColor: primary,
              onSurface: onSurface,
              muted: muted,
              onStart: notifier.start,
              onPause: notifier.pause,
              onResume: notifier.resume,
              onReset: notifier.reset,
              onSkip: notifier.skip,
            ),

            const SizedBox(height: AppSpacing.xxl),

            // ----------------------------------------------------------------
            // Progress dots
            // ----------------------------------------------------------------
            _SessionProgress(
              completedSessions: timerState.completedSessions,
              sessionsBeforeLong: sessionsBeforeLong,
              currentType: timerState.sessionType,
              primaryColor: primary,
              muted: muted,
              onSurface: onSurface,
            ),

            const SizedBox(height: AppSpacing.xxl),

            Divider(color: muted.withValues(alpha: 0.3)),

            const SizedBox(height: AppSpacing.lg),

            // ----------------------------------------------------------------
            // Today section
            // ----------------------------------------------------------------
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Today', style: AppTypography.titleLarge(onSurface)),
            ),

            const SizedBox(height: AppSpacing.md),

            _TodayStats(
              primary: primary,
              secondary: secondary,
              onSurface: onSurface,
              muted: muted,
              surface: surface,
            ),

            const SizedBox(height: AppSpacing.x4l),
          ],
        ),
      ),
      bottomNavigationBar: RyveBottomNav(
        currentIndex: 4,
        onTap: _onNavTap,
      ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Session type chip row
// ---------------------------------------------------------------------------

class _SessionChips extends StatelessWidget {
  const _SessionChips({
    required this.current,
    required this.isCustom,
    required this.enabled,
    required this.primaryColor,
    required this.secondaryColor,
    required this.surfaceColor,
    required this.onSurface,
    required this.muted,
    required this.onSelect,
    required this.onCustomTap,
  });

  final FocusSessionType current;
  final bool isCustom;
  final bool enabled;
  final Color primaryColor;
  final Color secondaryColor;
  final Color surfaceColor;
  final Color onSurface;
  final Color muted;
  final ValueChanged<FocusSessionType> onSelect;
  final VoidCallback onCustomTap;

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[
      ...FocusSessionType.values.map((type) {
        final isSelected = !isCustom && current == type;
        final label = switch (type) {
          FocusSessionType.work => 'Work',
          FocusSessionType.shortBreak => 'Short Break',
          FocusSessionType.longBreak => 'Long Break',
        };
        final chipColor = type == FocusSessionType.work ? primaryColor : secondaryColor;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          child: GestureDetector(
            onTap: enabled ? () => onSelect(type) : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: isSelected ? chipColor.withValues(alpha: 0.15) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? chipColor : muted.withValues(alpha: 0.4),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(AppRadius.xl),
              ),
              child: Text(label, style: AppTypography.labelMedium(isSelected ? chipColor : muted)),
            ),
          ),
        );
      }),
      // Custom chip
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
        child: GestureDetector(
          onTap: enabled ? onCustomTap : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: isCustom ? primaryColor.withValues(alpha: 0.15) : Colors.transparent,
              border: Border.all(
                color: isCustom ? primaryColor : muted.withValues(alpha: 0.4),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.timer_outlined, size: 14, color: isCustom ? primaryColor : muted),
                const SizedBox(width: 4),
                Text('Custom', style: AppTypography.labelMedium(isCustom ? primaryColor : muted)),
              ],
            ),
          ),
        ),
      ),
    ];

    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: AppSpacing.xs,
      children: chips,
    );
  }
}

// ---------------------------------------------------------------------------
// Control buttons row
// ---------------------------------------------------------------------------

class _ControlRow extends StatelessWidget {
  const _ControlRow({
    required this.timerState,
    required this.primaryColor,
    required this.onSurface,
    required this.muted,
    required this.onStart,
    required this.onPause,
    required this.onResume,
    required this.onReset,
    required this.onSkip,
  });

  final FocusTimerState timerState;
  final Color primaryColor;
  final Color onSurface;
  final Color muted;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onReset;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final String mainLabel;
    final VoidCallback mainAction;

    if (timerState.isRunning) {
      mainLabel = 'Pause';
      mainAction = onPause;
    } else if (timerState.isPaused) {
      mainLabel = 'Resume';
      mainAction = onResume;
    } else {
      mainLabel = 'Start Focus';
      mainAction = onStart;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: onReset,
          style: TextButton.styleFrom(
            foregroundColor: muted,
          ),
          child: Text('Reset', style: AppTypography.labelLarge(muted)),
        ),
        const SizedBox(width: AppSpacing.xl),
        FilledButton(
          onPressed: mainAction,
          style: FilledButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: AppColors.darkOnPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.x3l,
              vertical: AppSpacing.md,
            ),
          ),
          child: Text(mainLabel, style: AppTypography.labelLarge(AppColors.darkOnPrimary)),
        ),
        const SizedBox(width: AppSpacing.xl),
        IconButton(
          onPressed: onSkip,
          icon: Icon(Icons.skip_next_rounded, color: muted),
          tooltip: 'Skip',
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Session progress dots
// ---------------------------------------------------------------------------

class _SessionProgress extends StatelessWidget {
  const _SessionProgress({
    required this.completedSessions,
    required this.sessionsBeforeLong,
    required this.currentType,
    required this.primaryColor,
    required this.muted,
    required this.onSurface,
  });

  final int completedSessions;
  final int sessionsBeforeLong;
  final FocusSessionType currentType;
  final Color primaryColor;
  final Color muted;
  final Color onSurface;

  @override
  Widget build(BuildContext context) {
    final cyclePosition = completedSessions % sessionsBeforeLong;
    final label = currentType == FocusSessionType.work
        ? 'Session ${cyclePosition + 1} of $sessionsBeforeLong'
        : 'Break time';

    return Column(
      children: [
        Text(label, style: AppTypography.bodySmall(muted)),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(sessionsBeforeLong, (i) {
            final isFilled = i < cyclePosition;
            final isCurrent =
                i == cyclePosition && currentType == FocusSessionType.work;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: isCurrent ? 20 : 10,
              height: 10,
              decoration: BoxDecoration(
                color: isFilled
                    ? primaryColor
                    : isCurrent
                        ? primaryColor.withValues(alpha: 0.5)
                        : muted.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(5),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Today stats
// ---------------------------------------------------------------------------

class _TodayStats extends ConsumerWidget {
  const _TodayStats({
    required this.primary,
    required this.secondary,
    required this.onSurface,
    required this.muted,
    required this.surface,
  });

  final Color primary;
  final Color secondary;
  final Color onSurface;
  final Color muted;
  final Color surface;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(todaySessionsProvider);
    final streakAsync = ref.watch(focusStreakProvider);

    return sessionsAsync.when(
      loading: () => Row(
        children: [
          Expanded(child: SkeletonWidget(width: double.infinity, height: 72)),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: SkeletonWidget(width: double.infinity, height: 72)),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: SkeletonWidget(width: double.infinity, height: 72)),
        ],
      ),
      error: (e, _) => Center(
        child: Text('Could not load stats', style: AppTypography.bodySmall(muted)),
      ),
      data: (sessions) {
        final workSessions = sessions
            .where((s) => s.sessionType == FocusSessionType.work)
            .toList();
        final totalMinutes =
            workSessions.fold(0, (sum, s) => sum + s.durationMinutes);
        final completedCount =
            workSessions.where((s) => s.wasCompleted).length;

        final hours = totalMinutes ~/ 60;
        final mins = totalMinutes % 60;
        final timeStr =
            hours > 0 ? '${hours}h ${mins}m' : '${mins}m';

        final streak = streakAsync.valueOrNull ?? 0;

        return Row(
          children: [
            Expanded(
              child: _StatTile(
                value: timeStr,
                label: 'Focus Time',
                icon: Icons.timer_outlined,
                iconColor: primary,
                surface: surface,
                onSurface: onSurface,
                muted: muted,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _StatTile(
                value: '$completedCount',
                label: 'Sessions',
                icon: Icons.check_circle_outline_rounded,
                iconColor: secondary,
                surface: surface,
                onSurface: onSurface,
                muted: muted,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _StatTile(
                value: '$streak',
                label: 'Day Streak',
                icon: Icons.local_fire_department_rounded,
                iconColor: AppColors.warning,
                surface: surface,
                onSurface: onSurface,
                muted: muted,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.value,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.surface,
    required this.onSurface,
    required this.muted,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color surface;
  final Color onSurface;
  final Color muted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(height: AppSpacing.xs),
          Text(value, style: AppTypography.titleLarge(onSurface)),
          Text(label, style: AppTypography.labelSmall(muted)),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 350.ms)
        .slideY(begin: 0.06, end: 0, curve: Curves.easeOut);
  }
}

// ---------------------------------------------------------------------------
// Custom timer bottom sheet
// ---------------------------------------------------------------------------

class _CustomTimerSheet extends StatefulWidget {
  const _CustomTimerSheet({
    required this.primaryColor,
    required this.surfaceColor,
    required this.onBg,
    required this.muted,
    required this.onConfirm,
  });

  final Color primaryColor;
  final Color surfaceColor;
  final Color onBg;
  final Color muted;
  final ValueChanged<int> onConfirm;

  @override
  State<_CustomTimerSheet> createState() => _CustomTimerSheetState();
}

class _CustomTimerSheetState extends State<_CustomTimerSheet> {
  int _minutes = 30;
  final _controller = TextEditingController(text: '30');

  static const _presets = [5, 10, 15, 20, 25, 30, 45, 60, 90];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setMinutes(int m) {
    setState(() {
      _minutes = m.clamp(1, 180);
      _controller.text = _minutes.toString();
      _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: widget.muted.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          Text('Custom Timer', style: AppTypography.titleMedium(widget.onBg)),
          const SizedBox(height: AppSpacing.xs),
          Text('Set your own focus duration', style: AppTypography.bodySmall(widget.muted)),

          const SizedBox(height: AppSpacing.xl),

          // Preset chips
          Text('Quick presets', style: AppTypography.labelSmall(widget.muted)),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: _presets.map((m) {
              final sel = _minutes == m;
              return GestureDetector(
                onTap: () => _setMinutes(m),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: sel ? widget.primaryColor.withValues(alpha: 0.15) : Colors.transparent,
                    border: Border.all(
                      color: sel ? widget.primaryColor : widget.muted.withValues(alpha: 0.35),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                  ),
                  child: Text(
                    '${m}m',
                    style: AppTypography.labelMedium(sel ? widget.primaryColor : widget.muted),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Manual input + stepper
          Text('Or enter minutes (1–180)', style: AppTypography.labelSmall(widget.muted)),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              IconButton(
                onPressed: () => _setMinutes(_minutes - 5),
                icon: Icon(Icons.remove_circle_outline_rounded, color: widget.primaryColor),
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: AppTypography.titleLarge(widget.onBg),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.sm)),
                    suffixText: 'min',
                  ),
                  onChanged: (v) {
                    final parsed = int.tryParse(v);
                    if (parsed != null) setState(() => _minutes = parsed.clamp(1, 180));
                  },
                ),
              ),
              IconButton(
                onPressed: () => _setMinutes(_minutes + 5),
                icon: Icon(Icons.add_circle_outline_rounded, color: widget.primaryColor),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.xl),

          // Slider
          Slider(
            value: _minutes.toDouble(),
            min: 1,
            max: 180,
            divisions: 179,
            activeColor: widget.primaryColor,
            inactiveColor: widget.primaryColor.withValues(alpha: 0.2),
            label: '${_minutes}m',
            onChanged: (v) => _setMinutes(v.round()),
          ),

          const SizedBox(height: AppSpacing.md),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => widget.onConfirm(_minutes),
              style: FilledButton.styleFrom(
                backgroundColor: widget.primaryColor,
                foregroundColor: AppColors.darkOnPrimary,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
              ),
              child: Text('Start ${_minutes}m Focus', style: AppTypography.labelLarge(AppColors.darkOnPrimary)),
            ),
          ),
        ],
      ),
    );
  }
}
