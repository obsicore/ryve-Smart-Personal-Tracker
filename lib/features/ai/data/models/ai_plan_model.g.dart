// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AIPlanModel _$AIPlanModelFromJson(Map<String, dynamic> json) => _AIPlanModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      planDate: DateTime.parse(json['planDate'] as String),
      status: json['status'] as String? ?? 'draft',
      promptContext: json['promptContext'] as String?,
      modelUsed: json['modelUsed'] as String?,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      acceptedAt: json['acceptedAt'] == null
          ? null
          : DateTime.parse(json['acceptedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => AIPlanItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AIPlanModelToJson(_AIPlanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'planDate': instance.planDate.toIso8601String(),
      'status': instance.status,
      'promptContext': instance.promptContext,
      'modelUsed': instance.modelUsed,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'acceptedAt': instance.acceptedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'items': instance.items,
    };
