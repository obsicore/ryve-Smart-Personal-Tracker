// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_reminder_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SmartReminderModel _$SmartReminderModelFromJson(Map<String, dynamic> json) =>
    _SmartReminderModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      linkedType: json['linkedType'] as String?,
      linkedId: json['linkedId'] as String?,
      title: json['title'] as String,
      body: json['body'] as String?,
      triggerType:
          $enumDecode(_$ReminderTriggerTypeEnumMap, json['triggerType']),
      triggerConfig: json['triggerConfig'] as Map<String, dynamic>,
      isActive: json['isActive'] as bool? ?? true,
      snoozedUntil: json['snoozedUntil'] == null
          ? null
          : DateTime.parse(json['snoozedUntil'] as String),
      lastTriggered: json['lastTriggered'] == null
          ? null
          : DateTime.parse(json['lastTriggered'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$SmartReminderModelToJson(_SmartReminderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'linkedType': instance.linkedType,
      'linkedId': instance.linkedId,
      'title': instance.title,
      'body': instance.body,
      'triggerType': _$ReminderTriggerTypeEnumMap[instance.triggerType]!,
      'triggerConfig': instance.triggerConfig,
      'isActive': instance.isActive,
      'snoozedUntil': instance.snoozedUntil?.toIso8601String(),
      'lastTriggered': instance.lastTriggered?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$ReminderTriggerTypeEnumMap = {
  ReminderTriggerType.time: 'time',
  ReminderTriggerType.location: 'location',
  ReminderTriggerType.contextual: 'contextual',
};

_LocationTriggerModel _$LocationTriggerModelFromJson(
        Map<String, dynamic> json) =>
    _LocationTriggerModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      label: json['label'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      radiusMeters: (json['radiusMeters'] as num?)?.toDouble() ?? 150,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$LocationTriggerModelToJson(
        _LocationTriggerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'label': instance.label,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'radiusMeters': instance.radiusMeters,
      'createdAt': instance.createdAt.toIso8601String(),
    };
