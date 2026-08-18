import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/goals/data/models/goal_model.dart';
import 'package:hybrid_tracker/features/goals/domain/life_area_meta.dart';
import 'package:hybrid_tracker/features/goals/domain/providers/goals_providers.dart';
import 'package:hybrid_tracker/features/habits/domain/providers/habit_providers.dart';
import 'package:hybrid_tracker/features/tasks/domain/providers/task_providers.dart';

class CreateGoalScreen extends ConsumerStatefulWidget {
  const CreateGoalScreen({super.key});

  @override
  ConsumerState<CreateGoalScreen> createState() => _CreateGoalScreenState();
}

class _CreateGoalScreenState extends ConsumerState<CreateGoalScreen> {
  int _step = 0;
  String _lifeArea = lifeAreas.first;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _icon = '⭐';

  String _metricType = 'numeric';
  final _targetController = TextEditingController(text: '10');
  final _unitController = TextEditingController();
  DateTime? _targetDate;

  final Set<String> _linkedHabits = {};
  final Set<String> _linkedTasks = {};
  bool _saving = false;

  bool get _step1Valid => _titleController.text.trim().isNotEmpty;
  bool get _step2Valid => double.tryParse(_targetController.text) != null;

  Future<void> _save() async {
    setState(() => _saving = true);
    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    final now = DateTime.now();
    final goal = GoalModel(
      id: newGoalId,
      userId: userId,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
      lifeArea: _lifeArea,
      metricType: _metricType,
      targetValue: double.tryParse(_targetController.text) ?? 1,
      unit: _unitController.text.trim().isEmpty ? null : _unitController.text.trim(),
      targetDate: _targetDate,
      icon: _icon,
      colorHex: '#${metaFor(_lifeArea).color.value.toRadixString(16).substring(2)}',
      createdAt: now,
      updatedAt: now,
      linkedHabitIds: _linkedHabits.toList(),
      linkedTaskIds: _linkedTasks.toList(),
    );
    await ref.read(goalNotifierProvider.notifier).createGoal(goal);
    if (mounted) Navigator.of(context).pop();
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
        title: Text('New Goal', style: AppTypography.titleLarge(onBg)),
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.of(context).pop()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: List.generate(3, (i) {
                final active = i <= _step;
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(right: i < 2 ? AppSpacing.xs : 0),
                    decoration: BoxDecoration(
                      color: active ? primary : muted.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: switch (_step) {
                0 => _buildStep1(onBg, primary, muted),
                1 => _buildStep2(onBg, primary, muted),
                _ => _buildStep3(onBg, primary, muted),
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                if (_step > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => _step--),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
                        side: BorderSide(color: muted),
                      ),
                      child: Text('Back', style: AppTypography.labelLarge(muted)),
                    ),
                  ),
                if (_step > 0) const SizedBox(width: AppSpacing.md),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _saving
                        ? null
                        : (_step == 0 && !_step1Valid)
                            ? null
                            : (_step == 1 && !_step2Valid)
                                ? null
                                : () {
                                    if (_step < 2) {
                                      setState(() => _step++);
                                    } else {
                                      _save();
                                    }
                                  },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
                    ),
                    child: Text(
                      _step < 2 ? 'Next' : 'Create Goal',
                      style: AppTypography.labelLarge(isDark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1(Color onBg, Color primary, Color muted) {
    return Column(
      key: const ValueKey('step1'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Life area', style: AppTypography.titleMedium(onBg)),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: lifeAreas.map((area) {
            final meta = metaFor(area);
            final isSelected = _lifeArea == area;
            return GestureDetector(
              onTap: () => setState(() => _lifeArea = area),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: isSelected ? meta.color.withOpacity(0.15) : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  border: Border.all(color: isSelected ? meta.color : muted),
                ),
                child: Text('${meta.emoji} ${meta.label}', style: AppTypography.labelMedium(isSelected ? meta.color : muted)),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.xxl),
        Text('Title', style: AppTypography.titleMedium(onBg)),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: _titleController,
          style: AppTypography.bodyMedium(onBg),
          decoration: InputDecoration(hintText: 'e.g. Run a 10K', filled: true, fillColor: Theme.of(context).brightness == Brightness.dark ? AppColors.darkSurface : AppColors.lightSurface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: BorderSide.none)),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Icon', style: AppTypography.titleMedium(onBg)),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          children: ['⭐', '🏃', '📖', '💰', '🧘', '🎯', '💪', '🌱'].map((e) {
            final isSelected = _icon == e;
            return GestureDetector(
              onTap: () => setState(() => _icon = e),
              child: AnimatedScale(
                scale: isSelected ? 1.2 : 1.0,
                duration: const Duration(milliseconds: 150),
                child: Text(e, style: const TextStyle(fontSize: 26)),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Description (optional)', style: AppTypography.titleMedium(onBg)),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: _descriptionController,
          maxLines: 2,
          style: AppTypography.bodyMedium(onBg),
          decoration: InputDecoration(filled: true, fillColor: Theme.of(context).brightness == Brightness.dark ? AppColors.darkSurface : AppColors.lightSurface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: BorderSide.none)),
        ),
      ],
    ).animate().fadeIn(duration: 220.ms);
  }

  Widget _buildStep2(Color onBg, Color primary, Color muted) {
    final surface = Theme.of(context).brightness == Brightness.dark ? AppColors.darkSurface : AppColors.lightSurface;
    return Column(
      key: const ValueKey('step2'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Metric type', style: AppTypography.titleMedium(onBg)),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: metricTypes.map((m) {
            final isSelected = _metricType == m;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _metricType = m),
                child: Container(
                  margin: const EdgeInsets.only(right: AppSpacing.sm),
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? primary.withOpacity(0.15) : surface,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: isSelected ? primary : Colors.transparent),
                  ),
                  child: Text(m.replaceAll('_', ' '), style: AppTypography.labelMedium(isSelected ? primary : muted), textAlign: TextAlign.center),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.xxl),
        Text('Target value', style: AppTypography.titleMedium(onBg)),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _targetController,
                keyboardType: TextInputType.number,
                style: AppTypography.bodyMedium(onBg),
                decoration: InputDecoration(filled: true, fillColor: surface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: BorderSide.none)),
                onChanged: (_) => setState(() {}),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: TextField(
                controller: _unitController,
                style: AppTypography.bodyMedium(onBg),
                decoration: InputDecoration(hintText: 'unit (km, USD, ...)', filled: true, fillColor: surface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: BorderSide.none)),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xxl),
        Text('Target date (optional)', style: AppTypography.titleMedium(onBg)),
        const SizedBox(height: AppSpacing.sm),
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now().add(const Duration(days: 30)),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 3650)),
            );
            if (picked != null) setState(() => _targetDate = picked);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
            decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(AppRadius.md)),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 18, color: muted),
                const SizedBox(width: AppSpacing.md),
                Text(
                  _targetDate == null ? 'No target date' : '${_targetDate!.year}-${_targetDate!.month.toString().padLeft(2, '0')}-${_targetDate!.day.toString().padLeft(2, '0')}',
                  style: AppTypography.bodyMedium(onBg),
                ),
              ],
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 220.ms);
  }

  Widget _buildStep3(Color onBg, Color primary, Color muted) {
    final habitsAsync = ref.watch(allHabitsProvider);
    final tasksAsync = ref.watch(allTasksProvider);

    return Column(
      key: const ValueKey('step3'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Link habits', style: AppTypography.titleMedium(onBg)),
        const SizedBox(height: AppSpacing.sm),
        habitsAsync.when(
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
          data: (habits) {
            if (habits.isEmpty) return Text('No habits yet', style: AppTypography.bodySmall(muted));
            return Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: habits.map((h) {
                final isSelected = _linkedHabits.contains(h.id);
                return GestureDetector(
                  onTap: () => setState(() => isSelected ? _linkedHabits.remove(h.id) : _linkedHabits.add(h.id)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: isSelected ? primary.withOpacity(0.15) : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                      border: Border.all(color: isSelected ? primary : muted),
                    ),
                    child: Text('${h.iconEmoji} ${h.name}', style: AppTypography.labelMedium(isSelected ? primary : muted)),
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: AppSpacing.xxl),
        Text('Link tasks', style: AppTypography.titleMedium(onBg)),
        const SizedBox(height: AppSpacing.sm),
        tasksAsync.when(
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
          data: (tasks) {
            if (tasks.isEmpty) return Text('No tasks yet', style: AppTypography.bodySmall(muted));
            return Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: tasks.take(20).map((t) {
                final isSelected = _linkedTasks.contains(t.id);
                return GestureDetector(
                  onTap: () => setState(() => isSelected ? _linkedTasks.remove(t.id) : _linkedTasks.add(t.id)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: isSelected ? primary.withOpacity(0.15) : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                      border: Border.all(color: isSelected ? primary : muted),
                    ),
                    child: Text(t.title, style: AppTypography.labelMedium(isSelected ? primary : muted)),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    ).animate().fadeIn(duration: 220.ms);
  }
}
