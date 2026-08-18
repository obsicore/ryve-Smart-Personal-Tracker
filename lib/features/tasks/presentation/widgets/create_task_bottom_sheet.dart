import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/tasks/data/models/task_model.dart';
import 'package:hybrid_tracker/features/tasks/domain/providers/task_providers.dart';
import 'package:hybrid_tracker/shared/widgets/ryve_button.dart';

const _uuid = Uuid();

class CreateTaskBottomSheet extends ConsumerStatefulWidget {
  const CreateTaskBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CreateTaskBottomSheet(),
    );
  }

  @override
  ConsumerState<CreateTaskBottomSheet> createState() =>
      _CreateTaskBottomSheetState();
}

class _CreateTaskBottomSheetState extends ConsumerState<CreateTaskBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _entryController;
  late Animation<double> _scaleAnimation;

  final _titleController = TextEditingController();
  final _focusNode = FocusNode();
  TaskPriority _selectedPriority = TaskPriority.medium;
  DateTime? _selectedDueDate;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 0.97, end: 1.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final disableAnimations =
          MediaQuery.of(context).disableAnimations;
      if (!disableAnimations) {
        _entryController.forward();
      }
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _entryController.dispose();
    _titleController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() => _selectedDueDate = picked);
    }
  }

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      _focusNode.requestFocus();
      return;
    }

    setState(() => _isSubmitting = true);

    final authState = ref.read(authStateProvider);
    final userId = authState.valueOrNull?.uid ?? '';
    final now = DateTime.now();

    final task = TaskModel(
      id: _uuid.v4(),
      userId: userId,
      title: title,
      priority: _selectedPriority,
      isUrgent: _selectedPriority == TaskPriority.urgent,
      dueDate: _selectedDueDate,
      createdAt: now,
      updatedAt: now,
    );

    try {
      await ref.read(taskNotifierProvider.notifier).createTask(task);
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create task. Try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.of(context).disableAnimations;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    Widget sheet = AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) => Transform.scale(
        scale: disableAnimations ? 1.0 : _scaleAnimation.value,
        child: child,
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.55,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppRadius.xl),
              ),
            ),
            child: Column(
              children: [
                // Drag handle
                Center(
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: AppSpacing.md),
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colorScheme.onSurface.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                  ),
                ),

                // Title
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                  child: Row(
                    children: [
                      Text(
                        'New Task',
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: colorScheme.onSurface,
                                ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: EdgeInsets.only(bottom: bottomInset),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xl),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Task title input
                          TextField(
                            controller: _titleController,
                            focusNode: _focusNode,
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: 'What needs to be done?',
                              hintStyle: TextStyle(
                                color: colorScheme.onSurface.withOpacity(0.4),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(AppRadius.md),
                                borderSide: BorderSide(
                                  color:
                                      colorScheme.onSurface.withOpacity(0.2),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(AppRadius.md),
                                borderSide: BorderSide(
                                  color:
                                      colorScheme.onSurface.withOpacity(0.2),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(AppRadius.md),
                                borderSide: BorderSide(
                                  color: isDark
                                      ? AppColors.darkPrimary
                                      : AppColors.lightAccent,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.lg,
                                vertical: AppSpacing.md,
                              ),
                            ),
                            onSubmitted: (_) => _submit(),
                          ),

                          const SizedBox(height: AppSpacing.xxl),

                          // Priority selector
                          Text(
                            'Priority',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color:
                                      colorScheme.onSurface.withOpacity(0.6),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Row(
                            children: TaskPriority.values
                                .map(
                                  (p) => Expanded(
                                    child: _PriorityChip(
                                      priority: p,
                                      isSelected: _selectedPriority == p,
                                      onTap: () =>
                                          setState(() => _selectedPriority = p),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),

                          const SizedBox(height: AppSpacing.xxl),

                          // Due date selector
                          Text(
                            'Due Date',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color:
                                      colorScheme.onSurface.withOpacity(0.6),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          InkWell(
                            onTap: _pickDueDate,
                            borderRadius:
                                BorderRadius.circular(AppRadius.md),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.lg,
                                vertical: AppSpacing.md,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      colorScheme.onSurface.withOpacity(0.2),
                                ),
                                borderRadius:
                                    BorderRadius.circular(AppRadius.md),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 18,
                                    color: _selectedDueDate != null
                                        ? (isDark
                                            ? AppColors.darkPrimary
                                            : AppColors.lightAccent)
                                        : colorScheme.onSurface
                                            .withOpacity(0.4),
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  Text(
                                    _selectedDueDate != null
                                        ? '${_selectedDueDate!.day}/${_selectedDueDate!.month}/${_selectedDueDate!.year}'
                                        : 'Select due date',
                                    style: TextStyle(
                                      color: _selectedDueDate != null
                                          ? colorScheme.onSurface
                                          : colorScheme.onSurface
                                              .withOpacity(0.4),
                                      fontSize: 15,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (_selectedDueDate != null)
                                    GestureDetector(
                                      onTap: () =>
                                          setState(() => _selectedDueDate = null),
                                      child: Icon(
                                        Icons.close_rounded,
                                        size: 16,
                                        color: colorScheme.onSurface
                                            .withOpacity(0.4),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: AppSpacing.x3l),

                          // Submit button
                          RyveButton(
                            label: 'Add Task',
                            isLoading: _isSubmitting,
                            onPressed: _isSubmitting ? null : _submit,
                          ),

                          const SizedBox(height: AppSpacing.xxl),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    if (disableAnimations) return sheet;

    return sheet
        .animate()
        .slideY(begin: 0.1, end: 0, duration: 300.ms, curve: Curves.easeOut)
        .fadeIn(duration: 200.ms);
  }
}

// ---------------------------------------------------------------------------
// Priority chip
// ---------------------------------------------------------------------------
class _PriorityChip extends StatelessWidget {
  const _PriorityChip({
    required this.priority,
    required this.isSelected,
    required this.onTap,
  });

  final TaskPriority priority;
  final bool isSelected;
  final VoidCallback onTap;

  static const _labels = {
    TaskPriority.low: 'Low',
    TaskPriority.medium: 'Med',
    TaskPriority.high: 'High',
    TaskPriority.urgent: 'Urgent',
  };

  static const _colors = {
    TaskPriority.low: AppColors.priorityLow,
    TaskPriority.medium: AppColors.priorityMed,
    TaskPriority.high: AppColors.priorityHigh,
    TaskPriority.urgent: AppColors.priorityUrgent,
  };

  @override
  Widget build(BuildContext context) {
    final color = _colors[priority]!;
    final label = _labels[priority]!;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(right: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.xs,
        ),
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
                          .withOpacity(0.6),
                  fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.w400,
                ),
          ),
        ),
      ),
    );
  }
}
