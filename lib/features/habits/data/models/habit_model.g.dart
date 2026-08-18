// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HabitModel _$HabitModelFromJson(Map<String, dynamic> json) => _HabitModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      iconEmoji: json['iconEmoji'] as String? ?? '⭐',
      category: json['category'] as String? ?? 'general',
      frequency: json['frequency'] as String? ?? 'daily',
      targetValue: (json['targetValue'] as num?)?.toInt() ?? 1,
      unit: json['unit'] as String?,
      chainNextId: json['chainNextId'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
      completedToday: json['completedToday'] as bool? ?? false,
      todayProgress: (json['todayProgress'] as num?)?.toDouble() ?? 0.0,
      completedDates: (json['completedDates'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$HabitModelToJson(_HabitModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'iconEmoji': instance.iconEmoji,
      'category': instance.category,
      'frequency': instance.frequency,
      'targetValue': instance.targetValue,
      'unit': instance.unit,
      'chainNextId': instance.chainNextId,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'completedToday': instance.completedToday,
      'todayProgress': instance.todayProgress,
      'completedDates':
          instance.completedDates.map((e) => e.toIso8601String()).toList(),
    };

_HabitLogModel _$HabitLogModelFromJson(Map<String, dynamic> json) =>
    _HabitLogModel(
      id: json['id'] as String,
      habitId: json['habitId'] as String,
      logDate: DateTime.parse(json['logDate'] as String),
      value: (json['value'] as num?)?.toDouble() ?? 1.0,
      moodAfter: (json['moodAfter'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$HabitLogModelToJson(_HabitLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'habitId': instance.habitId,
      'logDate': instance.logDate.toIso8601String(),
      'value': instance.value,
      'moodAfter': instance.moodAfter,
      'notes': instance.notes,
      'userId': instance.userId,
    };
