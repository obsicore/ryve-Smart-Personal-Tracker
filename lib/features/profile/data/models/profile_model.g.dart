// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) =>
    _ProfileModel(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      level: (json['level'] as num?)?.toInt() ?? 1,
      xpTotal: (json['xpTotal'] as num?)?.toInt() ?? 0,
      xpToNextLevel: (json['xpToNextLevel'] as num?)?.toInt() ?? 0,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      bestStreak: (json['bestStreak'] as num?)?.toInt() ?? 0,
      tasksCompleted: (json['tasksCompleted'] as num?)?.toInt() ?? 0,
      habitsLogged: (json['habitsLogged'] as num?)?.toInt() ?? 0,
      focusHours: (json['focusHours'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ProfileModelToJson(_ProfileModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'displayName': instance.displayName,
      'email': instance.email,
      'avatarUrl': instance.avatarUrl,
      'level': instance.level,
      'xpTotal': instance.xpTotal,
      'xpToNextLevel': instance.xpToNextLevel,
      'currentStreak': instance.currentStreak,
      'bestStreak': instance.bestStreak,
      'tasksCompleted': instance.tasksCompleted,
      'habitsLogged': instance.habitsLogged,
      'focusHours': instance.focusHours,
    };

_BadgeModel _$BadgeModelFromJson(Map<String, dynamic> json) => _BadgeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      iconEmoji: json['iconEmoji'] as String,
      category: json['category'] as String,
      rarity: (json['rarity'] as num?)?.toInt() ?? 1,
      isEarned: json['isEarned'] as bool? ?? false,
      earnedAt: json['earnedAt'] == null
          ? null
          : DateTime.parse(json['earnedAt'] as String),
    );

Map<String, dynamic> _$BadgeModelToJson(_BadgeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'iconEmoji': instance.iconEmoji,
      'category': instance.category,
      'rarity': instance.rarity,
      'isEarned': instance.isEarned,
      'earnedAt': instance.earnedAt?.toIso8601String(),
    };
