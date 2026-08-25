import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/features/gamification/data/models/challenge_model.dart';

const _uuid = Uuid();

final _seedChallenges = <(String id, String title, String description, String type, int target, int xpReward)>[
  ('seed_habit_streak', '7-Day Habit Streak', 'Keep any habit streak alive for 7 days in a row.', 'habit_streak', 7, 50),
  ('seed_tasks_100', '100 Tasks Done', 'Complete 100 tasks total.', 'tasks_complete', 100, 150),
  ('seed_focus_10h', '10 Hours Focus', 'Log 10 hours of focused work.', 'focus_minutes', 600, 100),
  ('seed_hydration_week', 'Hydration Week', 'Hit your water goal 7 days running.', 'water_goal_hit', 7, 50),
];

abstract class GamificationRepository {
  Future<void> seedChallengesIfNeeded();
  Future<List<ChallengeModel>> getChallenges(String userId);
  Future<void> joinChallenge(String userId, String challengeId);
}

class GamificationRepositoryImpl implements GamificationRepository {
  GamificationRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<void> seedChallengesIfNeeded() async {
    final existing = await _db.select(_db.challenges).get();
    if (existing.isNotEmpty) return;
    final now = DateTime.now();
    final end = now.add(const Duration(days: 30));
    for (final c in _seedChallenges) {
      await _db.into(_db.challenges).insertOnConflictUpdate(
            ChallengesCompanion.insert(
              id: c.$1,
              title: c.$2,
              description: c.$3,
              challengeType: c.$4,
              targetValue: c.$5,
              startDate: now,
              endDate: end,
              xpReward: Value(c.$6),
            ),
          );
    }
  }

  @override
  Future<List<ChallengeModel>> getChallenges(String userId) async {
    await seedChallengesIfNeeded();
    final challenges = await (_db.select(_db.challenges)
          ..where((c) => c.isActive.equals(true)))
        .get();
    final userChallenges = await (_db.select(_db.userChallenges)
          ..where((u) => u.userId.equals(userId)))
        .get();
    final byId = {for (final uc in userChallenges) uc.challengeId: uc};

    return challenges.map((c) {
      final uc = byId[c.id];
      return ChallengeModel(
        id: c.id,
        title: c.title,
        description: c.description,
        challengeType: c.challengeType,
        targetValue: c.targetValue,
        startDate: c.startDate,
        endDate: c.endDate,
        xpReward: c.xpReward,
        badgeId: c.badgeId,
        isActive: c.isActive,
        createdAt: c.createdAt,
        userChallengeId: uc?.id,
        status: uc?.status ?? 'available',
        currentValue: uc?.currentValue ?? 0,
        completedAt: uc?.completedAt,
      );
    }).toList();
  }

  @override
  Future<void> joinChallenge(String userId, String challengeId) async {
    final existing = await (_db.select(_db.userChallenges)
          ..where((u) => u.userId.equals(userId) & u.challengeId.equals(challengeId)))
        .getSingleOrNull();
    if (existing != null) return;
    await _db.into(_db.userChallenges).insert(
          UserChallengesCompanion.insert(
            id: _uuid.v4(),
            userId: userId,
            challengeId: challengeId,
          ),
        );
  }
}
