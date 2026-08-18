import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:hybrid_tracker/features/goals/data/models/milestone_model.dart';

part 'goal_model.freezed.dart';
part 'goal_model.g.dart';

@freezed
sealed class GoalModel with _$GoalModel {
  const factory GoalModel({
    required String id,
    required String userId,
    required String title,
    String? description,
    required String lifeArea,
    required String metricType,
    required double targetValue,
    @Default(0) double currentValue,
    String? unit,
    DateTime? targetDate,
    @Default(1) int priority,
    @Default('active') String status,
    String? icon,
    @Default('#C9A84C') String colorHex,
    @Default('private') String visibility,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
    @Default(0) int syncStatus,
    @Default([]) List<MilestoneModel> milestones,
    @Default([]) List<String> linkedHabitIds,
    @Default([]) List<String> linkedTaskIds,
  }) = _GoalModel;

  factory GoalModel.fromJson(Map<String, dynamic> json) =>
      _$GoalModelFromJson(json);
}

extension GoalModelX on GoalModel {
  double get progress =>
      targetValue <= 0 ? 0 : (currentValue / targetValue).clamp(0.0, 1.0);

  bool get isOverdue =>
      status == 'active' &&
      targetDate != null &&
      targetDate!.isBefore(DateTime.now());

  int? get daysLeft {
    if (targetDate == null) return null;
    return targetDate!.difference(DateTime.now()).inDays;
  }
}

const lifeAreas = [
  'health',
  'work',
  'finance',
  'relationships',
  'personal_growth',
  'learning',
  'recreation',
];

const metricTypes = ['numeric', 'boolean', 'habit_based'];
