// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SleepLogModel _$SleepLogModelFromJson(Map<String, dynamic> json) =>
    _SleepLogModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      bedtime: DateTime.parse(json['bedtime'] as String),
      wakeTime: DateTime.parse(json['wakeTime'] as String),
      qualityRating: (json['qualityRating'] as num?)?.toInt() ?? 3,
      sleepLatencyMinutes: (json['sleepLatencyMinutes'] as num?)?.toInt(),
      hadNightmares: json['hadNightmares'] as bool? ?? false,
      notes: json['notes'] as String?,
      syncStatus: (json['syncStatus'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SleepLogModelToJson(_SleepLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'bedtime': instance.bedtime.toIso8601String(),
      'wakeTime': instance.wakeTime.toIso8601String(),
      'qualityRating': instance.qualityRating,
      'sleepLatencyMinutes': instance.sleepLatencyMinutes,
      'hadNightmares': instance.hadNightmares,
      'notes': instance.notes,
      'syncStatus': instance.syncStatus,
      'createdAt': instance.createdAt.toIso8601String(),
    };
