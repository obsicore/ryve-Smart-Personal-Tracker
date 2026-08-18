// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FocusSessionModel _$FocusSessionModelFromJson(Map<String, dynamic> json) =>
    _FocusSessionModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      sessionType:
          $enumDecodeNullable(_$FocusSessionTypeEnumMap, json['sessionType']) ??
              FocusSessionType.work,
      wasCompleted: json['wasCompleted'] as bool? ?? true,
      linkedTaskId: json['linkedTaskId'] as String?,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: DateTime.parse(json['endedAt'] as String),
      syncStatus: (json['syncStatus'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$FocusSessionModelToJson(_FocusSessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'durationMinutes': instance.durationMinutes,
      'sessionType': _$FocusSessionTypeEnumMap[instance.sessionType]!,
      'wasCompleted': instance.wasCompleted,
      'linkedTaskId': instance.linkedTaskId,
      'startedAt': instance.startedAt.toIso8601String(),
      'endedAt': instance.endedAt.toIso8601String(),
      'syncStatus': instance.syncStatus,
    };

const _$FocusSessionTypeEnumMap = {
  FocusSessionType.work: 'work',
  FocusSessionType.shortBreak: 'shortBreak',
  FocusSessionType.longBreak: 'longBreak',
};

_FocusSettingsModel _$FocusSettingsModelFromJson(Map<String, dynamic> json) =>
    _FocusSettingsModel(
      userId: json['userId'] as String,
      workMinutes: (json['workMinutes'] as num?)?.toInt() ?? 25,
      shortBreakMinutes: (json['shortBreakMinutes'] as num?)?.toInt() ?? 5,
      longBreakMinutes: (json['longBreakMinutes'] as num?)?.toInt() ?? 15,
      sessionsBeforeLongBreak:
          (json['sessionsBeforeLongBreak'] as num?)?.toInt() ?? 4,
      autoStartBreaks: json['autoStartBreaks'] as bool? ?? false,
      soundEnabled: json['soundEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$FocusSettingsModelToJson(_FocusSettingsModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'workMinutes': instance.workMinutes,
      'shortBreakMinutes': instance.shortBreakMinutes,
      'longBreakMinutes': instance.longBreakMinutes,
      'sessionsBeforeLongBreak': instance.sessionsBeforeLongBreak,
      'autoStartBreaks': instance.autoStartBreaks,
      'soundEnabled': instance.soundEnabled,
    };
