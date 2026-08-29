// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => _TaskModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      priority: $enumDecodeNullable(_$TaskPriorityEnumMap, json['priority']) ??
          TaskPriority.medium,
      isUrgent: json['isUrgent'] as bool? ?? false,
      isImportant: json['isImportant'] as bool? ?? true,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      reminderMinutesBefore: (json['reminderMinutesBefore'] as num?)?.toInt(),
      isCompleted: json['isCompleted'] as bool? ?? false,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      subtasks: (json['subtasks'] as List<dynamic>?)
              ?.map((e) => SubtaskModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      tagIds: (json['tagIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$TaskModelToJson(_TaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'priority': _$TaskPriorityEnumMap[instance.priority]!,
      'isUrgent': instance.isUrgent,
      'isImportant': instance.isImportant,
      'dueDate': instance.dueDate?.toIso8601String(),
      'reminderMinutesBefore': instance.reminderMinutesBefore,
      'isCompleted': instance.isCompleted,
      'completedAt': instance.completedAt?.toIso8601String(),
      'subtasks': instance.subtasks,
      'tagIds': instance.tagIds,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$TaskPriorityEnumMap = {
  TaskPriority.low: 'low',
  TaskPriority.medium: 'medium',
  TaskPriority.high: 'high',
  TaskPriority.urgent: 'urgent',
};

_SubtaskModel _$SubtaskModelFromJson(Map<String, dynamic> json) =>
    _SubtaskModel(
      id: json['id'] as String,
      taskId: json['taskId'] as String,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      order: (json['order'] as num).toInt(),
    );

Map<String, dynamic> _$SubtaskModelToJson(_SubtaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'taskId': instance.taskId,
      'title': instance.title,
      'isCompleted': instance.isCompleted,
      'order': instance.order,
    };

_TagModel _$TagModelFromJson(Map<String, dynamic> json) => _TagModel(
      id: json['id'] as String,
      name: json['name'] as String,
      color: json['color'] as String? ?? '#C9A84C',
    );

Map<String, dynamic> _$TagModelToJson(_TagModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
    };
