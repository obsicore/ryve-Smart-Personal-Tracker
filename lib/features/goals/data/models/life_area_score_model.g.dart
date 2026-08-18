// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'life_area_score_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LifeAreaScoreModel _$LifeAreaScoreModelFromJson(Map<String, dynamic> json) =>
    _LifeAreaScoreModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      scoredAt: DateTime.parse(json['scoredAt'] as String),
      health: (json['health'] as num).toInt(),
      work: (json['work'] as num).toInt(),
      finance: (json['finance'] as num).toInt(),
      relationships: (json['relationships'] as num).toInt(),
      personalGrowth: (json['personalGrowth'] as num).toInt(),
      learning: (json['learning'] as num).toInt(),
      recreation: (json['recreation'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$LifeAreaScoreModelToJson(_LifeAreaScoreModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'scoredAt': instance.scoredAt.toIso8601String(),
      'health': instance.health,
      'work': instance.work,
      'finance': instance.finance,
      'relationships': instance.relationships,
      'personalGrowth': instance.personalGrowth,
      'learning': instance.learning,
      'recreation': instance.recreation,
      'createdAt': instance.createdAt.toIso8601String(),
    };
