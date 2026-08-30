import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/features/tasks/data/models/task_model.dart';
import 'package:hybrid_tracker/features/tasks/domain/providers/task_providers.dart';
import 'package:hybrid_tracker/shared/widgets/ryve_button.dart';
import 'package:hybrid_tracker/shared/widgets/skeleton_widget.dart';
import 'package:hybrid_tracker/shared/widgets/xp_float_overlay.dart';

const _categories = ['Work', 'Personal', 'Health', 'Study', 'Errands', 'Other'];
const _categoryIcons = <String, IconData>{
  'Work': Icons.work_outline_rounded,
  'Personal': Icons.person_outline_rounded,
  'Health': Icons.favorite_outline_rounded,
  'Study': Icons.school_outlined,
  'Errands': Icons.shopping_bag_outlined,
  'Other': Icons.label_outline_rounded,
};

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
  String? _category;

  @override
  void initState() {
    super.initState();
    _loadCategory();
  }

  Future<void> _loadCategory() async {
    final prefs = await SharedPreferences.getInstance();
    final cat = prefs.getString('task_cat_${widget.taskId}');
    if (mounted) setState(() => _category = cat);
  }

  Future<void> _saveCategory(String? cat) async {
    final prefs = await SharedPreferences.getInstance();
    if (cat == null) {
      await prefs.remove('task_cat_${widget.taskId}');
    } else {
      await prefs.setString('task_cat_${widget.taskId}', cat);
    }
    if (mounted) setState(() => _category = cat);
  }

  @override
  void dispose() {
    _subtaskController.dispose();
    _subtaskFocusNode.dispose();
    super.dispose();
  }

  Future<void> _completeTask(BuildContext context, TaskModel task) async {
    setState(() => _isCompleting = true);
    try {
      await ref.read(taskNotifierProvider.notifier).completeTask(task.id);
      if (!context.mounted) return;
      XpFloatOverlay.show(context, 10);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Task completed'),
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () async {
              await ref.read(taskNotifierProvider.notifier).updateTask(
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
      await Future.delayed(const Duration(milliseconds: 500));
      if (context.mounted) context.pop();
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
            child: const Text('Delete', style: TextStyle(color: AppColors.priorityUrgent)),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await ref.read(taskNotifierProvider.notifier).deleteTask(widget.taskId);
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
    if (picked == null || !mounted) return;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: task.dueDate != null
          ? TimeOfDay.fromDateTime(task.dueDate!)
          : const TimeOfDay(hour: 9, minute: 0),
    );
    final finalDate = DateTime(
      picked.year, picked.month, picked.day,
      pickedTime?.hour ?? (task.dueDate?.hour ?? 9),
      pickedTime?.minute ?? (task.dueDate?.minute ?? 0),
    );
    await ref.read(taskNotifierProvider.notifier).updateTask(
          task.copyWith(dueDate: finalDate, updatedAt: DateTime.now()),
        );
  }

  void _openEditSheet(BuildContext context, TaskModel task) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _TaskEditSheet(
        task: task,
        category: _category,
        onSave: (updated, cat) async {
          await ref.read(taskNotifierProvider.notifier).updateTask(updated);
          await _saveCategory(cat);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncTask = ref.watch(taskByIdProvider(widget.taskId));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).colorScheme.onSurface, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          asyncTask.maybeWhen(
            data: (task) => task != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit_outlined, color: gold),
                        tooltip: 'Edit task',
                        onPressed: () => _openEditSheet(context, task),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded,
                            color: AppColors.priorityUrgent),
                        tooltip: 'Delete task',
                        onPressed: () => _deleteTask(context),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            orElse: () => const SizedBox.shrink(),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: asyncTask.when(
        loading: () => const _DetailSkeleton(),
        error: (err, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline_rounded, size: 48,
                  color: AppColors.priorityUrgent.withValues(alpha: 0.7)),
              const SizedBox(height: AppSpacing.lg),
              Text('Failed to load task',
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        data: (task) {
          if (task == null) return const Center(child: Text('Task not found.'));
          return _TaskDetailBody(
            task: task,
            onPriorityChange: (p) => _changePriority(task, p),
            onDueDateTap: () => _changeDueDate(task),
            onSubtaskToggle: (id) =>
                ref.read(taskNotifierProvider.notifier).toggleSubtask(id),
            onAddSubtask: () => _addSubtask(task),
            subtaskController: _subtaskController,
            subtaskFocusNode: _subtaskFocusNode,
            category: _category,
            onCategoryChange: _saveCategory,
            onComplete: task.isCompleted ? null : () => _completeTask(context, task),
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
    required this.category,
    required this.onCategoryChange,
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
  final String? category;
  final ValueChanged<String?> onCategoryChange;
  final VoidCallback? onComplete;
  final bool isCompleting;

  String _formatTime(DateTime dt) {
    final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final m = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour < 12 ? 'AM' : 'PM';
    return '$h:$m $ampm';
  }

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
          // Title (tap to edit)
          _SectionFade(
            index: 0,
            disabled: disableAnimations,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  height: 28,
                  margin: const EdgeInsets.only(top: 4, right: AppSpacing.md),
                  decoration: BoxDecoration(
                    color: priorityColor,
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                ),
                Expanded(
                  child: Text(
                    task.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: task.isCompleted
                              ? colorScheme.onSurface.withValues(alpha: 0.45)
                              : colorScheme.onSurface,
                          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
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
                        Expanded(
                          child: task.dueDate != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${task.dueDate!.day}/${task.dueDate!.month}/${task.dueDate!.year}',
                                      style: TextStyle(color: colorScheme.onSurface, fontSize: 15),
                                    ),
                                    Text(
                                      _formatTime(task.dueDate!),
                                      style: TextStyle(color: goldColor, fontSize: 13),
                                    ),
                                  ],
                                )
                              : Text(
                                  'Set due date & time',
                                  style: TextStyle(
                                    color: colorScheme.onSurface.withOpacity(0.4),
                                    fontSize: 15,
                                  ),
                                ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: colorScheme.onSurface.withOpacity(0.3),
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

          // Category
          _SectionFade(
            index: 5,
            disabled: disableAnimations,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionLabel('Category'),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: _categories.map((cat) {
                    final selected = category == cat;
                    final icon = _categoryIcons[cat] ?? Icons.label_outline_rounded;
                    return GestureDetector(
                      onTap: () => onCategoryChange(selected ? null : cat),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: selected ? goldColor.withOpacity(0.15) : Colors.transparent,
                          border: Border.all(
                            color: selected ? goldColor : colorScheme.onSurface.withOpacity(0.2),
                            width: selected ? 1.5 : 1,
                          ),
                          borderRadius: BorderRadius.circular(AppRadius.xl),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(icon, size: 14, color: selected ? goldColor : colorScheme.onSurface.withOpacity(0.5)),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              cat,
                              style: TextStyle(
                                fontSize: 13,
                                color: selected ? goldColor : colorScheme.onSurface.withOpacity(0.6),
                                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xxl),

          // Subtasks
          _SectionFade(
            index: 6,
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
              index: 7,
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

// ---------------------------------------------------------------------------
// Edit bottom sheet
// ---------------------------------------------------------------------------
class _TaskEditSheet extends StatefulWidget {
  const _TaskEditSheet({
    required this.task,
    required this.category,
    required this.onSave,
  });

  final TaskModel task;
  final String? category;
  final Future<void> Function(TaskModel updated, String? category) onSave;

  @override
  State<_TaskEditSheet> createState() => _TaskEditSheetState();
}

class _TaskEditSheetState extends State<_TaskEditSheet> {
  late final TextEditingController _titleCtrl;
  late final TextEditingController _descCtrl;
  late DateTime? _dueDate;
  late String? _category;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.task.title);
    _descCtrl = TextEditingController(text: widget.task.description ?? '');
    _dueDate = widget.task.dueDate;
    _category = widget.category;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (picked == null || !mounted) return;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _dueDate != null
          ? TimeOfDay.fromDateTime(_dueDate!)
          : const TimeOfDay(hour: 9, minute: 0),
    );
    if (!mounted) return;
    setState(() {
      _dueDate = DateTime(
        picked.year, picked.month, picked.day,
        pickedTime?.hour ?? (_dueDate?.hour ?? 9),
        pickedTime?.minute ?? (_dueDate?.minute ?? 0),
      );
    });
  }

  Future<void> _save() async {
    final title = _titleCtrl.text.trim();
    if (title.isEmpty) return;
    setState(() => _saving = true);
    final updated = widget.task.copyWith(
      title: title,
      description: _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
      dueDate: _dueDate,
      updatedAt: DateTime.now(),
    );
    await widget.onSave(updated, _category);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final colorScheme = Theme.of(context).colorScheme;
    final muted = colorScheme.onSurface.withValues(alpha: 0.5);

    String _fmt(DateTime dt) {
      final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
      final m = dt.minute.toString().padLeft(2, '0');
      final ampm = dt.hour < 12 ? 'AM' : 'PM';
      return '${dt.day}/${dt.month}/${dt.year}  $h:$m $ampm';
    }

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.x3l,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.onSurface.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Edit Task',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: AppSpacing.xl),

            // Title field
            TextField(
              controller: _titleCtrl,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(color: colorScheme.onSurface),
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: muted),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: BorderSide(color: gold, width: 1.5),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Description field
            TextField(
              controller: _descCtrl,
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(color: colorScheme.onSurface),
              decoration: InputDecoration(
                labelText: 'Description (optional)',
                labelStyle: TextStyle(color: muted),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: BorderSide(color: gold, width: 1.5),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Due date row
            Text('DUE DATE',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: muted, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
            const SizedBox(height: AppSpacing.sm),
            InkWell(
              onTap: _pickDueDate,
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: colorScheme.onSurface.withValues(alpha: 0.2)),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 18,
                        color: _dueDate != null ? gold : muted),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        _dueDate != null ? _fmt(_dueDate!) : 'Set date & time',
                        style: TextStyle(
                            color: _dueDate != null
                                ? colorScheme.onSurface
                                : muted),
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded, color: muted, size: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Category chips
            Text('CATEGORY',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: muted, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: _categories.map((cat) {
                final selected = _category == cat;
                final icon = _categoryIcons[cat] ?? Icons.label_outline_rounded;
                return GestureDetector(
                  onTap: () => setState(
                      () => _category = selected ? null : cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: selected
                          ? gold.withValues(alpha: 0.15)
                          : Colors.transparent,
                      border: Border.all(
                        color: selected
                            ? gold
                            : colorScheme.onSurface.withValues(alpha: 0.2),
                        width: selected ? 1.5 : 1,
                      ),
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon,
                            size: 14,
                            color: selected
                                ? gold
                                : colorScheme.onSurface.withValues(alpha: 0.5)),
                        const SizedBox(width: AppSpacing.xs),
                        Text(cat,
                            style: TextStyle(
                              fontSize: 13,
                              color: selected
                                  ? gold
                                  : colorScheme.onSurface.withValues(alpha: 0.6),
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            )),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.x3l),

            // Save button
            RyveButton(
              label: _saving ? 'Saving…' : 'Save Changes',
              isLoading: _saving,
              onPressed: _saving ? null : _save,
            ),
          ],
        ),
      ),
    );
  }
}
