import 'package:freezed_annotation/freezed_annotation.dart';

part 'step_log_model.freezed.dart';
part 'step_log_model.g.dart';

@freezed
sealed class StepLogModel with _$StepLogModel {
  const factory StepLogModel({
    required String id,
    required String userId,
    required DateTime logDate,
    required int stepCount,
    double? distanceM,
    int? calories,
    @Default('manual') String source,
    required DateTime updatedAt,
  }) = _StepLogModel;

  factory StepLogModel.fromJson(Map<String, dynamic> json) =>
      _$StepLogModelFromJson(json);
}
