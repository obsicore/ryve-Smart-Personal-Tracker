// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AlarmModel _$AlarmModelFromJson(Map<String, dynamic> json) => _AlarmModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      label: json['label'] as String? ?? 'Wake Up',
      time: json['time'] as String,
      daysOfWeek: json['daysOfWeek'] as String? ?? '1,2,3,4,5,6,7',
      isEnabled: json['isEnabled'] as bool? ?? true,
      missionType:
          $enumDecodeNullable(_$AlarmMissionTypeEnumMap, json['missionType']) ??
              AlarmMissionType.none,
      snoozeCount: (json['snoozeCount'] as num?)?.toInt() ?? 3,
      snoozeDurationMinutes:
          (json['snoozeDurationMinutes'] as num?)?.toInt() ?? 5,
      soundName: json['soundName'] as String? ?? 'default',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AlarmModelToJson(_AlarmModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'label': instance.label,
      'time': instance.time,
      'daysOfWeek': instance.daysOfWeek,
      'isEnabled': instance.isEnabled,
      'missionType': _$AlarmMissionTypeEnumMap[instance.missionType]!,
      'snoozeCount': instance.snoozeCount,
      'snoozeDurationMinutes': instance.snoozeDurationMinutes,
      'soundName': instance.soundName,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$AlarmMissionTypeEnumMap = {
  AlarmMissionType.none: 'none',
  AlarmMissionType.math: 'math',
  AlarmMissionType.shake: 'shake',
};
