import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:postgres/postgres.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/core/database/remote/neon_config.dart';
import 'package:hybrid_tracker/main.dart' show databaseProvider;

part 'sync_service.g.dart';

enum SyncPhase { idle, syncing, error }

class SyncStatus {
  final SyncPhase phase;
  final DateTime? lastSyncedAt;
  final String? error;

  const SyncStatus({required this.phase, this.lastSyncedAt, this.error});
}

// Synced domains: tasks, habits, calendar_events, focus_sessions, goals,
// journal_entries, gratitude_logs, sleep_logs, mood_logs, water_logs,
// workout_logs (Drift `syncStatus` + a timestamp column map to identical
// snake_case Postgres columns — both generated from the same source, see
// docs/neon_schema.sql). Local `id` doubles as the remote primary key since
// ids are client-generated UUIDs, so no server_id mapping is needed.
// sleep_logs, gratitude_logs and water_logs have no `updated_at` column —
// they're append-only logs never edited after creation, so `created_at`
// (or, on conflict, just leaving the remote row alone) stands in for the
// last-write-wins comparison.
class SyncService {
  final AppDatabase _db;
  Connection? _conn;

  SyncService(this._db);

  /// Exposes the live Neon connection for test/verification scripts that
  /// need to assert against remote state directly (see bin/verify_sync.dart).
  @visibleForTesting
  Future<Connection> debugConnection() => _connection();

  Future<Connection> _connection() async {
    if (_conn != null && _conn!.isOpen) return _conn!;
    _conn = await Connection.open(
      Endpoint(
        host: neonHost,
        database: neonDatabase,
        username: neonUser,
        password: neonPassword,
      ),
      settings: const ConnectionSettings(sslMode: SslMode.require),
    );
    return _conn!;
  }

  Future<void> close() async {
    await _conn?.close();
    _conn = null;
  }

  Future<DateTime?> lastSyncedAt(String entityTable) async {
    final row = await (_db.select(_db.syncMeta)
          ..where((t) => t.entityTable.equals(entityTable)))
        .getSingleOrNull();
    return row?.lastSyncedAt;
  }

  Future<void> _markSynced(String entityTable) async {
    await _db.into(_db.syncMeta).insertOnConflictUpdate(
          SyncMetaCompanion.insert(
            entityTable: entityTable,
            lastSyncedAt: Value(DateTime.now()),
          ),
        );
  }

  /// Pushes every locally pending (`sync_status = 0`) task/habit row to
  /// Neon, last-write-wins on `updated_at` conflict, then marks them synced.
  Future<void> flush() async {
    final conn = await _connection();
    await _flushTasks(conn);
    await _flushHabits(conn);
    await _flushCalendarEvents(conn);
    await _flushFocusSessions(conn);
    await _flushGoals(conn);
    await _flushJournalEntries(conn);
    await _flushGratitudeLogs(conn);
    await _flushSleepLogs(conn);
    await _flushMoodLogs(conn);
    await _flushWaterLogs(conn);
    await _flushWorkoutLogs(conn);
  }

  Future<void> _flushTasks(Connection conn) async {
    final pending =
        await (_db.select(_db.tasks)..where((t) => t.syncStatus.equals(0)))
            .get();
    for (final t in pending) {
      await conn.execute(
        Sql.named('''
          INSERT INTO tasks (id, user_id, title, description, priority, is_urgent,
            is_important, due_date, due_time, is_completed, completed_at,
            recurring_config_id, estimated_minutes, created_at, updated_at, sync_status)
          VALUES (@id, @userId, @title, @description, @priority, @isUrgent,
            @isImportant, @dueDate, @dueTime, @isCompleted, @completedAt,
            @recurringConfigId, @estimatedMinutes, @createdAt, @updatedAt, 1)
          ON CONFLICT (id) DO UPDATE SET
            title = EXCLUDED.title, description = EXCLUDED.description,
            priority = EXCLUDED.priority, is_urgent = EXCLUDED.is_urgent,
            is_important = EXCLUDED.is_important, due_date = EXCLUDED.due_date,
            due_time = EXCLUDED.due_time, is_completed = EXCLUDED.is_completed,
            completed_at = EXCLUDED.completed_at, estimated_minutes = EXCLUDED.estimated_minutes,
            updated_at = EXCLUDED.updated_at, sync_status = 1
          WHERE tasks.updated_at IS NULL OR EXCLUDED.updated_at >= tasks.updated_at
        '''),
        parameters: {
          'id': t.id,
          'userId': t.userId,
          'title': t.title,
          'description': t.description,
          'priority': t.priority,
          'isUrgent': t.isUrgent,
          'isImportant': t.isImportant,
          'dueDate': t.dueDate,
          'dueTime': t.dueTime,
          'isCompleted': t.isCompleted,
          'completedAt': t.completedAt,
          'recurringConfigId': t.recurringConfigId,
          'estimatedMinutes': t.estimatedMinutes,
          'createdAt': t.createdAt,
          'updatedAt': t.updatedAt,
        },
      );
      await (_db.update(_db.tasks)..where((row) => row.id.equals(t.id)))
          .write(const TasksCompanion(syncStatus: Value(1)));
    }
    await _markSynced('tasks');
  }

