// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milestone_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MilestoneModel _$MilestoneModelFromJson(Map<String, dynamic> json) =>
    _MilestoneModel(
      id: json['id'] as String,
      goalId: json['goalId'] as String,
      title: json['title'] as String,
      targetValue: (json['targetValue'] as num).toDouble(),
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      isComplete: json['isComplete'] as bool? ?? false,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$MilestoneModelToJson(_MilestoneModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'goalId': instance.goalId,
      'title': instance.title,
      'targetValue': instance.targetValue,
      'sortOrder': instance.sortOrder,
      'isComplete': instance.isComplete,
      'completedAt': instance.completedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };
