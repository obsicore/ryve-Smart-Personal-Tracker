import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/features/tasks/data/models/task_model.dart';
import 'package:hybrid_tracker/features/tasks/domain/providers/task_providers.dart';
import 'package:hybrid_tracker/shared/widgets/xp_float_overlay.dart';

class TaskCard extends ConsumerStatefulWidget {
  const TaskCard({
    super.key,
    required this.task,
    this.animationIndex = 0,
  });

  final TaskModel task;
  final int animationIndex;

  @override
  ConsumerState<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends ConsumerState<TaskCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 80),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  Color _priorityColor(BuildContext context) {
    switch (widget.task.priority) {
      case TaskPriority.urgent:
        return AppColors.priorityUrgent;
      case TaskPriority.high:
        return AppColors.priorityHigh;
      case TaskPriority.medium:
        return AppColors.priorityMed;
      case TaskPriority.low:
        return AppColors.priorityLow;
    }
  }

  Future<bool?> _handleDismiss(
    BuildContext context,
    DismissDirection direction,
  ) async {
    if (direction == DismissDirection.startToEnd) {
      // Swipe right = complete
      if (!widget.task.isCompleted) {
        await ref
            .read(taskNotifierProvider.notifier)
            .completeTask(widget.task.id);
        if (context.mounted) {
          XpFloatOverlay.show(context, 10);
        }
      }
      return true;
    } else {
      // Swipe left = delete — confirm first
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Delete task?'),
          content: const Text('This cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                'Delete',
                style: TextStyle(color: AppColors.priorityUrgent),
              ),
            ),
          ],
        ),
      );
      if (confirmed == true) {
        await ref
            .read(taskNotifierProvider.notifier)
            .deleteTask(widget.task.id);
        return true;
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.of(context).disableAnimations;
    final colorScheme = Theme.of(context).colorScheme;
    final priorityColor = _priorityColor(context);
    final isCompleted = widget.task.isCompleted;

    final card = Dismissible(
      key: ValueKey(widget.task.id),
      direction: DismissDirection.horizontal,
      confirmDismiss: (dir) => _handleDismiss(context, dir),
      background: _SwipeBg(
        alignment: Alignment.centerLeft,
        color: AppColors.darkSecondary.withOpacity(0.85),
        icon: Icons.check_circle_outline_rounded,
      ),
      secondaryBackground: _SwipeBg(
        alignment: Alignment.centerRight,
        color: AppColors.priorityUrgent.withOpacity(0.85),
        icon: Icons.delete_outline_rounded,
      ),
      child: GestureDetector(
        onTapDown: (_) => _scaleController.forward(),
        onTapUp: (_) => _scaleController.reverse(),
        onTapCancel: () => _scaleController.reverse(),
        onTap: () {
          _scaleController.reverse();
          // Navigation handled by parent
        },
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) =>
              Transform.scale(scale: _scaleAnimation.value, child: child),
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm / 2,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Priority left border strip
                    Container(
                      width: 4,
                      color: isCompleted
                          ? colorScheme.onSurface.withOpacity(0.2)
                          : priorityColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.md,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _TaskCheckbox(
                              isCompleted: isCompleted,
                              onTap: () async {
                                if (!isCompleted) {
                                  final task = widget.task;
                                  await ref
                                      .read(taskNotifierProvider.notifier)
                                      .completeTask(task.id);
                                  if (context.mounted) {
                                    XpFloatOverlay.show(context, 10);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('Task completed'),
                                        duration: const Duration(seconds: 4),
                                        action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () async {
                                            await ref
                                                .read(taskNotifierProvider.notifier)
                                                .updateTask(
                                                  task.copyWith(
                                                    isCompleted: false,
                                                    completedAt: null,
                                                    updatedAt: DateTime.now(),
                                                  ),
                                                );
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.task.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                decoration: isCompleted
                                                    ? TextDecoration.lineThrough
                                                    : null,
                                                color: isCompleted
                                                    ? colorScheme.onSurface
                                                        .withOpacity(0.45)
                                                    : colorScheme.onSurface,
                                              ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (widget.task.priority ==
                                          TaskPriority.urgent)
                                        _UrgentChip(
                                          disableAnimations: disableAnimations,
                                        ),
                                    ],
                                  ),
                                  if (widget.task.dueDate != null) ...[
                                    const SizedBox(height: AppSpacing.xs),
                                    _DueDateChip(
                                      dueDate: widget.task.dueDate!,
                                      isCompleted: isCompleted,
                                    ),
                                  ],
                                  if (widget.task.subtasks.isNotEmpty) ...[
                                    const SizedBox(height: AppSpacing.xs),
                                    _SubtaskProgress(
                                      subtasks: widget.task.subtasks,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            // Edit icon — absorbs tap so parent nav doesn't fire
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => context.push('/tasks/${widget.task.id}'),
                              child: Padding(
                                padding: const EdgeInsets.only(left: AppSpacing.sm),
                                child: Icon(
                                  Icons.edit_outlined,
                                  size: 18,
                                  color: colorScheme.onSurface.withOpacity(0.35),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (disableAnimations) return card;

    return card
        .animate(delay: Duration(milliseconds: widget.animationIndex * 30))
        .fadeIn(duration: 220.ms)
        .slideY(begin: 0.08, end: 0, duration: 220.ms, curve: Curves.easeOut);
  }
}

// ---------------------------------------------------------------------------
// Circular checkbox
// ---------------------------------------------------------------------------
class _TaskCheckbox extends StatelessWidget {
  const _TaskCheckbox({required this.isCompleted, required this.onTap});

  final bool isCompleted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final goldColor =
        isDark ? AppColors.darkPrimary : AppColors.lightAccent;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isCompleted ? goldColor : Colors.transparent,
          border: Border.all(
            color: isCompleted
                ? goldColor
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            width: 2,
          ),
        ),
        child: isCompleted
            ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
            : null,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Due date chip
// ---------------------------------------------------------------------------
class _DueDateChip extends StatelessWidget {
  const _DueDateChip({required this.dueDate, required this.isCompleted});

  final DateTime dueDate;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isOverdue = !isCompleted && dueDate.isBefore(now);
    final isToday = dueDate.year == now.year &&
        dueDate.month == now.month &&
        dueDate.day == now.day;

    final label = isToday
        ? 'Today'
        : DateFormat('MMM d').format(dueDate);

    final chipColor = isOverdue
        ? AppColors.priorityUrgent
        : isToday
            ? AppColors.priorityHigh
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.45);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.calendar_today_outlined, size: 12, color: chipColor),
        const SizedBox(width: 3),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: chipColor,
                fontWeight:
                    (isOverdue || isToday) ? FontWeight.w600 : FontWeight.w400,
              ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Subtask progress indicator
// ---------------------------------------------------------------------------
class _SubtaskProgress extends StatelessWidget {
  const _SubtaskProgress({required this.subtasks});

  final List<SubtaskModel> subtasks;

  @override
  Widget build(BuildContext context) {
    final done = subtasks.where((s) => s.isCompleted).length;
    final total = subtasks.length;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.checklist_rounded,
          size: 12,
          color:
              Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        ),
        const SizedBox(width: 3),
        Text(
          '$done/$total',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withOpacity(0.5),
              ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Urgent pulsing chip
// ---------------------------------------------------------------------------
class _UrgentChip extends StatelessWidget {
  const _UrgentChip({required this.disableAnimations});

  final bool disableAnimations;

  @override
  Widget build(BuildContext context) {
    final chip = Container(
      margin: const EdgeInsets.only(left: AppSpacing.sm),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.priorityUrgent.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(
          color: AppColors.priorityUrgent.withOpacity(0.6),
        ),
      ),
      child: Text(
        '🔴 Urgent',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.priorityUrgent,
              fontWeight: FontWeight.w600,
            ),
      ),
    );

    if (disableAnimations) return chip;

    return chip
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .fadeIn(duration: 600.ms)
        .then()
        .fadeOut(duration: 600.ms);
  }
}

// ---------------------------------------------------------------------------
// Swipe background
// ---------------------------------------------------------------------------
class _SwipeBg extends StatelessWidget {
  const _SwipeBg({
    required this.alignment,
    required this.color,
    required this.icon,
  });

  final Alignment alignment;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm / 2,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}