  Future<void> _flushHabits(Connection conn) async {
    final pending =
        await (_db.select(_db.habits)..where((t) => t.syncStatus.equals(0)))
            .get();
    for (final h in pending) {
      await conn.execute(
        Sql.named('''
          INSERT INTO habits (id, user_id, name, icon_emoji, category, frequency,
            target_value, unit, chain_next_id, is_active, created_at, updated_at, sync_status)
          VALUES (@id, @userId, @name, @iconEmoji, @category, @frequency,
            @targetValue, @unit, @chainNextId, @isActive, @createdAt, @updatedAt, 1)
          ON CONFLICT (id) DO UPDATE SET
            name = EXCLUDED.name, icon_emoji = EXCLUDED.icon_emoji, category = EXCLUDED.category,
            frequency = EXCLUDED.frequency, target_value = EXCLUDED.target_value,
            unit = EXCLUDED.unit, chain_next_id = EXCLUDED.chain_next_id,
            is_active = EXCLUDED.is_active, updated_at = EXCLUDED.updated_at, sync_status = 1
          WHERE habits.updated_at IS NULL OR EXCLUDED.updated_at >= habits.updated_at
        '''),
        parameters: {
          'id': h.id,
          'userId': h.userId,
          'name': h.name,
          'iconEmoji': h.iconEmoji,
          'category': h.category,
          'frequency': h.frequency,
          'targetValue': h.targetValue,
          'unit': h.unit,
          'chainNextId': h.chainNextId,
          'isActive': h.isActive,
          'createdAt': h.createdAt,
          'updatedAt': h.updatedAt,
        },
      );
      await (_db.update(_db.habits)..where((row) => row.id.equals(h.id)))
          .write(const HabitsCompanion(syncStatus: Value(1)));
    }
    await _markSynced('habits');
  }

  Future<void> _flushCalendarEvents(Connection conn) async {
    final pending = await (_db.select(_db.calendarEvents)
          ..where((t) => t.syncStatus.equals(0)))
        .get();
    for (final e in pending) {
      await conn.execute(
        Sql.named('''
          INSERT INTO calendar_events (id, user_id, title, description, location,
            start_time, end_time, is_all_day, color, recurrence_rule, linked_task_id,
            reminder_minutes, created_at, updated_at, sync_status)
          VALUES (@id, @userId, @title, @description, @location, @startTime, @endTime,
            @isAllDay, @color, @recurrenceRule, @linkedTaskId, @reminderMinutes,
            @createdAt, @updatedAt, 1)
          ON CONFLICT (id) DO UPDATE SET
            title = EXCLUDED.title, description = EXCLUDED.description, location = EXCLUDED.location,
            start_time = EXCLUDED.start_time, end_time = EXCLUDED.end_time, is_all_day = EXCLUDED.is_all_day,
            color = EXCLUDED.color, recurrence_rule = EXCLUDED.recurrence_rule,
            linked_task_id = EXCLUDED.linked_task_id, reminder_minutes = EXCLUDED.reminder_minutes,
            updated_at = EXCLUDED.updated_at, sync_status = 1
          WHERE calendar_events.updated_at IS NULL OR EXCLUDED.updated_at >= calendar_events.updated_at
        '''),
        parameters: {
          'id': e.id,
          'userId': e.userId,
          'title': e.title,
          'description': e.description,
          'location': e.location,
          'startTime': e.startTime,
          'endTime': e.endTime,
          'isAllDay': e.isAllDay,
          'color': e.color,
          'recurrenceRule': e.recurrenceRule,
          'linkedTaskId': e.linkedTaskId,
          'reminderMinutes': e.reminderMinutes,
          'createdAt': e.createdAt,
          'updatedAt': e.updatedAt,
        },
      );
      await (_db.update(_db.calendarEvents)..where((row) => row.id.equals(e.id)))
          .write(const CalendarEventsCompanion(syncStatus: Value(1)));
    }
    await _markSynced('calendar_events');
  }

