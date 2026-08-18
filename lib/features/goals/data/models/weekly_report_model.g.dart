// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeeklyReportModel _$WeeklyReportModelFromJson(Map<String, dynamic> json) =>
    _WeeklyReportModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      weekStart: DateTime.parse(json['weekStart'] as String),
      weekEnd: DateTime.parse(json['weekEnd'] as String),
      habitsCompleted: (json['habitsCompleted'] as num?)?.toInt() ?? 0,
      habitsTotal: (json['habitsTotal'] as num?)?.toInt() ?? 0,
      tasksCompleted: (json['tasksCompleted'] as num?)?.toInt() ?? 0,
      focusMinutes: (json['focusMinutes'] as num?)?.toInt() ?? 0,
      avgMood: (json['avgMood'] as num?)?.toDouble() ?? 0,
      avgSleepHours: (json['avgSleepHours'] as num?)?.toDouble() ?? 0,
      xpEarned: (json['xpEarned'] as num?)?.toInt() ?? 0,
      aiSummary: json['aiSummary'] as String?,
      aiWins: json['aiWins'] as String?,
      aiSuggestions: json['aiSuggestions'] as String?,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$WeeklyReportModelToJson(_WeeklyReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'weekStart': instance.weekStart.toIso8601String(),
      'weekEnd': instance.weekEnd.toIso8601String(),
      'habitsCompleted': instance.habitsCompleted,
      'habitsTotal': instance.habitsTotal,
      'tasksCompleted': instance.tasksCompleted,
      'focusMinutes': instance.focusMinutes,
      'avgMood': instance.avgMood,
      'avgSleepHours': instance.avgSleepHours,
      'xpEarned': instance.xpEarned,
      'aiSummary': instance.aiSummary,
      'aiWins': instance.aiWins,
      'aiSuggestions': instance.aiSuggestions,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };
