// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MoodLogModel _$MoodLogModelFromJson(Map<String, dynamic> json) =>
    _MoodLogModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      logDate: DateTime.parse(json['logDate'] as String),
      logTime: DateTime.parse(json['logTime'] as String),
      moodScore: (json['moodScore'] as num).toInt(),
      energyScore: (json['energyScore'] as num?)?.toInt(),
      moodTags: (json['moodTags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      factors: (json['factors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      note: json['note'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncStatus: (json['syncStatus'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MoodLogModelToJson(_MoodLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'logDate': instance.logDate.toIso8601String(),
      'logTime': instance.logTime.toIso8601String(),
      'moodScore': instance.moodScore,
      'energyScore': instance.energyScore,
      'moodTags': instance.moodTags,
      'factors': instance.factors,
      'note': instance.note,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncStatus': instance.syncStatus,
    };
