// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoalModel _$GoalModelFromJson(Map<String, dynamic> json) => _GoalModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      lifeArea: json['lifeArea'] as String,
      metricType: json['metricType'] as String,
      targetValue: (json['targetValue'] as num).toDouble(),
      currentValue: (json['currentValue'] as num?)?.toDouble() ?? 0,
      unit: json['unit'] as String?,
      targetDate: json['targetDate'] == null
          ? null
          : DateTime.parse(json['targetDate'] as String),
      priority: (json['priority'] as num?)?.toInt() ?? 1,
      status: json['status'] as String? ?? 'active',
      icon: json['icon'] as String?,
      colorHex: json['colorHex'] as String? ?? '#C9A84C',
      visibility: json['visibility'] as String? ?? 'private',
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      syncStatus: (json['syncStatus'] as num?)?.toInt() ?? 0,
      milestones: (json['milestones'] as List<dynamic>?)
              ?.map((e) => MilestoneModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      linkedHabitIds: (json['linkedHabitIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      linkedTaskIds: (json['linkedTaskIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GoalModelToJson(_GoalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'lifeArea': instance.lifeArea,
      'metricType': instance.metricType,
      'targetValue': instance.targetValue,
      'currentValue': instance.currentValue,
      'unit': instance.unit,
      'targetDate': instance.targetDate?.toIso8601String(),
      'priority': instance.priority,
      'status': instance.status,
      'icon': instance.icon,
      'colorHex': instance.colorHex,
      'visibility': instance.visibility,
      'completedAt': instance.completedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'syncStatus': instance.syncStatus,
      'milestones': instance.milestones,
      'linkedHabitIds': instance.linkedHabitIds,
      'linkedTaskIds': instance.linkedTaskIds,
    };
