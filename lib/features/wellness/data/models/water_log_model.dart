import 'package:freezed_annotation/freezed_annotation.dart';

part 'water_log_model.freezed.dart';
part 'water_log_model.g.dart';

@freezed
sealed class WaterLogModel with _$WaterLogModel {
  const factory WaterLogModel({
    required String id,
    required String userId,
    required DateTime logDate,
    required DateTime logTime,
    required int amountMl,
    String? containerType,
    required DateTime createdAt,
    @Default(0) int syncStatus,
  }) = _WaterLogModel;

  factory WaterLogModel.fromJson(Map<String, dynamic> json) =>
      _$WaterLogModelFromJson(json);
}