  Future<void> _flushFocusSessions(Connection conn) async {
    final pending = await (_db.select(_db.focusSessions)
          ..where((t) => t.syncStatus.equals(0)))
        .get();
    for (final s in pending) {
      await conn.execute(
        Sql.named('''
          INSERT INTO focus_sessions (id, user_id, duration_minutes, session_type,
            was_completed, linked_task_id, started_at, ended_at, sync_status)
          VALUES (@id, @userId, @durationMinutes, @sessionType, @wasCompleted,
            @linkedTaskId, @startedAt, @endedAt, 1)
          ON CONFLICT (id) DO UPDATE SET
            duration_minutes = EXCLUDED.duration_minutes, session_type = EXCLUDED.session_type,
            was_completed = EXCLUDED.was_completed, linked_task_id = EXCLUDED.linked_task_id,
            ended_at = EXCLUDED.ended_at, sync_status = 1
        '''),
        parameters: {
          'id': s.id,
          'userId': s.userId,
          'durationMinutes': s.durationMinutes,
          'sessionType': s.sessionType,
          'wasCompleted': s.wasCompleted,
          'linkedTaskId': s.linkedTaskId,
          'startedAt': s.startedAt,
          'endedAt': s.endedAt,
        },
      );
      await (_db.update(_db.focusSessions)..where((row) => row.id.equals(s.id)))
          .write(const FocusSessionsCompanion(syncStatus: Value(1)));
    }
    await _markSynced('focus_sessions');
  }

  Future<void> _flushGoals(Connection conn) async {
    final pending =
        await (_db.select(_db.goals)..where((t) => t.syncStatus.equals(0))).get();
    for (final g in pending) {
      await conn.execute(
        Sql.named('''
          INSERT INTO goals (id, user_id, title, description, life_area, metric_type,
            target_value, current_value, unit, target_date, priority, status, icon,
            color_hex, visibility, completed_at, created_at, updated_at, deleted_at, sync_status)
          VALUES (@id, @userId, @title, @description, @lifeArea, @metricType, @targetValue,
            @currentValue, @unit, @targetDate, @priority, @status, @icon, @colorHex,
            @visibility, @completedAt, @createdAt, @updatedAt, @deletedAt, 1)
          ON CONFLICT (id) DO UPDATE SET
            title = EXCLUDED.title, description = EXCLUDED.description, life_area = EXCLUDED.life_area,
            metric_type = EXCLUDED.metric_type, target_value = EXCLUDED.target_value,
            current_value = EXCLUDED.current_value, unit = EXCLUDED.unit, target_date = EXCLUDED.target_date,
            priority = EXCLUDED.priority, status = EXCLUDED.status, icon = EXCLUDED.icon,
            color_hex = EXCLUDED.color_hex, visibility = EXCLUDED.visibility,
            completed_at = EXCLUDED.completed_at, updated_at = EXCLUDED.updated_at,
            deleted_at = EXCLUDED.deleted_at, sync_status = 1
          WHERE goals.updated_at IS NULL OR EXCLUDED.updated_at >= goals.updated_at
        '''),
        parameters: {
          'id': g.id,
          'userId': g.userId,
          'title': g.title,
          'description': g.description,
          'lifeArea': g.lifeArea,
          'metricType': g.metricType,
          'targetValue': g.targetValue,
          'currentValue': g.currentValue,
          'unit': g.unit,
          'targetDate': g.targetDate,
          'priority': g.priority,
          'status': g.status,
          'icon': g.icon,
          'colorHex': g.colorHex,
          'visibility': g.visibility,
          'completedAt': g.completedAt,
          'createdAt': g.createdAt,
          'updatedAt': g.updatedAt,
          'deletedAt': g.deletedAt,
        },
      );
      await (_db.update(_db.goals)..where((row) => row.id.equals(g.id)))
          .write(const GoalsCompanion(syncStatus: Value(1)));
    }
    await _markSynced('goals');
  }

