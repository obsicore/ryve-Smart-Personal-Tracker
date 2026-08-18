import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_model.freezed.dart';
part 'workout_model.g.dart';

@freezed
sealed class WorkoutSetModel with _$WorkoutSetModel {
  const factory WorkoutSetModel({
    required String id,
    required String workoutId,
    required String exerciseName,
    required int setNumber,
    int? reps,
    double? weightKg,
    int? durationSec,
    String? note,
  }) = _WorkoutSetModel;

  factory WorkoutSetModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSetModelFromJson(json);
}

@freezed
sealed class WorkoutLogModel with _$WorkoutLogModel {
  const factory WorkoutLogModel({
    required String id,
    required String userId,
    required String workoutType,
    String? name,
    required DateTime startedAt,
    DateTime? endedAt,
    int? durationMin,
    double? distanceM,
    int? calories,
    int? avgHeartRate,
    @Default('manual') String source,
    String? note,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int syncStatus,
    @Default([]) List<WorkoutSetModel> sets,
  }) = _WorkoutLogModel;

  factory WorkoutLogModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutLogModelFromJson(json);
}

const workoutTypes = [
  'running',
  'cycling',
  'strength',
  'yoga',
  'swimming',
  'other',
];
