import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_plan_item_model.freezed.dart';
part 'ai_plan_item_model.g.dart';

enum AIPlanItemType { task, habit, breakTime, focus }

@freezed
sealed class AIPlanItemModel with _$AIPlanItemModel {
  const factory AIPlanItemModel({
    required String id,
    required String planId,
    required String slotStart,
    required String slotEnd,
    required String title,
    String? description,
    required AIPlanItemType itemType,
    String? linkedTaskId,
    String? linkedHabitId,
    @Default(0) int sortOrder,
    @Default('pending') String itemStatus,
  }) = _AIPlanItemModel;

  factory AIPlanItemModel.fromJson(Map<String, dynamic> json) =>
      _$AIPlanItemModelFromJson(json);
}

extension AIPlanItemTypeX on AIPlanItemType {
  String get storageValue => switch (this) {
        AIPlanItemType.task => 'task',
        AIPlanItemType.habit => 'habit',
        AIPlanItemType.breakTime => 'break',
        AIPlanItemType.focus => 'focus',
      };

  static AIPlanItemType fromStorage(String value) => switch (value) {
        'task' => AIPlanItemType.task,
        'habit' => AIPlanItemType.habit,
        'focus' => AIPlanItemType.focus,
        _ => AIPlanItemType.breakTime,
      };

  String get label => switch (this) {
        AIPlanItemType.task => 'Task',
        AIPlanItemType.habit => 'Habit',
        AIPlanItemType.breakTime => 'Break',
        AIPlanItemType.focus => 'Focus',
      };
}