  Future<void> _flushJournalEntries(Connection conn) async {
    final pending = await (_db.select(_db.journalEntries)
          ..where((t) => t.syncStatus.equals(0)))
        .get();
    for (final j in pending) {
      await conn.execute(
        Sql.named('''
          INSERT INTO journal_entries (id, user_id, entry_date, title, content, mood_tag,
            is_private, word_count, created_at, updated_at, sync_status)
          VALUES (@id, @userId, @entryDate, @title, @content, @moodTag, @isPrivate,
            @wordCount, @createdAt, @updatedAt, 1)
          ON CONFLICT (id) DO UPDATE SET
            title = EXCLUDED.title, content = EXCLUDED.content, mood_tag = EXCLUDED.mood_tag,
            is_private = EXCLUDED.is_private, word_count = EXCLUDED.word_count,
            updated_at = EXCLUDED.updated_at, sync_status = 1
          WHERE journal_entries.updated_at IS NULL OR EXCLUDED.updated_at >= journal_entries.updated_at
        '''),
        parameters: {
          'id': j.id,
          'userId': j.userId,
          'entryDate': j.entryDate,
          'title': j.title,
          'content': j.content,
          'moodTag': j.moodTag,
          'isPrivate': j.isPrivate,
          'wordCount': j.wordCount,
          'createdAt': j.createdAt,
          'updatedAt': j.updatedAt,
        },
      );
      await (_db.update(_db.journalEntries)..where((row) => row.id.equals(j.id)))
          .write(const JournalEntriesCompanion(syncStatus: Value(1)));
    }
    await _markSynced('journal_entries');
  }

  Future<void> _flushGratitudeLogs(Connection conn) async {
    final pending = await (_db.select(_db.gratitudeLogs)
          ..where((t) => t.syncStatus.equals(0)))
        .get();
    for (final g in pending) {
      await conn.execute(
        Sql.named('''
          INSERT INTO gratitude_logs (id, user_id, log_date, item1, item2, item3, created_at, sync_status)
          VALUES (@id, @userId, @logDate, @item1, @item2, @item3, @createdAt, 1)
          ON CONFLICT (id) DO NOTHING
        '''),
        parameters: {
          'id': g.id,
          'userId': g.userId,
          'logDate': g.logDate,
          'item1': g.item1,
          'item2': g.item2,
          'item3': g.item3,
          'createdAt': g.createdAt,
        },
      );
      await (_db.update(_db.gratitudeLogs)..where((row) => row.id.equals(g.id)))
          .write(const GratitudeLogsCompanion(syncStatus: Value(1)));
    }
    await _markSynced('gratitude_logs');
  }

  Future<void> _flushSleepLogs(Connection conn) async {
    final pending = await (_db.select(_db.sleepLogs)
          ..where((t) => t.syncStatus.equals(0)))
        .get();
    for (final s in pending) {
      await conn.execute(
        Sql.named('''
          INSERT INTO sleep_logs (id, user_id, bedtime, wake_time, quality_rating,
            sleep_latency_minutes, had_nightmares, notes, sync_status, created_at)
          VALUES (@id, @userId, @bedtime, @wakeTime, @qualityRating, @sleepLatencyMinutes,
            @hadNightmares, @notes, 1, @createdAt)
          ON CONFLICT (id) DO NOTHING
        '''),
        parameters: {
          'id': s.id,
          'userId': s.userId,
          'bedtime': s.bedtime,
          'wakeTime': s.wakeTime,
          'qualityRating': s.qualityRating,
          'sleepLatencyMinutes': s.sleepLatencyMinutes,
          'hadNightmares': s.hadNightmares,
          'notes': s.notes,
          'createdAt': s.createdAt,
        },
      );
      await (_db.update(_db.sleepLogs)..where((row) => row.id.equals(s.id)))
          .write(const SleepLogsCompanion(syncStatus: Value(1)));
    }
    await _markSynced('sleep_logs');
  }

  Future<void> _flushMoodLogs(Connection conn) async {
    final pending = await (_db.select(_db.moodLogs)
          ..where((t) => t.syncStatus.equals(0)))
        .get();
    for (final m in pending) {
      await conn.execute(
        Sql.named('''
          INSERT INTO mood_logs (id, user_id, log_date, log_time, mood_score, energy_score,
            mood_tags, factors, note, created_at, updated_at, sync_status)
          VALUES (@id, @userId, @logDate, @logTime, @moodScore, @energyScore, @moodTags,
            @factors, @note, @createdAt, @updatedAt, 1)
          ON CONFLICT (id) DO UPDATE SET
            mood_score = EXCLUDED.mood_score, energy_score = EXCLUDED.energy_score,
            mood_tags = EXCLUDED.mood_tags, factors = EXCLUDED.factors, note = EXCLUDED.note,
            updated_at = EXCLUDED.updated_at, sync_status = 1
          WHERE mood_logs.updated_at IS NULL OR EXCLUDED.updated_at >= mood_logs.updated_at
        '''),
        parameters: {
          'id': m.id,
          'userId': m.userId,
          'logDate': m.logDate,
          'logTime': m.logTime,
          'moodScore': m.moodScore,
          'energyScore': m.energyScore,
          'moodTags': m.moodTags,
          'factors': m.factors,
          'note': m.note,
          'createdAt': m.createdAt,
          'updatedAt': m.updatedAt,
        },
      );
      await (_db.update(_db.moodLogs)..where((row) => row.id.equals(m.id)))
          .write(const MoodLogsCompanion(syncStatus: Value(1)));
    }
    await _markSynced('mood_logs');
  }

