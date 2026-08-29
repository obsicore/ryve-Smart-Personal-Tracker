import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/features/tasks/data/models/task_model.dart';
import 'package:hybrid_tracker/features/tasks/domain/providers/task_providers.dart';
import 'package:hybrid_tracker/shared/widgets/ryve_button.dart';
import 'package:hybrid_tracker/shared/widgets/skeleton_widget.dart';
import 'package:hybrid_tracker/shared/widgets/xp_float_overlay.dart';

const _uuid = Uuid();

class TaskDetailScreen extends ConsumerStatefulWidget {
  const TaskDetailScreen({super.key, required this.taskId});

  final String taskId;

  @override
  ConsumerState<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends ConsumerState<TaskDetailScreen> {
  final _subtaskController = TextEditingController();
  final _subtaskFocusNode = FocusNode();
  bool _isCompleting = false;

  @override
  void dispose() {
    _subtaskController.dispose();
    _subtaskFocusNode.dispose();
    super.dispose();
  }

  Future<void> _completeTask(BuildContext context) async {
    setState(() => _isCompleting = true);
    try {
      await ref
          .read(taskNotifierProvider.notifier)
          .completeTask(widget.taskId);
      if (context.mounted) {
        XpFloatOverlay.show(context, 10);
        await Future.delayed(const Duration(milliseconds: 900));
        if (context.mounted) context.pop();
      }
    } finally {
      if (mounted) setState(() => _isCompleting = false);
    }
  }

  Future<void> _deleteTask(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete task?'),
        content: const Text('This action cannot be undone.'),
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

    if (confirmed == true && context.mounted) {
      await ref
          .read(taskNotifierProvider.notifier)
          .deleteTask(widget.taskId);
      if (context.mounted) context.pop();
    }
  }

  Future<void> _addSubtask(TaskModel task) async {
    final title = _subtaskController.text.trim();
    if (title.isEmpty) return;

    final subtask = SubtaskModel(
      id: _uuid.v4(),
      taskId: task.id,
      title: title,
      order: task.subtasks.length,
    );
    _subtaskController.clear();
    await ref.read(taskNotifierProvider.notifier).createSubtask(subtask);
  }

  Future<void> _changePriority(TaskModel task, TaskPriority priority) async {
    await ref.read(taskNotifierProvider.notifier).updateTask(
          task.copyWith(
            priority: priority,
            isUrgent: priority == TaskPriority.urgent,
            updatedAt: DateTime.now(),
          ),
        );
  }

  Future<void> _changeDueDate(TaskModel task) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: task.dueDate ?? now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      await ref.read(taskNotifierProvider.notifier).updateTask(
            task.copyWith(dueDate: picked, updatedAt: DateTime.now()),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncTask = ref.watch(taskByIdProvider(widget.taskId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).colorScheme.onSurface, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          asyncTask.maybeWhen(
            data: (task) => task != null
                ? IconButton(
                    onPressed: () => _deleteTask(context),
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.priorityUrgent,
                    ),
                    tooltip: 'Delete task',
                  )
                : const SizedBox.shrink(),
            orElse: () => const SizedBox.shrink(),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: asyncTask.when(
        loading: () => const _DetailSkeleton(),
        error: (err, _) => Center(
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
                'Failed to load task',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        data: (task) {
          if (task == null) {
            return const Center(child: Text('Task not found.'));
          }
          return _TaskDetailBody(
            task: task,
            onPriorityChange: (p) => _changePriority(task, p),
            onDueDateTap: () => _changeDueDate(task),
            onSubtaskToggle: (id) =>
                ref.read(taskNotifierProvider.notifier).toggleSubtask(id),
            onAddSubtask: () => _addSubtask(task),
            subtaskController: _subtaskController,
            subtaskFocusNode: _subtaskFocusNode,
            onComplete: task.isCompleted
                ? null
                : () => _completeTask(context),
            isCompleting: _isCompleting,
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Body — extracted so we can use animations cleanly
// ---------------------------------------------------------------------------
class _TaskDetailBody extends StatelessWidget {
  const _TaskDetailBody({
    required this.task,
    required this.onPriorityChange,
    required this.onDueDateTap,
    required this.onSubtaskToggle,
    required this.onAddSubtask,
    required this.subtaskController,
    required this.subtaskFocusNode,
    required this.onComplete,
    required this.isCompleting,
  });

  final TaskModel task;
  final ValueChanged<TaskPriority> onPriorityChange;
  final VoidCallback onDueDateTap;
  final ValueChanged<String> onSubtaskToggle;
  final VoidCallback onAddSubtask;
  final TextEditingController subtaskController;
  final FocusNode subtaskFocusNode;
  final VoidCallback? onComplete;
  final bool isCompleting;

  Color _priorityColor(TaskPriority p) {
    switch (p) {
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

  String _priorityLabel(TaskPriority p) {
    switch (p) {
      case TaskPriority.urgent:
        return 'Urgent';
      case TaskPriority.high:
        return 'High';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.low:
        return 'Low';
    }
  }

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.of(context).disableAnimations;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final goldColor =
        isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final priorityColor = _priorityColor(task.priority);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          _SectionFade(
            index: 0,
            disabled: disableAnimations,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  height: 28,
                  margin: const EdgeInsets.only(
                      top: 4, right: AppSpacing.md),
                  decoration: BoxDecoration(
                    color: priorityColor,
                    borderRadius:
                        BorderRadius.circular(AppRadius.full),
                  ),
                ),
                Expanded(
                  child: Text(
                    task.title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: task.isCompleted
                              ? colorScheme.onSurface.withOpacity(0.45)
                              : colorScheme.onSurface,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                  ),
                ),
              ],
            ),
          ),

          if (task.isCompleted) ...[
            const SizedBox(height: AppSpacing.sm),
            _SectionFade(
              index: 1,
              disabled: disableAnimations,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkSecondary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  border: Border.all(
                    color: AppColors.darkSecondary.withOpacity(0.4),
                  ),
                ),
                child: Text(
                  'Completed',
                  style:
                      Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.darkSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                ),
              ),
            ),
          ],

          if (task.description != null &&
              task.description!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            _SectionFade(
              index: 2,
              disabled: disableAnimations,
              child: Text(
                task.description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                      height: 1.6,
                    ),
              ),
            ),
          ],

          const SizedBox(height: AppSpacing.xxl),
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.xxl),

          // Priority picker
          _SectionFade(
            index: 3,
            disabled: disableAnimations,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionLabel('Priority'),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: TaskPriority.values
                      .map(
                        (p) => Expanded(
                          child: _PriorityPickerChip(
                            label: _priorityLabel(p),
                            color: _priorityColor(p),
                            isSelected: task.priority == p,
                            onTap: () => onPriorityChange(p),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xxl),

          // Due date
          _SectionFade(
            index: 4,
            disabled: disableAnimations,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionLabel('Due Date'),
                const SizedBox(height: AppSpacing.md),
                InkWell(
                  onTap: onDueDateTap,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      border: Border.all(
                        color:
                            colorScheme.onSurface.withOpacity(0.15),
                      ),
                      borderRadius:
                          BorderRadius.circular(AppRadius.md),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 18,
                          color: task.dueDate != null
                              ? goldColor
                              : colorScheme.onSurface.withOpacity(0.4),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          task.dueDate != null
                              ? '${task.dueDate!.day}/${task.dueDate!.month}/${task.dueDate!.year}'
                              : 'Set due date',
                          style: TextStyle(
                            color: task.dueDate != null
                                ? colorScheme.onSurface
                                : colorScheme.onSurface
                                    .withOpacity(0.4),
                            fontSize: 15,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.chevron_right_rounded,
                          color:
                              colorScheme.onSurface.withOpacity(0.3),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xxl),

          // Subtasks
          _SectionFade(
            index: 5,
            disabled: disableAnimations,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionLabel(
                  'Subtasks (${task.subtasks.where((s) => s.isCompleted).length}/${task.subtasks.length})',
                ),
                const SizedBox(height: AppSpacing.md),

                // Subtask rows
                ...task.subtasks.asMap().entries.map(
                      (entry) => _SubtaskRow(
                        subtask: entry.value,
                        index: entry.key,
                        disableAnimations: disableAnimations,
                        onToggle: () => onSubtaskToggle(entry.value.id),
                      ),
                    ),

                const SizedBox(height: AppSpacing.sm),

                // Add subtask field
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: subtaskController,
                        focusNode: subtaskFocusNode,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Add a subtask…',
                          hintStyle: TextStyle(
                            color:
                                colorScheme.onSurface.withOpacity(0.4),
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(AppRadius.sm),
                            borderSide: BorderSide(
                              color: colorScheme.onSurface
                                  .withOpacity(0.2),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(AppRadius.sm),
                            borderSide: BorderSide(
                              color: colorScheme.onSurface
                                  .withOpacity(0.2),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(AppRadius.sm),
                            borderSide: BorderSide(
                              color: goldColor,
                              width: 1.5,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          isDense: true,
                        ),
                        onSubmitted: (_) => onAddSubtask(),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    IconButton(
                      onPressed: onAddSubtask,
                      icon: Icon(
                        Icons.add_circle_rounded,
                        color: goldColor,
                        size: 28,
                      ),
                      tooltip: 'Add subtask',
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.x3l),

          // Complete button
          if (onComplete != null)
            _SectionFade(
              index: 6,
              disabled: disableAnimations,
              child: RyveButton(
                label: 'Mark Complete',
                isLoading: isCompleting,
                onPressed: isCompleting ? null : onComplete,
              ),
            ),

          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Subtask row with stagger animation
// ---------------------------------------------------------------------------
class _SubtaskRow extends StatelessWidget {
  const _SubtaskRow({
    required this.subtask,
    required this.index,
    required this.disableAnimations,
    required this.onToggle,
  });

  final SubtaskModel subtask;
  final int index;
  final bool disableAnimations;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final goldColor =
        isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final colorScheme = Theme.of(context).colorScheme;

    final row = Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: subtask.isCompleted
                    ? goldColor.withOpacity(0.8)
                    : Colors.transparent,
                border: Border.all(
                  color: subtask.isCompleted
                      ? goldColor
                      : colorScheme.onSurface.withOpacity(0.35),
                  width: 1.5,
                ),
              ),
              child: subtask.isCompleted
                  ? const Icon(
                      Icons.check_rounded,
                      size: 12,
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              subtask.title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: subtask.isCompleted
                        ? colorScheme.onSurface.withOpacity(0.4)
                        : colorScheme.onSurface,
                    decoration: subtask.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
            ),
          ),
        ],
      ),
    );

    if (disableAnimations) return row;

    return row
        .animate(
          delay: Duration(milliseconds: index * 40),
        )
        .fadeIn(duration: 200.ms)
        .slideX(begin: -0.05, end: 0, duration: 200.ms);
  }
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------
class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color:
                Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
    );
  }
}

class _SectionFade extends StatelessWidget {
  const _SectionFade({
    required this.child,
    required this.index,
    required this.disabled,
  });

  final Widget child;
  final int index;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    if (disabled) return child;
    return child
        .animate(delay: Duration(milliseconds: index * 50))
        .fadeIn(duration: 250.ms)
        .slideY(begin: 0.05, end: 0, duration: 250.ms);
  }
}

class _PriorityPickerChip extends StatelessWidget {
  const _PriorityPickerChip({
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(right: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(
            color: isSelected ? color : color.withOpacity(0.35),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: isSelected
                      ? color
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.5),
                  fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.w400,
                  fontSize: 12,
                ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Skeleton for detail screen loading state
// ---------------------------------------------------------------------------
class _DetailSkeleton extends StatelessWidget {
  const _DetailSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonWidget(
              width: double.infinity, height: 28, borderRadius: AppRadius.sm),
          const SizedBox(height: AppSpacing.lg),
          SkeletonWidget(
              width: double.infinity, height: 14, borderRadius: AppRadius.xs),
          const SizedBox(height: AppSpacing.sm),
          SkeletonWidget(
              width: 220, height: 14, borderRadius: AppRadius.xs),
          const SizedBox(height: AppSpacing.x3l),
          SkeletonWidget(
              width: 80, height: 10, borderRadius: AppRadius.xs),
          const SizedBox(height: AppSpacing.md),
          SkeletonWidget(
              width: double.infinity, height: 44, borderRadius: AppRadius.md),
          const SizedBox(height: AppSpacing.xxl),
          SkeletonWidget(
              width: 80, height: 10, borderRadius: AppRadius.xs),
          const SizedBox(height: AppSpacing.md),
          SkeletonWidget(
              width: double.infinity, height: 48, borderRadius: AppRadius.md),
        ],
      ),
    );
  }
}
