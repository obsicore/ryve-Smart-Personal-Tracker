import 'package:freezed_annotation/freezed_annotation.dart';

part 'milestone_model.freezed.dart';
part 'milestone_model.g.dart';

@freezed
sealed class MilestoneModel with _$MilestoneModel {
  const factory MilestoneModel({
    required String id,
    required String goalId,
    required String title,
    required double targetValue,
    @Default(0) int sortOrder,
    @Default(false) bool isComplete,
    DateTime? completedAt,
    required DateTime createdAt,
  }) = _MilestoneModel;

  factory MilestoneModel.fromJson(Map<String, dynamic> json) =>
      _$MilestoneModelFromJson(json);
}