  Future<void> _flushWaterLogs(Connection conn) async {
    final pending = await (_db.select(_db.waterLogs)
          ..where((t) => t.syncStatus.equals(0)))
        .get();
    for (final w in pending) {
      await conn.execute(
        Sql.named('''
          INSERT INTO water_logs (id, user_id, log_date, log_time, amount_ml, container_type,
            created_at, sync_status)
          VALUES (@id, @userId, @logDate, @logTime, @amountMl, @containerType, @createdAt, 1)
          ON CONFLICT (id) DO NOTHING
        '''),
        parameters: {
          'id': w.id,
          'userId': w.userId,
          'logDate': w.logDate,
          'logTime': w.logTime,
          'amountMl': w.amountMl,
          'containerType': w.containerType,
          'createdAt': w.createdAt,
        },
      );
      await (_db.update(_db.waterLogs)..where((row) => row.id.equals(w.id)))
          .write(const WaterLogsCompanion(syncStatus: Value(1)));
    }
    await _markSynced('water_logs');
  }

  Future<void> _flushWorkoutLogs(Connection conn) async {
    final pending = await (_db.select(_db.workoutLogs)
          ..where((t) => t.syncStatus.equals(0)))
        .get();
    for (final w in pending) {
      await conn.execute(
        Sql.named('''
          INSERT INTO workout_logs (id, user_id, workout_type, name, started_at, ended_at,
            duration_min, distance_m, calories, avg_heart_rate, source, note, created_at,
            updated_at, sync_status)
          VALUES (@id, @userId, @workoutType, @name, @startedAt, @endedAt, @durationMin,
            @distanceM, @calories, @avgHeartRate, @source, @note, @createdAt, @updatedAt, 1)
          ON CONFLICT (id) DO UPDATE SET
            workout_type = EXCLUDED.workout_type, name = EXCLUDED.name, ended_at = EXCLUDED.ended_at,
            duration_min = EXCLUDED.duration_min, distance_m = EXCLUDED.distance_m,
            calories = EXCLUDED.calories, avg_heart_rate = EXCLUDED.avg_heart_rate,
            source = EXCLUDED.source, note = EXCLUDED.note, updated_at = EXCLUDED.updated_at, sync_status = 1
          WHERE workout_logs.updated_at IS NULL OR EXCLUDED.updated_at >= workout_logs.updated_at
        '''),
        parameters: {
          'id': w.id,
          'userId': w.userId,
          'workoutType': w.workoutType,
          'name': w.name,
          'startedAt': w.startedAt,
          'endedAt': w.endedAt,
          'durationMin': w.durationMin,
          'distanceM': w.distanceM,
          'calories': w.calories,
          'avgHeartRate': w.avgHeartRate,
          'source': w.source,
          'note': w.note,
          'createdAt': w.createdAt,
          'updatedAt': w.updatedAt,
        },
      );
      await (_db.update(_db.workoutLogs)..where((row) => row.id.equals(w.id)))
          .write(const WorkoutLogsCompanion(syncStatus: Value(1)));
    }
    await _markSynced('workout_logs');
  }

  /// Pulls rows newer than the last sync for [table], applying last-write-wins
  /// by `updated_at` (or `created_at` for append-only log tables).
  Future<void> pull(String table) async {
    final conn = await _connection();
    final since = await lastSyncedAt(table);
    final tsColumn = _appendOnlyTables.contains(table) ? 'created_at' : 'updated_at';
    final result = await conn.execute(
      Sql.named('SELECT * FROM $table WHERE @since::timestamptz IS NULL OR $tsColumn > @since'),
      parameters: {'since': since},
    );
    for (final row in result) {
      final map = row.toColumnMap();
      switch (table) {
        case 'tasks':
          await _upsertLocalTask(map);
        case 'habits':
          await _upsertLocalHabit(map);
        case 'calendar_events':
          await _upsertLocalCalendarEvent(map);
        case 'focus_sessions':
          await _upsertLocalFocusSession(map);
        case 'goals':
          await _upsertLocalGoal(map);
        case 'journal_entries':
          await _upsertLocalJournalEntry(map);
        case 'gratitude_logs':
          await _upsertLocalGratitudeLog(map);
        case 'sleep_logs':
          await _upsertLocalSleepLog(map);
        case 'mood_logs':
          await _upsertLocalMoodLog(map);
        case 'water_logs':
          await _upsertLocalWaterLog(map);
        case 'workout_logs':
          await _upsertLocalWorkoutLog(map);
      }
    }
    await _markSynced(table);
  }

