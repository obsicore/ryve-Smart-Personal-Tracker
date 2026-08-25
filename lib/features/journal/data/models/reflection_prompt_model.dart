import 'package:freezed_annotation/freezed_annotation.dart';

part 'reflection_prompt_model.freezed.dart';
part 'reflection_prompt_model.g.dart';

@freezed
sealed class ReflectionPromptModel with _$ReflectionPromptModel {
  const factory ReflectionPromptModel({
    required String id,
    required String content,
    @Default('general') String category,
    @Default(true) bool isActive,
    required DateTime createdAt,
  }) = _ReflectionPromptModel;

  factory ReflectionPromptModel.fromJson(Map<String, dynamic> json) =>
      _$ReflectionPromptModelFromJson(json);
}

@freezed
sealed class ReflectionResponseModel with _$ReflectionResponseModel {
  const factory ReflectionResponseModel({
    required String id,
    required String userId,
    required String promptId,
    required String response,
    required DateTime createdAt,
  }) = _ReflectionResponseModel;

  factory ReflectionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ReflectionResponseModelFromJson(json);
}
