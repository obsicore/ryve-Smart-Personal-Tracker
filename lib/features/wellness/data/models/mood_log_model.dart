import 'package:freezed_annotation/freezed_annotation.dart';

part 'mood_log_model.freezed.dart';
part 'mood_log_model.g.dart';

@freezed
sealed class MoodLogModel with _$MoodLogModel {
  const factory MoodLogModel({
    required String id,
    required String userId,
    required DateTime logDate,
    required DateTime logTime,
    required int moodScore,
    int? energyScore,
    @Default([]) List<String> moodTags,
    @Default([]) List<String> factors,
    String? note,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int syncStatus,
  }) = _MoodLogModel;

  factory MoodLogModel.fromJson(Map<String, dynamic> json) =>
      _$MoodLogModelFromJson(json);
}
