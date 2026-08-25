import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_challenge_model.freezed.dart';

@freezed
sealed class CommunityChallengeModel with _$CommunityChallengeModel {
  const factory CommunityChallengeModel({
    required String id,
    required String title,
    required String description,
    required String challengeType,
    required int targetValue,
    required DateTime startDate,
    required DateTime endDate,
    required bool isActive,
    required int participantCount,
    @Default(false) bool hasJoined,
    @Default(0) int myProgress,
  }) = _CommunityChallengeModel;
}

@freezed
sealed class LeaderboardEntryModel with _$LeaderboardEntryModel {
  const factory LeaderboardEntryModel({
    required String userId,
    required String displayName,
    required int currentValue,
    required int rank,
  }) = _LeaderboardEntryModel;
}