  static const _appendOnlyTables = {'gratitude_logs', 'sleep_logs', 'water_logs'};

  Future<void> _upsertLocalTask(Map<String, dynamic> r) async {
    final local = await (_db.select(_db.tasks)
          ..where((t) => t.id.equals(r['id'] as String)))
        .getSingleOrNull();
    final remoteUpdated = r['updated_at'] as DateTime;
    if (local != null && !remoteUpdated.isAfter(local.updatedAt)) return;
    await _db.into(_db.tasks).insertOnConflictUpdate(TasksCompanion(
          id: Value(r['id'] as String),
          userId: Value(r['user_id'] as String),
          title: Value(r['title'] as String),
          description: Value(r['description'] as String?),
          priority: Value(r['priority'] as int),
          isUrgent: Value(r['is_urgent'] as bool),
          isImportant: Value(r['is_important'] as bool),
          dueDate: Value(r['due_date'] as DateTime?),
          dueTime: Value(r['due_time'] as DateTime?),
          isCompleted: Value(r['is_completed'] as bool),
          completedAt: Value(r['completed_at'] as DateTime?),
          recurringConfigId: Value(r['recurring_config_id'] as String?),
          estimatedMinutes: Value(r['estimated_minutes'] as int?),
          createdAt: Value(r['created_at'] as DateTime),
          updatedAt: Value(remoteUpdated),
          syncStatus: const Value(1),
        ));
  }

  Future<void> _upsertLocalHabit(Map<String, dynamic> r) async {
    final local = await (_db.select(_db.habits)
          ..where((t) => t.id.equals(r['id'] as String)))
        .getSingleOrNull();
    final remoteUpdated = r['updated_at'] as DateTime;
    if (local != null && !remoteUpdated.isAfter(local.updatedAt)) return;
    await _db.into(_db.habits).insertOnConflictUpdate(HabitsCompanion(
          id: Value(r['id'] as String),
          userId: Value(r['user_id'] as String),
          name: Value(r['name'] as String),
          iconEmoji: Value(r['icon_emoji'] as String),
          category: Value(r['category'] as String),
          frequency: Value(r['frequency'] as String),
          targetValue: Value(r['target_value'] as int),
          unit: Value(r['unit'] as String?),
          chainNextId: Value(r['chain_next_id'] as String?),
          isActive: Value(r['is_active'] as bool),
          createdAt: Value(r['created_at'] as DateTime),
          updatedAt: Value(remoteUpdated),
          syncStatus: const Value(1),
        ));
  }

  Future<void> _upsertLocalCalendarEvent(Map<String, dynamic> r) async {
    final local = await (_db.select(_db.calendarEvents)
          ..where((t) => t.id.equals(r['id'] as String)))
        .getSingleOrNull();
    final remoteUpdated = r['updated_at'] as DateTime;
    if (local != null && !remoteUpdated.isAfter(local.updatedAt)) return;
    await _db.into(_db.calendarEvents).insertOnConflictUpdate(CalendarEventsCompanion(
          id: Value(r['id'] as String),
          userId: Value(r['user_id'] as String),
          title: Value(r['title'] as String),
          description: Value(r['description'] as String?),
          location: Value(r['location'] as String?),
          startTime: Value(r['start_time'] as DateTime),
          endTime: Value(r['end_time'] as DateTime),
          isAllDay: Value(r['is_all_day'] as bool),
          color: Value(r['color'] as String),
          recurrenceRule: Value(r['recurrence_rule'] as String?),
          linkedTaskId: Value(r['linked_task_id'] as String?),
          reminderMinutes: Value(r['reminder_minutes'] as int?),
          createdAt: Value(r['created_at'] as DateTime),
          updatedAt: Value(remoteUpdated),
          syncStatus: const Value(1),
        ));
  }

