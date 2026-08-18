import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit_model.freezed.dart';
part 'habit_model.g.dart';

@freezed
sealed class HabitModel with _$HabitModel {
  const factory HabitModel({
    required String id,
    required String userId,
    required String name,
    @Default('⭐') String iconEmoji,
    @Default('general') String category,
    @Default('daily') String frequency,
    @Default(1) int targetValue,
    String? unit,
    String? chainNextId,
    @Default(true) bool isActive,
    required DateTime createdAt,
    // computed fields for UI — not persisted directly
    @Default(0) int currentStreak,
    @Default(0) int longestStreak,
    @Default(false) bool completedToday,
    @Default(0.0) double todayProgress,
    @Default([]) List<DateTime> completedDates,
  }) = _HabitModel;

  factory HabitModel.fromJson(Map<String, dynamic> json) =>
      _$HabitModelFromJson(json);
}

@freezed
sealed class HabitLogModel with _$HabitLogModel {
  const factory HabitLogModel({
    required String id,
    required String habitId,
    required DateTime logDate,
    @Default(1.0) double value,
    int? moodAfter,
    String? notes,
    // userId required by the DB schema; optional on model for clean API
    String? userId,
  }) = _HabitLogModel;

  factory HabitLogModel.fromJson(Map<String, dynamic> json) =>
      _$HabitLogModelFromJson(json);
}
