// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StepLogModel _$StepLogModelFromJson(Map<String, dynamic> json) =>
    _StepLogModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      logDate: DateTime.parse(json['logDate'] as String),
      stepCount: (json['stepCount'] as num).toInt(),
      distanceM: (json['distanceM'] as num?)?.toDouble(),
      calories: (json['calories'] as num?)?.toInt(),
      source: json['source'] as String? ?? 'manual',
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$StepLogModelToJson(_StepLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'logDate': instance.logDate.toIso8601String(),
      'stepCount': instance.stepCount,
      'distanceM': instance.distanceM,
      'calories': instance.calories,
      'source': instance.source,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