  Future<void> _upsertLocalFocusSession(Map<String, dynamic> r) async {
    final exists = await (_db.select(_db.focusSessions)
          ..where((t) => t.id.equals(r['id'] as String)))
        .getSingleOrNull();
    if (exists != null) return;
    await _db.into(_db.focusSessions).insertOnConflictUpdate(FocusSessionsCompanion(
          id: Value(r['id'] as String),
          userId: Value(r['user_id'] as String),
          durationMinutes: Value(r['duration_minutes'] as int),
          sessionType: Value(r['session_type'] as String),
          wasCompleted: Value(r['was_completed'] as bool),
          linkedTaskId: Value(r['linked_task_id'] as String?),
          startedAt: Value(r['started_at'] as DateTime),
          endedAt: Value(r['ended_at'] as DateTime),
          syncStatus: const Value(1),
        ));
  }

  Future<void> _upsertLocalGoal(Map<String, dynamic> r) async {
    final local = await (_db.select(_db.goals)
          ..where((t) => t.id.equals(r['id'] as String)))
        .getSingleOrNull();
    final remoteUpdated = r['updated_at'] as DateTime;
    if (local != null && !remoteUpdated.isAfter(local.updatedAt)) return;
    await _db.into(_db.goals).insertOnConflictUpdate(GoalsCompanion(
          id: Value(r['id'] as String),
          userId: Value(r['user_id'] as String),
          title: Value(r['title'] as String),
          description: Value(r['description'] as String?),
          lifeArea: Value(r['life_area'] as String),
          metricType: Value(r['metric_type'] as String),
          targetValue: Value(r['target_value'] as double),
          currentValue: Value(r['current_value'] as double),
          unit: Value(r['unit'] as String?),
          targetDate: Value(r['target_date'] as DateTime?),
          priority: Value(r['priority'] as int),
          status: Value(r['status'] as String),
          icon: Value(r['icon'] as String?),
          colorHex: Value(r['color_hex'] as String),
          visibility: Value(r['visibility'] as String),
          completedAt: Value(r['completed_at'] as DateTime?),
          createdAt: Value(r['created_at'] as DateTime),
          updatedAt: Value(remoteUpdated),
          deletedAt: Value(r['deleted_at'] as DateTime?),
          syncStatus: const Value(1),
        ));
  }

  Future<void> _upsertLocalJournalEntry(Map<String, dynamic> r) async {
    final local = await (_db.select(_db.journalEntries)
          ..where((t) => t.id.equals(r['id'] as String)))
        .getSingleOrNull();
    final remoteUpdated = r['updated_at'] as DateTime;
    if (local != null && !remoteUpdated.isAfter(local.updatedAt)) return;
    await _db.into(_db.journalEntries).insertOnConflictUpdate(JournalEntriesCompanion(
          id: Value(r['id'] as String),
          userId: Value(r['user_id'] as String),
          entryDate: Value(r['entry_date'] as DateTime),
          title: Value(r['title'] as String?),
          content: Value(r['content'] as String),
          moodTag: Value(r['mood_tag'] as String?),
          isPrivate: Value(r['is_private'] as bool),
          wordCount: Value(r['word_count'] as int),
          createdAt: Value(r['created_at'] as DateTime),
          updatedAt: Value(remoteUpdated),
          syncStatus: const Value(1),
        ));
  }

  Future<void> _upsertLocalGratitudeLog(Map<String, dynamic> r) async {
    final exists = await (_db.select(_db.gratitudeLogs)
          ..where((t) => t.id.equals(r['id'] as String)))
        .getSingleOrNull();
    if (exists != null) return;
    await _db.into(_db.gratitudeLogs).insertOnConflictUpdate(GratitudeLogsCompanion(
          id: Value(r['id'] as String),
          userId: Value(r['user_id'] as String),
          logDate: Value(r['log_date'] as DateTime),
          item1: Value(r['item1'] as String),
          item2: Value(r['item2'] as String?),
          item3: Value(r['item3'] as String?),
          createdAt: Value(r['created_at'] as DateTime),
          syncStatus: const Value(1),
        ));
  }

  Future<void> _upsertLocalSleepLog(Map<String, dynamic> r) async {
    final exists = await (_db.select(_db.sleepLogs)
          ..where((t) => t.id.equals(r['id'] as String)))
        .getSingleOrNull();
    if (exists != null) return;
    await _db.into(_db.sleepLogs).insertOnConflictUpdate(SleepLogsCompanion(
          id: Value(r['id'] as String),
          userId: Value(r['user_id'] as String),
          bedtime: Value(r['bedtime'] as DateTime),
          wakeTime: Value(r['wake_time'] as DateTime),
          qualityRating: Value(r['quality_rating'] as int),
          sleepLatencyMinutes: Value(r['sleep_latency_minutes'] as int?),
          hadNightmares: Value(r['had_nightmares'] as bool),
          notes: Value(r['notes'] as String?),
          createdAt: Value(r['created_at'] as DateTime),
          syncStatus: const Value(1),
        ));
  }

