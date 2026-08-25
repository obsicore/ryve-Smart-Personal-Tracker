// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_plan_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AIPlanItemModel _$AIPlanItemModelFromJson(Map<String, dynamic> json) =>
    _AIPlanItemModel(
      id: json['id'] as String,
      planId: json['planId'] as String,
      slotStart: json['slotStart'] as String,
      slotEnd: json['slotEnd'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      itemType: $enumDecode(_$AIPlanItemTypeEnumMap, json['itemType']),
      linkedTaskId: json['linkedTaskId'] as String?,
      linkedHabitId: json['linkedHabitId'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      itemStatus: json['itemStatus'] as String? ?? 'pending',
    );

Map<String, dynamic> _$AIPlanItemModelToJson(_AIPlanItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'planId': instance.planId,
      'slotStart': instance.slotStart,
      'slotEnd': instance.slotEnd,
      'title': instance.title,
      'description': instance.description,
      'itemType': _$AIPlanItemTypeEnumMap[instance.itemType]!,
      'linkedTaskId': instance.linkedTaskId,
      'linkedHabitId': instance.linkedHabitId,
      'sortOrder': instance.sortOrder,
      'itemStatus': instance.itemStatus,
    };

const _$AIPlanItemTypeEnumMap = {
  AIPlanItemType.task: 'task',
  AIPlanItemType.habit: 'habit',
  AIPlanItemType.breakTime: 'breakTime',
  AIPlanItemType.focus: 'focus',
};
