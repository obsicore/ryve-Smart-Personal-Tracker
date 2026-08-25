// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coaching_insight_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CoachingInsightModel _$CoachingInsightModelFromJson(
        Map<String, dynamic> json) =>
    _CoachingInsightModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      category: json['category'] as String,
      content: json['content'] as String,
      contextJson: json['contextJson'] as String?,
      isRead: json['isRead'] as bool? ?? false,
      isDismissed: json['isDismissed'] as bool? ?? false,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
    );

Map<String, dynamic> _$CoachingInsightModelToJson(
        _CoachingInsightModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'category': instance.category,
      'content': instance.content,
      'contextJson': instance.contextJson,
      'isRead': instance.isRead,
      'isDismissed': instance.isDismissed,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'readAt': instance.readAt?.toIso8601String(),
    };
