import 'package:freezed_annotation/freezed_annotation.dart';

part 'smart_reminder_model.freezed.dart';
part 'smart_reminder_model.g.dart';

enum ReminderTriggerType { time, location, contextual }

extension ReminderTriggerTypeX on ReminderTriggerType {
  String get storageValue => name;

  static ReminderTriggerType fromStorage(String value) =>
      ReminderTriggerType.values.firstWhere(
        (t) => t.name == value,
        orElse: () => ReminderTriggerType.time,
      );
}

@freezed
sealed class SmartReminderModel with _$SmartReminderModel {
  const factory SmartReminderModel({
    required String id,
    required String userId,
    String? linkedType,
    String? linkedId,
    required String title,
    String? body,
    required ReminderTriggerType triggerType,
    required Map<String, dynamic> triggerConfig,
    @Default(true) bool isActive,
    DateTime? snoozedUntil,
    DateTime? lastTriggered,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SmartReminderModel;

  factory SmartReminderModel.fromJson(Map<String, dynamic> json) =>
      _$SmartReminderModelFromJson(json);
}

@freezed
sealed class LocationTriggerModel with _$LocationTriggerModel {
  const factory LocationTriggerModel({
    required String id,
    required String userId,
    required String label,
    required double latitude,
    required double longitude,
    @Default(150) double radiusMeters,
    required DateTime createdAt,
  }) = _LocationTriggerModel;

  factory LocationTriggerModel.fromJson(Map<String, dynamic> json) =>
      _$LocationTriggerModelFromJson(json);
}
