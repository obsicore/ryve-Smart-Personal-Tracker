import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/core/services/sync_service.dart';
import 'package:postgres/postgres.dart';

void main() {
  test('goals + mood_logs sync round trip against live Neon', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final sync = SyncService(db);

    const userId = 'sync-verify-user';
    const goalId = 'sync-verify-goal-1';
    const moodId = 'sync-verify-mood-1';
    final now = DateTime.now().toUtc();

    await db.into(db.goals).insert(GoalsCompanion.insert(
          id: goalId,
          userId: userId,
          title: 'Verify sync goal',
          lifeArea: 'health',
          metricType: 'count',
          targetValue: 10,
          createdAt: Value(now),
          updatedAt: Value(now),
        ));
    await db.into(db.moodLogs).insert(MoodLogsCompanion.insert(
          id: moodId,
          userId: userId,
          logDate: now,
          moodScore: 7,
          createdAt: Value(now),
          updatedAt: Value(now),
        ));
    // ignore: avoid_print
    print('LOCAL_ROWS_CREATED goal=$goalId mood=$moodId');

    await sync.flush();
    // ignore: avoid_print
    print('FLUSH_DONE');

    final conn = await sync.debugConnection();
    final pushedGoal =
        await conn.execute(Sql.named('SELECT title, updated_at FROM goals WHERE id = @id'),
            parameters: {'id': goalId});
    final pushedMood =
        await conn.execute(Sql.named('SELECT mood_score FROM mood_logs WHERE id = @id'),
            parameters: {'id': moodId});
    // ignore: avoid_print
    print('REMOTE_AFTER_PUSH goal_title=${pushedGoal.first[0]} mood_score=${pushedMood.first[0]}');
    expect(pushedGoal.length, 1);
    expect(pushedMood.length, 1);

    final newerTitle = 'Verify sync goal (updated remotely)';
    final newerTime = now.add(const Duration(minutes: 5));
    await conn.execute(
      Sql.named('UPDATE goals SET title = @t, updated_at = @u WHERE id = @id'),
      parameters: {'t': newerTitle, 'u': newerTime, 'id': goalId},
    );
    // ignore: avoid_print
    print('REMOTE_UPDATE_DONE');

    await sync.pull('goals');
    final localGoal = await (db.select(db.goals)..where((g) => g.id.equals(goalId))).getSingle();
    // ignore: avoid_print
    print('LOCAL_AFTER_PULL title="${localGoal.title}" updatedAt=${localGoal.updatedAt.toUtc()}');
    expect(localGoal.title, newerTitle);

    // cleanup: remove the verification rows from Neon so they don't linger
    await conn.execute(Sql.named('DELETE FROM goals WHERE id = @id'), parameters: {'id': goalId});
    await conn.execute(Sql.named('DELETE FROM mood_logs WHERE id = @id'), parameters: {'id': moodId});

    await sync.close();
    await db.close();
  }, timeout: const Timeout(Duration(seconds: 30)));
}
