import 'package:freezed_annotation/freezed_annotation.dart';

part 'life_area_score_model.freezed.dart';
part 'life_area_score_model.g.dart';

@freezed
sealed class LifeAreaScoreModel with _$LifeAreaScoreModel {
  const factory LifeAreaScoreModel({
    required String id,
    required String userId,
    required DateTime scoredAt,
    required int health,
    required int work,
    required int finance,
    required int relationships,
    required int personalGrowth,
    required int learning,
    required int recreation,
    required DateTime createdAt,
  }) = _LifeAreaScoreModel;

  factory LifeAreaScoreModel.fromJson(Map<String, dynamic> json) =>
      _$LifeAreaScoreModelFromJson(json);
}

extension LifeAreaScoreModelX on LifeAreaScoreModel {
  Map<String, int> get asMap => {
        'health': health,
        'work': work,
        'finance': finance,
        'relationships': relationships,
        'personal_growth': personalGrowth,
        'learning': learning,
        'recreation': recreation,
      };
}
