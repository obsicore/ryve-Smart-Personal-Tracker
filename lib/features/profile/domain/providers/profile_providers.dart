import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/profile/data/models/profile_model.dart';

part 'profile_providers.g.dart';

@riverpod
Future<ProfileModel> userProfile(Ref ref) async {
  final user = ref.watch(authStateProvider).value;
  if (user == null) {
    return const ProfileModel(
      userId: '',
      displayName: 'Guest',
      level: 1,
      xpTotal: 0,
      xpToNextLevel: 100,
    );
  }
  return ProfileModel(
    userId: user.uid,
    displayName: user.displayName ?? 'Ryver',
    email: user.email,
    avatarUrl: user.photoURL,
    level: 3,
    xpTotal: 275,
    xpToNextLevel: 300,
    currentStreak: 7,
    bestStreak: 14,
    tasksCompleted: 42,
    habitsLogged: 89,
    focusHours: 12,
  );
}

@riverpod
Future<List<BadgeModel>> userBadges(Ref ref) async {
  return const [
    BadgeModel(
      id: '1',
      name: 'First Step',
      description: 'Complete your first task',
      iconEmoji: '👟',
      category: 'tasks',
      rarity: 1,
      isEarned: true,
    ),
    BadgeModel(
      id: '2',
      name: 'Habit Starter',
      description: 'Log a habit for 3 days',
      iconEmoji: '🌱',
      category: 'habits',
      rarity: 1,
      isEarned: true,
    ),
    BadgeModel(
      id: '3',
      name: 'Week Warrior',
      description: '7-day streak',
      iconEmoji: '⚔️',
      category: 'streaks',
      rarity: 2,
      isEarned: true,
    ),
    BadgeModel(
      id: '4',
      name: 'Focus Master',
      description: 'Complete 10 focus sessions',
      iconEmoji: '🎯',
      category: 'focus',
      rarity: 2,
      isEarned: false,
    ),
    BadgeModel(
      id: '5',
      name: 'Century Club',
      description: '100-day streak',
      iconEmoji: '💯',
      category: 'streaks',
      rarity: 4,
      isEarned: false,
    ),
    BadgeModel(
      id: '6',
      name: 'Task Machine',
      description: 'Complete 100 tasks',
      iconEmoji: '⚡',
      category: 'tasks',
      rarity: 3,
      isEarned: false,
    ),
  ];
}

@riverpod
class XpNotifier extends _$XpNotifier {
  @override
  int build() => 0;

  Future<void> awardXp(
    int amount, {
    required String eventType,
    String? referenceId,
  }) async {
    // Phase 1: accumulate in memory; Phase 2 will write to xp_events table
    state = state + amount;
  }
}
