import 'package:freezed_annotation/freezed_annotation.dart';

part 'gratitude_log_model.freezed.dart';
part 'gratitude_log_model.g.dart';

@freezed
sealed class GratitudeLogModel with _$GratitudeLogModel {
  const factory GratitudeLogModel({
    required String id,
    required String userId,
    required DateTime logDate,
    required String item1,
    String? item2,
    String? item3,
    required DateTime createdAt,
    @Default(0) int syncStatus,
  }) = _GratitudeLogModel;

  factory GratitudeLogModel.fromJson(Map<String, dynamic> json) =>
      _$GratitudeLogModelFromJson(json);
}
