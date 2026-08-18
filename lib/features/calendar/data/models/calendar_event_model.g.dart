// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalendarEventModel _$CalendarEventModelFromJson(Map<String, dynamic> json) =>
    _CalendarEventModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      location: json['location'] as String?,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      isAllDay: json['isAllDay'] as bool? ?? false,
      color: json['color'] as String? ?? '#4CAF82',
      recurrenceRule: json['recurrenceRule'] as String?,
      linkedTaskId: json['linkedTaskId'] as String?,
      reminderMinutes: (json['reminderMinutes'] as num?)?.toInt(),
      syncStatus: (json['syncStatus'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CalendarEventModelToJson(_CalendarEventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'isAllDay': instance.isAllDay,
      'color': instance.color,
      'recurrenceRule': instance.recurrenceRule,
      'linkedTaskId': instance.linkedTaskId,
      'reminderMinutes': instance.reminderMinutes,
      'syncStatus': instance.syncStatus,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
