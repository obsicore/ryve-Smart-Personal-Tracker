import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

enum TaskPriority { low, medium, high, urgent }

@freezed
sealed class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required String userId,
    required String title,
    String? description,
    @Default(TaskPriority.medium) TaskPriority priority,
    @Default(false) bool isUrgent,
    @Default(true) bool isImportant,
    DateTime? dueDate,
    // Minutes before dueDate to fire a reminder; null = no reminder,
    // 0 = fire at the exact deadline. Only meaningful when dueDate is set.
    int? reminderMinutesBefore,
    @Default(false) bool isCompleted,
    DateTime? completedAt,
    @Default([]) List<SubtaskModel> subtasks,
    @Default([]) List<String> tagIds,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}

@freezed
sealed class SubtaskModel with _$SubtaskModel {
  const factory SubtaskModel({
    required String id,
    required String taskId,
    required String title,
    @Default(false) bool isCompleted,
    required int order,
  }) = _SubtaskModel;

  factory SubtaskModel.fromJson(Map<String, dynamic> json) =>
      _$SubtaskModelFromJson(json);
}

@freezed
sealed class TagModel with _$TagModel {
  const factory TagModel({
    required String id,
    required String name,
    @Default('#C9A84C') String color,
  }) = _TagModel;

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);
}
