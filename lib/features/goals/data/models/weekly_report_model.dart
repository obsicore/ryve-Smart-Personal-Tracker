import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_report_model.freezed.dart';
part 'weekly_report_model.g.dart';

@freezed
sealed class WeeklyReportModel with _$WeeklyReportModel {
  const factory WeeklyReportModel({
    required String id,
    required String userId,
    required DateTime weekStart,
    required DateTime weekEnd,
    @Default(0) int habitsCompleted,
    @Default(0) int habitsTotal,
    @Default(0) int tasksCompleted,
    @Default(0) int focusMinutes,
    @Default(0) double avgMood,
    @Default(0) double avgSleepHours,
    @Default(0) int xpEarned,
    String? aiSummary,
    String? aiWins,
    String? aiSuggestions,
    required DateTime generatedAt,
    required DateTime createdAt,
  }) = _WeeklyReportModel;

  factory WeeklyReportModel.fromJson(Map<String, dynamic> json) =>
      _$WeeklyReportModelFromJson(json);
}
