// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reflection_prompt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReflectionPromptModel _$ReflectionPromptModelFromJson(
        Map<String, dynamic> json) =>
    _ReflectionPromptModel(
      id: json['id'] as String,
      content: json['content'] as String,
      category: json['category'] as String? ?? 'general',
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ReflectionPromptModelToJson(
        _ReflectionPromptModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'category': instance.category,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_ReflectionResponseModel _$ReflectionResponseModelFromJson(
        Map<String, dynamic> json) =>
    _ReflectionResponseModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      promptId: json['promptId'] as String,
      response: json['response'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ReflectionResponseModelToJson(
        _ReflectionResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'promptId': instance.promptId,
      'response': instance.response,
      'createdAt': instance.createdAt.toIso8601String(),
    };
