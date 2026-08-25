// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChallengeModel _$ChallengeModelFromJson(Map<String, dynamic> json) =>
    _ChallengeModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      challengeType: json['challengeType'] as String,
      targetValue: (json['targetValue'] as num).toInt(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      xpReward: (json['xpReward'] as num?)?.toInt() ?? 0,
      badgeId: json['badgeId'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      userChallengeId: json['userChallengeId'] as String?,
      status: json['status'] as String? ?? 'available',
      currentValue: (json['currentValue'] as num?)?.toInt() ?? 0,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$ChallengeModelToJson(_ChallengeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'challengeType': instance.challengeType,
      'targetValue': instance.targetValue,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'xpReward': instance.xpReward,
      'badgeId': instance.badgeId,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'userChallengeId': instance.userChallengeId,
      'status': instance.status,
      'currentValue': instance.currentValue,
      'completedAt': instance.completedAt?.toIso8601String(),
    };
