// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breathing_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BreathingSessionModel _$BreathingSessionModelFromJson(
        Map<String, dynamic> json) =>
    _BreathingSessionModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      technique: json['technique'] as String,
      durationMin: (json['durationMin'] as num).toInt(),
      cyclesCompleted: (json['cyclesCompleted'] as num?)?.toInt() ?? 0,
      moodBefore: (json['moodBefore'] as num?)?.toInt(),
      moodAfter: (json['moodAfter'] as num?)?.toInt(),
      completed: json['completed'] as bool? ?? false,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$BreathingSessionModelToJson(
        _BreathingSessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'technique': instance.technique,
      'durationMin': instance.durationMin,
      'cyclesCompleted': instance.cyclesCompleted,
      'moodBefore': instance.moodBefore,
      'moodAfter': instance.moodAfter,
      'completed': instance.completed,
      'startedAt': instance.startedAt.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };
