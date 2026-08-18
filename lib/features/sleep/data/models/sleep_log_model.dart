import 'package:freezed_annotation/freezed_annotation.dart';

part 'sleep_log_model.freezed.dart';
part 'sleep_log_model.g.dart';

@freezed
sealed class SleepLogModel with _$SleepLogModel {
  const factory SleepLogModel({
    required String id,
    required String userId,
    required DateTime bedtime,
    required DateTime wakeTime,
    @Default(3) int qualityRating,
    int? sleepLatencyMinutes,
    @Default(false) bool hadNightmares,
    String? notes,
    @Default(0) int syncStatus,
    required DateTime createdAt,
  }) = _SleepLogModel;

  factory SleepLogModel.fromJson(Map<String, dynamic> json) =>
      _$SleepLogModelFromJson(json);
}

extension SleepLogModelX on SleepLogModel {
  Duration get totalDuration => wakeTime.difference(bedtime);
  double get hours => totalDuration.inMinutes / 60.0;
  String get formattedDuration {
    final h = totalDuration.inHours;
    final m = totalDuration.inMinutes % 60;
    return '${h}h ${m}m';
  }
}
