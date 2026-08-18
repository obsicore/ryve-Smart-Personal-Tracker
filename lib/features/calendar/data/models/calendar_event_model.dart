import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_event_model.freezed.dart';
part 'calendar_event_model.g.dart';

@freezed
sealed class CalendarEventModel with _$CalendarEventModel {
  const factory CalendarEventModel({
    required String id,
    required String userId,
    required String title,
    String? description,
    String? location,
    required DateTime startTime,
    required DateTime endTime,
    @Default(false) bool isAllDay,
    @Default('#4CAF82') String color,
    String? recurrenceRule,
    String? linkedTaskId,
    int? reminderMinutes,
    @Default(0) int syncStatus,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CalendarEventModel;

  factory CalendarEventModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventModelFromJson(json);
}
