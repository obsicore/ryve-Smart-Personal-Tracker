import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/wellness/data/models/workout_model.dart';
import 'package:hybrid_tracker/features/wellness/domain/providers/wellness_providers.dart';

Future<void> showWorkoutLogSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
      child: const _WorkoutLogSheet(),
    ),
  );
}

class _WorkoutLogSheet extends ConsumerStatefulWidget {
  const _WorkoutLogSheet();

  @override
  ConsumerState<_WorkoutLogSheet> createState() => _WorkoutLogSheetState();
}

class _SetRow {
  final _exercise = TextEditingController();
  final _reps = TextEditingController();
  final _weight = TextEditingController();
}

class _WorkoutLogSheetState extends ConsumerState<_WorkoutLogSheet> {
  String _type = 'running';
  final _durationController = TextEditingController(text: '30');
  final _caloriesController = TextEditingController();
  final List<_SetRow> _sets = [_SetRow()];
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    return Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
        ),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(width: 40, height: 4, decoration: BoxDecoration(color: muted, borderRadius: BorderRadius.circular(2))),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Log Workout', style: AppTypography.titleLarge(onBg)),
              const SizedBox(height: AppSpacing.lg),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: workoutTypes.map((t) {
                  final isSelected = _type == t;
                  return GestureDetector(
                    onTap: () => setState(() => _type = t),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: isSelected ? primary.withOpacity(0.15) : surface,
                        borderRadius: BorderRadius.circular(AppRadius.full),
                        border: Border.all(color: isSelected ? primary : (isDark ? AppColors.darkSurfaceBright : Colors.transparent)),
                      ),
                      child: Text(t[0].toUpperCase() + t.substring(1), style: AppTypography.labelMedium(isSelected ? primary : muted)),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _durationController,
                      keyboardType: TextInputType.number,
                      style: AppTypography.bodyMedium(onSurface),
                      decoration: InputDecoration(labelText: 'Duration (min)', filled: true, fillColor: surface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: BorderSide.none)),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: TextField(
                      controller: _caloriesController,
                      keyboardType: TextInputType.number,
                      style: AppTypography.bodyMedium(onSurface),
                      decoration: InputDecoration(labelText: 'Calories (opt)', filled: true, fillColor: surface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: BorderSide.none)),
                    ),
                  ),
                ],
              ),
              if (_type == 'strength') ...[
                const SizedBox(height: AppSpacing.lg),
                Text('Sets', style: AppTypography.titleMedium(onBg)),
                const SizedBox(height: AppSpacing.sm),
                ..._sets.asMap().entries.map((entry) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              controller: entry.value._exercise,
                              style: AppTypography.bodySmall(onSurface),
                              decoration: InputDecoration(hintText: 'Exercise', filled: true, fillColor: surface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.sm), borderSide: BorderSide.none), isDense: true),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: TextField(
                              controller: entry.value._reps,
                              keyboardType: TextInputType.number,
                              style: AppTypography.bodySmall(onSurface),
                              decoration: InputDecoration(hintText: 'Reps', filled: true, fillColor: surface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.sm), borderSide: BorderSide.none), isDense: true),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: TextField(
                              controller: entry.value._weight,
                              keyboardType: TextInputType.number,
                              style: AppTypography.bodySmall(onSurface),
                              decoration: InputDecoration(hintText: 'kg', filled: true, fillColor: surface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.sm), borderSide: BorderSide.none), isDense: true),
                            ),
                          ),
                        ],
                      ),
                    )),
                TextButton.icon(
                  onPressed: () => setState(() => _sets.add(_SetRow())),
                  icon: Icon(Icons.add, size: 16, color: primary),
                  label: Text('Add set', style: AppTypography.labelMedium(primary)),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saving ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: isDark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary,
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
                  ),
                  child: Text('Save Workout', style: AppTypography.labelLarge(isDark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary)),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + AppSpacing.md),
            ],
          ),
        ),
    );
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    const uuid = Uuid();
    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    final now = DateTime.now();
    final workoutId = uuid.v4();
    final duration = int.tryParse(_durationController.text);

    final sets = _type == 'strength'
        ? _sets.asMap().entries.where((e) => e.value._exercise.text.trim().isNotEmpty).map((e) {
            return WorkoutSetModel(
              id: uuid.v4(),
              workoutId: workoutId,
              exerciseName: e.value._exercise.text.trim(),
              setNumber: e.key + 1,
              reps: int.tryParse(e.value._reps.text),
              weightKg: double.tryParse(e.value._weight.text),
            );
          }).toList()
        : <WorkoutSetModel>[];

    final workout = WorkoutLogModel(
      id: workoutId,
      userId: userId,
      workoutType: _type,
      startedAt: now,
      endedAt: duration != null ? now.add(Duration(minutes: duration)) : null,
      durationMin: duration,
      calories: int.tryParse(_caloriesController.text),
      createdAt: now,
      updatedAt: now,
      sets: sets,
    );

    await ref.read(wellnessNotifierProvider.notifier).logWorkout(workout);
    if (mounted) Navigator.of(context).pop();
  }
}
