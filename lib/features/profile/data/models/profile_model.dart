import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
sealed class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String userId,
    required String displayName,
    String? email,
    String? avatarUrl,
    @Default(1) int level,
    @Default(0) int xpTotal,
    @Default(0) int xpToNextLevel,
    @Default(0) int currentStreak,
    @Default(0) int bestStreak,
    @Default(0) int tasksCompleted,
    @Default(0) int habitsLogged,
    @Default(0) int focusHours,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}

@freezed
sealed class BadgeModel with _$BadgeModel {
  const factory BadgeModel({
    required String id,
    required String name,
    required String description,
    required String iconEmoji,
    required String category,
    @Default(1) int rarity,
    @Default(false) bool isEarned,
    DateTime? earnedAt,
  }) = _BadgeModel;

  factory BadgeModel.fromJson(Map<String, dynamic> json) =>
      _$BadgeModelFromJson(json);
}
