import 'package:freezed_annotation/freezed_annotation.dart';

part 'coaching_insight_model.freezed.dart';
part 'coaching_insight_model.g.dart';

@freezed
sealed class CoachingInsightModel with _$CoachingInsightModel {
  const factory CoachingInsightModel({
    required String id,
    required String userId,
    required String category,
    required String content,
    String? contextJson,
    @Default(false) bool isRead,
    @Default(false) bool isDismissed,
    required DateTime generatedAt,
    DateTime? readAt,
  }) = _CoachingInsightModel;

  factory CoachingInsightModel.fromJson(Map<String, dynamic> json) =>
      _$CoachingInsightModelFromJson(json);
}
