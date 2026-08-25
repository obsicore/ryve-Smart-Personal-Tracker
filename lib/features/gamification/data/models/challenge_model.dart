import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_model.freezed.dart';
part 'challenge_model.g.dart';

@freezed
sealed class ChallengeModel with _$ChallengeModel {
  const factory ChallengeModel({
    required String id,
    required String title,
    required String description,
    required String challengeType,
    required int targetValue,
    required DateTime startDate,
    required DateTime endDate,
    @Default(0) int xpReward,
    String? badgeId,
    @Default(true) bool isActive,
    required DateTime createdAt,
    String? userChallengeId,
    @Default('available') String status,
    @Default(0) int currentValue,
    DateTime? completedAt,
  }) = _ChallengeModel;

  factory ChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeModelFromJson(json);
}

extension ChallengeModelX on ChallengeModel {
  double get progress => targetValue <= 0 ? 0 : (currentValue / targetValue).clamp(0.0, 1.0);
  int get daysRemaining => endDate.difference(DateTime.now()).inDays.clamp(0, 9999);
  bool get isJoined => userChallengeId != null;
}
