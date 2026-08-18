import 'package:freezed_annotation/freezed_annotation.dart';

part 'focus_session_model.freezed.dart';
part 'focus_session_model.g.dart';

enum FocusSessionType { work, shortBreak, longBreak }

@freezed
sealed class FocusSessionModel with _$FocusSessionModel {
  const factory FocusSessionModel({
    required String id,
    required String userId,
    required int durationMinutes,
    @Default(FocusSessionType.work) FocusSessionType sessionType,
    @Default(true) bool wasCompleted,
    String? linkedTaskId,
    required DateTime startedAt,
    required DateTime endedAt,
    @Default(0) int syncStatus,
  }) = _FocusSessionModel;

  factory FocusSessionModel.fromJson(Map<String, dynamic> json) =>
      _$FocusSessionModelFromJson(json);
}

@freezed
sealed class FocusSettingsModel with _$FocusSettingsModel {
  const factory FocusSettingsModel({
    required String userId,
    @Default(25) int workMinutes,
    @Default(5) int shortBreakMinutes,
    @Default(15) int longBreakMinutes,
    @Default(4) int sessionsBeforeLongBreak,
    @Default(false) bool autoStartBreaks,
    @Default(true) bool soundEnabled,
  }) = _FocusSettingsModel;

  factory FocusSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$FocusSettingsModelFromJson(json);
}