  Future<void> _upsertLocalMoodLog(Map<String, dynamic> r) async {
    final local = await (_db.select(_db.moodLogs)
          ..where((t) => t.id.equals(r['id'] as String)))
        .getSingleOrNull();
    final remoteUpdated = r['updated_at'] as DateTime;
    if (local != null && !remoteUpdated.isAfter(local.updatedAt)) return;
    await _db.into(_db.moodLogs).insertOnConflictUpdate(MoodLogsCompanion(
          id: Value(r['id'] as String),
          userId: Value(r['user_id'] as String),
          logDate: Value(r['log_date'] as DateTime),
          logTime: Value(r['log_time'] as DateTime),
          moodScore: Value(r['mood_score'] as int),
          energyScore: Value(r['energy_score'] as int?),
          moodTags: Value(r['mood_tags'] as String?),
          factors: Value(r['factors'] as String?),
          note: Value(r['note'] as String?),
          createdAt: Value(r['created_at'] as DateTime),
          updatedAt: Value(remoteUpdated),
          syncStatus: const Value(1),
        ));
  }

  Future<void> _upsertLocalWaterLog(Map<String, dynamic> r) async {
    final exists = await (_db.select(_db.waterLogs)
          ..where((t) => t.id.equals(r['id'] as String)))
        .getSingleOrNull();
    if (exists != null) return;
    await _db.into(_db.waterLogs).insertOnConflictUpdate(WaterLogsCompanion(
          id: Value(r['id'] as String),
          userId: Value(r['user_id'] as String),
          logDate: Value(r['log_date'] as DateTime),
          logTime: Value(r['log_time'] as DateTime),
          amountMl: Value(r['amount_ml'] as int),
          containerType: Value(r['container_type'] as String?),
          createdAt: Value(r['created_at'] as DateTime),
          syncStatus: const Value(1),
        ));
  }

  Future<void> _upsertLocalWorkoutLog(Map<String, dynamic> r) async {
    final local = await (_db.select(_db.workoutLogs)
          ..where((t) => t.id.equals(r['id'] as String)))
        .getSingleOrNull();
    final remoteUpdated = r['updated_at'] as DateTime;
    if (local != null && !remoteUpdated.isAfter(local.updatedAt)) return;
    await _db.into(_db.workoutLogs).insertOnConflictUpdate(WorkoutLogsCompanion(
          id: Value(r['id'] as String),
          userId: Value(r['user_id'] as String),
          workoutType: Value(r['workout_type'] as String),
          name: Value(r['name'] as String?),
          startedAt: Value(r['started_at'] as DateTime),
          endedAt: Value(r['ended_at'] as DateTime?),
          durationMin: Value(r['duration_min'] as int?),
          distanceM: Value(r['distance_m'] as double?),
          calories: Value(r['calories'] as int?),
          avgHeartRate: Value(r['avg_heart_rate'] as int?),
          source: Value(r['source'] as String),
          note: Value(r['note'] as String?),
          createdAt: Value(r['created_at'] as DateTime),
          updatedAt: Value(remoteUpdated),
          syncStatus: const Value(1),
        ));
  }
}

@Riverpod(keepAlive: true)
SyncService syncService(Ref ref) {
  final db = ref.watch(databaseProvider);
  final service = SyncService(db);
  ref.onDispose(service.close);
  return service;
}

@riverpod
class SyncController extends _$SyncController {
  @override
  SyncStatus build() => const SyncStatus(phase: SyncPhase.idle);

  Future<void> syncNow() async {
    state = const SyncStatus(phase: SyncPhase.syncing);
    final service = ref.read(syncServiceProvider);
    try {
      await service.flush();
      for (final table in const [
        'tasks',
        'habits',
        'calendar_events',
        'focus_sessions',
        'goals',
        'journal_entries',
        'gratitude_logs',
        'sleep_logs',
        'mood_logs',
        'water_logs',
        'workout_logs',
      ]) {
        await service.pull(table);
      }
      state = SyncStatus(phase: SyncPhase.idle, lastSyncedAt: DateTime.now());
    } catch (e) {
      state = SyncStatus(phase: SyncPhase.error, error: e.toString());
    }
  }
}
