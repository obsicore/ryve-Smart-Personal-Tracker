import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/core/services/xp_service.dart';

void main() {
  late AppDatabase db;
  const userId = 'bugfix-user';

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() => db.close());

  test('focus_minutes challenge uses real session duration, not a flat 25', () async {
    await db.into(db.challenges).insert(ChallengesCompanion.insert(
          id: 'c1',
          title: '10 Hours Focus',
          description: '',
          challengeType: 'focus_minutes',
          targetValue: 600,
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 7)),
        ));
    await db.into(db.userChallenges).insert(UserChallengesCompanion.insert(
          id: 'uc1',
          userId: userId,
          challengeId: 'c1',
        ));

    final xp = XPService(db, userId);
    await xp.award(XPEvent.focusSessionComplete, entityId: 's1', metricValue: 50);

    final uc = await (db.select(db.userChallenges)..where((c) => c.id.equals('uc1'))).getSingle();
    expect(uc.currentValue, 50);
  });

  test('water_goal_hit only advances once per day the goal is actually crossed', () async {
    await db.into(db.challenges).insert(ChallengesCompanion.insert(
          id: 'c2',
          title: 'Hydration Week',
          description: '',
          challengeType: 'water_goal_hit',
          targetValue: 7,
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 7)),
        ));
    await db.into(db.userChallenges).insert(UserChallengesCompanion.insert(
          id: 'uc2',
          userId: userId,
          challengeId: 'c2',
        ));

    final xp = XPService(db, userId);

    // Two logs today that together cross 2500ml — should count as ONE day.
    final log1Id = 'w1';
    await db.into(db.waterLogs).insert(WaterLogsCompanion.insert(
          id: log1Id,
          userId: userId,
          logDate: DateTime.now(),
          amountMl: 1000,
        ));
    await xp.award(XPEvent.waterLog, entityId: log1Id);

    final log2Id = 'w2';
    await db.into(db.waterLogs).insert(WaterLogsCompanion.insert(
          id: log2Id,
          userId: userId,
          logDate: DateTime.now(),
          amountMl: 2000,
        ));
    await xp.award(XPEvent.waterLog, entityId: log2Id);

    final log3Id = 'w3';
    await db.into(db.waterLogs).insert(WaterLogsCompanion.insert(
          id: log3Id,
          userId: userId,
          logDate: DateTime.now(),
          amountMl: 100,
        ));
    await xp.award(XPEvent.waterLog, entityId: log3Id);

    final uc = await (db.select(db.userChallenges)..where((c) => c.id.equals('uc2'))).getSingle();
    expect(uc.currentValue, 1);
  });

  test('habit_streak challenge reads the live current streak, not the historic best', () async {
    await db.into(db.challenges).insert(ChallengesCompanion.insert(
          id: 'c3',
          title: '7-Day Habit Streak',
          description: '',
          challengeType: 'habit_streak',
          targetValue: 7,
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 7)),
        ));
    await db.into(db.userChallenges).insert(UserChallengesCompanion.insert(
          id: 'uc3',
          userId: userId,
          challengeId: 'c3',
        ));
    await db.into(db.habits).insert(HabitsCompanion.insert(
          id: 'h1',
          userId: userId,
          name: 'Read',
          category: const Value('learning'),
        ));
    // A 10-day streak that broke 30 days ago (best_streak=10) but is NOT live.
    for (var i = 40; i < 50; i++) {
      await db.into(db.habitLogs).insert(HabitLogsCompanion.insert(
            id: 'log$i',
            habitId: 'h1',
            userId: userId,
            logDate: DateTime.now().subtract(Duration(days: i)),
          ));
    }

    final xp = XPService(db, userId);
    await xp.award(XPEvent.habitLog, entityId: 'h1');

    final uc = await (db.select(db.userChallenges)..where((c) => c.id.equals('uc3'))).getSingle();
    // Live streak is 0 (no log today/yesterday chain), not the historic 10.
    expect(uc.currentValue, 0);
  });

  test('concurrent badge-unlock races cannot double-grant xp_reward', () async {
    await db.into(db.tasks).insert(TasksCompanion.insert(
          id: 't1',
          userId: userId,
          title: 'First task',
          isCompleted: const Value(true),
        ));

    final xpA = XPService(db, userId);
    final xpB = XPService(db, userId);
    await Future.wait([
      xpA.award(XPEvent.taskComplete, entityId: 't1'),
      xpB.award(XPEvent.taskComplete, entityId: 't1'),
    ]);

    final badgeRows = await (db.select(db.userBadges)
          ..where((b) => b.userId.equals(userId) & b.badgeId.equals('1')))
        .get();
    expect(badgeRows.length, 1);
  });

  test('levelFromXP is exact at perfect-square XP boundaries', () {
    // xpForLevel(n) = 50*(n-1)^2 — check several boundaries land exactly.
    for (var level = 1; level <= 50; level++) {
      final total = xpForLevel(level);
      expect(levelFromXP(total), level, reason: 'total=$total');
      if (total > 0) {
        expect(levelFromXP(total - 1), level - 1, reason: 'total=${total - 1}');
      }
    }
  });
}
