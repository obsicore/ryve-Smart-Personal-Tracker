import 'package:freezed_annotation/freezed_annotation.dart';

part 'energy_log_model.freezed.dart';
part 'energy_log_model.g.dart';

@freezed
sealed class EnergyLogModel with _$EnergyLogModel {
  const factory EnergyLogModel({
    required String id,
    required String userId,
    required DateTime logDate,
    required DateTime logTime,
    required int energyLevel,
    String? note,
    required DateTime createdAt,
  }) = _EnergyLogModel;

  factory EnergyLogModel.fromJson(Map<String, dynamic> json) =>
      _$EnergyLogModelFromJson(json);
}
