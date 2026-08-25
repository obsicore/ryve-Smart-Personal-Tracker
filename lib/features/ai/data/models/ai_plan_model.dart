import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:hybrid_tracker/features/ai/data/models/ai_plan_item_model.dart';

part 'ai_plan_model.freezed.dart';
part 'ai_plan_model.g.dart';

@freezed
sealed class AIPlanModel with _$AIPlanModel {
  const factory AIPlanModel({
    required String id,
    required String userId,
    required DateTime planDate,
    @Default('draft') String status,
    String? promptContext,
    String? modelUsed,
    required DateTime generatedAt,
    DateTime? acceptedAt,
    required DateTime createdAt,
    @Default([]) List<AIPlanItemModel> items,
  }) = _AIPlanModel;

  factory AIPlanModel.fromJson(Map<String, dynamic> json) =>
      _$AIPlanModelFromJson(json);
}
