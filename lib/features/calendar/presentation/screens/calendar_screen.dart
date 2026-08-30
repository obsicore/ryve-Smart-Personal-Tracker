import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/calendar/data/models/calendar_event_model.dart';
import 'package:hybrid_tracker/features/calendar/domain/providers/calendar_providers.dart';
import 'package:hybrid_tracker/features/calendar/presentation/screens/create_event_screen.dart';
import 'package:hybrid_tracker/features/calendar/presentation/widgets/event_card_widget.dart';
import 'package:hybrid_tracker/features/tasks/data/models/task_model.dart';
import 'package:hybrid_tracker/features/tasks/domain/providers/task_providers.dart';
import 'package:hybrid_tracker/features/tasks/presentation/widgets/create_task_bottom_sheet.dart';
import 'package:hybrid_tracker/shared/widgets/skeleton_widget.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------
bool _isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

bool _isSameMonth(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month;

// ---------------------------------------------------------------------------
// Calendar screen
// ---------------------------------------------------------------------------
class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _monthAnimController;
  late Animation<double> _monthFadeAnim;
  late Animation<Offset> _monthSlideAnim;

  @override
  void initState() {
    super.initState();
    _monthAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _monthFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _monthAnimController, curve: Curves.easeIn),
    );
    _monthSlideAnim = Tween<Offset>(
      begin: const Offset(0.15, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _monthAnimController, curve: Curves.easeOut),
    );
    _monthAnimController.forward();
  }

  @override
  void dispose() {
    _monthAnimController.dispose();
    super.dispose();
  }

  void _changeMonth(int delta) {
    _monthAnimController.reset();
    final current = ref.read(focusedMonthProvider);
    ref.read(focusedMonthProvider.notifier).state = DateTime(
      current.year,
      current.month + delta,
      1,
    );
    _monthSlideAnim = Tween<Offset>(
      begin: Offset(delta * 0.15, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _monthAnimController, curve: Curves.easeOut),
    );
    _monthAnimController.forward();
  }

  void _selectDay(DateTime day) {
    ref.read(selectedDayProvider.notifier).state = day;
  }

  void _openCreateEvent() {
    final selected = ref.read(selectedDayProvider);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => CreateEventScreen(initialDate: selected),
      ),
    );
  }

  void _openCreateTask() {
    final selected = ref.read(selectedDayProvider);
    CreateTaskBottomSheet.show(context, initialDate: selected);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final onBg =
        isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final primary =
        isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    final authState = ref.watch(authStateProvider);
    final userId = authState.valueOrNull?.uid ?? '';

    final focusedMonth = ref.watch(focusedMonthProvider);
    final selectedDay = ref.watch(selectedDayProvider);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Text(
          'Calendar',
          style: AppTypography.titleLarge(onBg),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: onBg, size: 20),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        actions: [
          PopupMenuButton<void>(
            icon: Icon(Icons.add_rounded, color: primary, size: 26),
            tooltip: 'Add',
            onSelected: (_) {},
            itemBuilder: (context) => [
              PopupMenuItem<void>(
                onTap: _openCreateEvent,
                child: const Row(
                  children: [
                    Icon(Icons.event_outlined, size: 18),
                    SizedBox(width: AppSpacing.sm),
                    Text('Add Event'),
                  ],
                ),
              ),
              PopupMenuItem<void>(
                onTap: _openCreateTask,
                child: const Row(
                  children: [
                    Icon(Icons.check_box_outlined, size: 18),
                    SizedBox(width: AppSpacing.sm),
                    Text('Add Task with deadline'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          _MonthHeader(
            month: focusedMonth,
            onPrev: () => _changeMonth(-1),
            onNext: () => _changeMonth(1),
            isDark: isDark,
          ),
          const SizedBox(height: AppSpacing.sm),
          _WeekDayLabels(isDark: isDark),
          const SizedBox(height: AppSpacing.xs),
          _CalendarGrid(
            focusedMonth: focusedMonth,
            selectedDay: selectedDay,
            userId: userId,
            onDayTap: _selectDay,
            fadeAnim: _monthFadeAnim,
            slideAnim: _monthSlideAnim,
            isDark: isDark,
          ),
          const SizedBox(height: AppSpacing.md),
          Divider(
            height: 1,
            color: isDark
                ? AppColors.darkSurfaceVariant
                : AppColors.lightSurfaceVariant,
          ),
          Expanded(
            child: _DayEventsList(
              userId: userId,
              selectedDay: selectedDay,
              isDark: isDark,
              onAddTap: _openCreateEvent,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Month header
// ---------------------------------------------------------------------------
class _MonthHeader extends StatelessWidget {
  const _MonthHeader({
    required this.month,
    required this.onPrev,
    required this.onNext,
    required this.isDark,
  });

  final DateTime month;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final onBg =
        isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final label = DateFormat('MMMM yyyy').format(month);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left_rounded, color: primary, size: 28),
            onPressed: onPrev,
            splashRadius: 20,
          ),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: AppTypography.headlineMedium(onBg),
            ),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right_rounded, color: primary, size: 28),
            onPressed: onNext,
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Week day labels
// ---------------------------------------------------------------------------
class _WeekDayLabels extends StatelessWidget {
  const _WeekDayLabels({required this.isDark});

  final bool isDark;

  static const _labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    final muted =
        isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        children: _labels
            .map(
              (d) => Expanded(
                child: Text(
                  d,
                  textAlign: TextAlign.center,
                  style: AppTypography.labelSmall(muted),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Calendar grid
// ---------------------------------------------------------------------------
class _CalendarGrid extends ConsumerWidget {
  const _CalendarGrid({
    required this.focusedMonth,
    required this.selectedDay,
    required this.userId,
    required this.onDayTap,
    required this.fadeAnim,
    required this.slideAnim,
    required this.isDark,
  });

  final DateTime focusedMonth;
  final DateTime selectedDay;
  final String userId;
  final ValueChanged<DateTime> onDayTap;
  final Animation<double> fadeAnim;
  final Animation<Offset> slideAnim;
  final bool isDark;

  List<DateTime> _buildDays(DateTime month) {
    final firstWeekday = DateTime(month.year, month.month, 1).weekday;
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final prevMonthDays = DateTime(month.year, month.month, 0).day;

    final days = <DateTime>[];

    for (var i = firstWeekday - 2; i >= 0; i--) {
      days.add(DateTime(month.year, month.month - 1, prevMonthDays - i));
    }

    for (var d = 1; d <= daysInMonth; d++) {
      days.add(DateTime(month.year, month.month, d));
    }

    final remaining = 42 - days.length;
    for (var d = 1; d <= remaining; d++) {
      days.add(DateTime(month.year, month.month + 1, d));
    }

    return days;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthEventsAsync =
        ref.watch(monthEventsProvider(userId, focusedMonth));
    final events = monthEventsAsync.valueOrNull ?? [];
    final allTasksAsync = ref.watch(allTasksProvider);
    final tasksWithDeadline = (allTasksAsync.valueOrNull ?? [])
        .where((t) => t.dueDate != null)
        .toList();

    final days = _buildDays(focusedMonth);
    final today = DateTime.now();
    final todayNorm = DateTime(today.year, today.month, today.day);

    return FadeTransition(
      opacity: fadeAnim,
      child: SlideTransition(
        position: slideAnim,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 0,
              childAspectRatio: 0.85,
            ),
            itemCount: days.length,
            itemBuilder: (context, index) {
              final day = days[index];
              final isCurrentMonth =
                  _isSameMonth(day, focusedMonth);
              final isToday = _isSameDay(day, todayNorm);
              final isSelected = _isSameDay(day, selectedDay);
              final dayEvents = events
                  .where((e) => _isSameDay(e.startTime, day))
                  .take(3)
                  .toList();
              final dayTasks = tasksWithDeadline
                  .where((t) => _isSameDay(t.dueDate!, day))
                  .take(3)
                  .toList();

              final row = index ~/ 7;

              return _DayCell(
                day: day,
                isCurrentMonth: isCurrentMonth,
                isToday: isToday,
                isSelected: isSelected,
                events: dayEvents,
                taskCount: dayTasks.length,
                onTap: () => onDayTap(day),
                isDark: isDark,
                animDelay: Duration(milliseconds: row * 40),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Day cell
// ---------------------------------------------------------------------------
class _DayCell extends StatefulWidget {
  const _DayCell({
    required this.day,
    required this.isCurrentMonth,
    required this.isToday,
    required this.isSelected,
    required this.events,
    required this.taskCount,
    required this.onTap,
    required this.isDark,
    required this.animDelay,
  });

  final DateTime day;
  final bool isCurrentMonth;
  final bool isToday;
  final bool isSelected;
  final List<CalendarEventModel> events;
  final int taskCount;
  final VoidCallback onTap;
  final bool isDark;
  final Duration animDelay;

  @override
  State<_DayCell> createState() => _DayCellState();
}

class _DayCellState extends State<_DayCell>
    with SingleTickerProviderStateMixin {
  late AnimationController _tapController;
  late Animation<double> _tapScale;

  @override
  void initState() {
    super.initState();
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _tapScale = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _tapController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

  Color _parseColor(String hex) {
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (_) {
      return AppColors.darkSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary =
        widget.isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondary =
        widget.isDark ? AppColors.darkSecondary : AppColors.lightSecondary;
    final onBg = widget.isDark
        ? AppColors.darkOnBackground
        : AppColors.lightOnBackground;
    final muted = widget.isDark
        ? AppColors.darkOnSurfaceMuted
        : AppColors.lightOnSurfaceMuted;

    Color dayNumColor;
    Color? bgColor;

    if (widget.isSelected) {
      bgColor = secondary;
      dayNumColor = Colors.white;
    } else if (widget.isToday) {
      bgColor = primary;
      dayNumColor = widget.isDark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary;
    } else if (!widget.isCurrentMonth) {
      dayNumColor = muted;
    } else {
      dayNumColor = onBg;
    }

    Widget cell = GestureDetector(
      onTapDown: (_) => _tapController.forward(),
      onTapUp: (_) {
        _tapController.reverse();
        widget.onTap();
      },
      onTapCancel: () => _tapController.reverse(),
      child: ScaleTransition(
        scale: _tapScale,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: 150.ms,
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '${widget.day.day}',
                style: AppTypography.labelMedium(dayNumColor).copyWith(
                  fontWeight: widget.isToday || widget.isSelected
                      ? FontWeight.w700
                      : FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 2),
            if (widget.events.isNotEmpty || widget.taskCount > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...widget.events.take(3).map(
                        (e) => Container(
                          width: 5,
                          height: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: _parseColor(e.color),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  if (widget.taskCount > 0)
                    Container(
                      width: 5,
                      height: 5,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: secondary,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                ],
              )
            else
              const SizedBox(height: 7),
          ],
        ),
      ),
    );

    if (MediaQuery.of(context).disableAnimations) return cell;

    return cell
        .animate(delay: widget.animDelay)
        .fadeIn(duration: 180.ms)
        .scale(
          begin: const Offset(0.85, 0.85),
          end: const Offset(1, 1),
          duration: 180.ms,
          curve: Curves.easeOut,
        );
  }
}

// ---------------------------------------------------------------------------
// Day events list
// ---------------------------------------------------------------------------
class _DayEventsList extends ConsumerWidget {
  const _DayEventsList({
    required this.userId,
    required this.selectedDay,
    required this.isDark,
    required this.onAddTap,
  });

  final String userId;
  final DateTime selectedDay;
  final bool isDark;
  final VoidCallback onAddTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dayEventsAsync =
        ref.watch(dayEventsProvider(userId, selectedDay));
    final dayTasks = (ref.watch(allTasksProvider).valueOrNull ?? [])
        .where((t) => t.dueDate != null && _isSameDay(t.dueDate!, selectedDay))
        .toList()
      ..sort((a, b) => a.dueDate!.compareTo(b.dueDate!));
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondary = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;
    final onBg =
        isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final muted =
        isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    final headerLabel = DateFormat('EEEE, MMMM d').format(selectedDay);

    // Build a flat item list: [header, ...tasks, ...events]
    // This single ListView avoids nested scroll & overflow when task list is tall.
    return dayEventsAsync.when(
      loading: () => ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(headerLabel, style: AppTypography.titleMedium(onBg)),
          const SizedBox(height: AppSpacing.md),
          const SkeletonWidget(width: double.infinity, height: 72),
          const SizedBox(height: AppSpacing.md),
          const SkeletonWidget(width: double.infinity, height: 72),
        ],
      ),
      error: (_, __) => ListView(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        children: [
          Text(headerLabel, style: AppTypography.titleMedium(onBg)),
          const SizedBox(height: AppSpacing.xl),
          Icon(Icons.error_outline_rounded, color: AppColors.error, size: 40),
          const SizedBox(height: AppSpacing.md),
          Text('Could not load events', style: AppTypography.bodyMedium(onBg), textAlign: TextAlign.center),
        ],
      ),
      data: (events) {
        final hasContent = dayTasks.isNotEmpty || events.isNotEmpty;

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.x4l,
          ),
          itemCount: 1 + dayTasks.length + events.length + (hasContent ? 0 : 1),
          itemBuilder: (context, index) {
            // Header
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Text(headerLabel, style: AppTypography.titleMedium(onBg)),
              );
            }
            // Task items
            if (index <= dayTasks.length) {
              final task = dayTasks[index - 1];
              return _TaskDeadlineTile(
                task: task,
                secondary: secondary,
                onBg: onBg,
                muted: muted,
                isDark: isDark,
              );
            }
            // Empty state (no tasks and no events)
            if (!hasContent) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.x3l),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.event_available_rounded, color: muted, size: 48)
                          .animate()
                          .scale(
                            begin: const Offset(0.8, 0.8),
                            end: const Offset(1, 1),
                            duration: 350.ms,
                            curve: Curves.elasticOut,
                          ),
                      const SizedBox(height: AppSpacing.md),
                      Text('Nothing scheduled', style: AppTypography.titleMedium(onBg))
                          .animate().fadeIn(duration: 250.ms, delay: 80.ms),
                      const SizedBox(height: AppSpacing.sm),
                      Text('Tap + to add an event for this day.',
                              style: AppTypography.bodySmall(muted),
                              textAlign: TextAlign.center)
                          .animate().fadeIn(duration: 200.ms, delay: 160.ms),
                      const SizedBox(height: AppSpacing.x3l),
                      TextButton.icon(
                        onPressed: onAddTap,
                        icon: Icon(Icons.add_rounded, color: primary),
                        label: Text('Add Event', style: AppTypography.labelLarge(primary)),
                      ).animate().fadeIn(duration: 200.ms, delay: 240.ms),
                    ],
                  ),
                ),
              );
            }
            // Event items
            final eventIndex = index - 1 - dayTasks.length;
            final event = events[eventIndex];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: EventCardWidget(
                key: ValueKey(event.id),
                event: event,
                animationDelay: Duration(milliseconds: eventIndex * 30),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    fullscreenDialog: true,
                    builder: (_) => CreateEventScreen(existingEvent: event),
                  ),
                ),
                onDelete: () => ref
                    .read(calendarNotifierProvider.notifier)
                    .deleteEvent(event.id),
              ),
            );
          },
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Task deadline tile — shown in the day list alongside calendar events
// ---------------------------------------------------------------------------
class _TaskDeadlineTile extends ConsumerWidget {
  const _TaskDeadlineTile({
    required this.task,
    required this.secondary,
    required this.onBg,
    required this.muted,
    required this.isDark,
  });

  final TaskModel task;
  final Color secondary;
  final Color onBg;
  final Color muted;
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final due = task.dueDate!;
    final timeLabel = DateFormat('h:mm a').format(due);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: isDark ? Border.all(color: AppColors.darkSurfaceBright) : null,
      ),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(AppRadius.full),
            onTap: () =>
                ref.read(taskNotifierProvider.notifier).completeTask(task.id),
            child: Icon(
              task.isCompleted
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              size: 20,
              color: task.isCompleted ? secondary : muted,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              task.title,
              style: AppTypography.bodyMedium(onBg).copyWith(
                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                color: task.isCompleted ? muted : onBg,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          if (task.reminderMinutesBefore != null)
            Icon(Icons.alarm_rounded, size: 14, color: muted),
          const SizedBox(width: 2),
          Text(timeLabel, style: AppTypography.bodySmall(muted)),
        ],
      ),
    );
  }
}
