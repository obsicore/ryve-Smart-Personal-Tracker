// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutSetModel _$WorkoutSetModelFromJson(Map<String, dynamic> json) =>
    _WorkoutSetModel(
      id: json['id'] as String,
      workoutId: json['workoutId'] as String,
      exerciseName: json['exerciseName'] as String,
      setNumber: (json['setNumber'] as num).toInt(),
      reps: (json['reps'] as num?)?.toInt(),
      weightKg: (json['weightKg'] as num?)?.toDouble(),
      durationSec: (json['durationSec'] as num?)?.toInt(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$WorkoutSetModelToJson(_WorkoutSetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workoutId': instance.workoutId,
      'exerciseName': instance.exerciseName,
      'setNumber': instance.setNumber,
      'reps': instance.reps,
      'weightKg': instance.weightKg,
      'durationSec': instance.durationSec,
      'note': instance.note,
    };

_WorkoutLogModel _$WorkoutLogModelFromJson(Map<String, dynamic> json) =>
    _WorkoutLogModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      workoutType: json['workoutType'] as String,
      name: json['name'] as String?,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
      durationMin: (json['durationMin'] as num?)?.toInt(),
      distanceM: (json['distanceM'] as num?)?.toDouble(),
      calories: (json['calories'] as num?)?.toInt(),
      avgHeartRate: (json['avgHeartRate'] as num?)?.toInt(),
      source: json['source'] as String? ?? 'manual',
      note: json['note'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncStatus: (json['syncStatus'] as num?)?.toInt() ?? 0,
      sets: (json['sets'] as List<dynamic>?)
              ?.map((e) => WorkoutSetModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$WorkoutLogModelToJson(_WorkoutLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'workoutType': instance.workoutType,
      'name': instance.name,
      'startedAt': instance.startedAt.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
      'durationMin': instance.durationMin,
      'distanceM': instance.distanceM,
      'calories': instance.calories,
      'avgHeartRate': instance.avgHeartRate,
      'source': instance.source,
      'note': instance.note,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncStatus': instance.syncStatus,
      'sets': instance.sets,
    };
