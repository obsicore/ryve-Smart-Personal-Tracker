import 'package:drift/drift.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/features/habits/data/models/habit_model.dart';

// ---------------------------------------------------------------------------
// Abstract interface
// ---------------------------------------------------------------------------
abstract class HabitRepository {
  /// Emits the user's active habits, enriched with today's log status and
  /// streak data. The stream re-emits whenever either the habits table or the
  /// habit_logs table changes (the Drift join query watches both).
  Stream<List<HabitModel>> watchHabits(String userId);

  Future<HabitModel?> getHabit(String id);
  Future<void> createHabit(HabitModel habit);
  Future<void> updateHabit(HabitModel habit);
  Future<void> deleteHabit(String id);
  Future<void> logHabit(HabitLogModel log);
  Future<List<HabitLogModel>> getLogsForHabit(String habitId, {int days = 30});
}

// ---------------------------------------------------------------------------
// Drift implementation
// ---------------------------------------------------------------------------
class HabitRepositoryImpl implements HabitRepository {
  HabitRepositoryImpl(this._db);

  final AppDatabase _db;

  // -------------------------------------------------------------------------
  // watchHabits — join query watches both tables for reactive updates
  // -------------------------------------------------------------------------
  @override
  Stream<List<HabitModel>> watchHabits(String userId) {
    final cutoff = DateTime.now().subtract(const Duration(days: 90));

    // This join query watches BOTH habits AND habit_logs, so any log write
    // (e.g. after tapping the log button) causes the stream to re-emit.
    final query = _db.select(_db.habits).join([
      leftOuterJoin(
        _db.habitLogs,
        _db.habitLogs.habitId.equalsExp(_db.habits.id) &
            _db.habitLogs.logDate.isBiggerOrEqualValue(cutoff),
      ),
    ])
      ..where(
        _db.habits.userId.equals(userId) & _db.habits.isActive.equals(true),
      )
      ..orderBy([OrderingTerm.asc(_db.habits.createdAt)]);

    return query.watch().map((rows) {
      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);

      // Group: one entry per habit, accumulating its logs
      final habitRows = <String, Habit>{};
      final habitLogs = <String, List<HabitLog>>{};
      final habitOrder = <String>[];

      for (final row in rows) {
        final habit = row.readTable(_db.habits);
        final log = row.readTableOrNull(_db.habitLogs);

        if (!habitRows.containsKey(habit.id)) {
          habitRows[habit.id] = habit;
          habitLogs[habit.id] = [];
          habitOrder.add(habit.id);
        }
        if (log != null) {
          habitLogs[habit.id]!.add(log);
        }
      }

      return habitOrder.map((id) {
        return _enrichHabit(
          habitRows[id]!,
          habitLogs[id]!,
          now,
          todayStart,
        );
      }).toList();
    });
  }

  // -------------------------------------------------------------------------
  // getHabit
  // -------------------------------------------------------------------------
  @override
  Future<HabitModel?> getHabit(String id) async {
    final row = await (_db.select(_db.habits)
          ..where((h) => h.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return null;
    final logs = await _fetchRecentLogs(id, 90);
    final now = DateTime.now();
    return _enrichHabit(row, logs, now, DateTime(now.year, now.month, now.day));
  }

  // -------------------------------------------------------------------------
  // createHabit
  // -------------------------------------------------------------------------
  @override
  Future<void> createHabit(HabitModel habit) async {
    await _db.into(_db.habits).insertOnConflictUpdate(
          HabitsCompanion(
            id: Value(habit.id),
            userId: Value(habit.userId),
            name: Value(habit.name),
            iconEmoji: Value(habit.iconEmoji),
            category: Value(habit.category),
            frequency: Value(habit.frequency),
            targetValue: Value(habit.targetValue),
            unit: Value(habit.unit),
            chainNextId: Value(habit.chainNextId),
            isActive: Value(habit.isActive),
            createdAt: Value(habit.createdAt),
            updatedAt: Value(habit.createdAt),
            syncStatus: const Value(0),
          ),
        );
  }

  // -------------------------------------------------------------------------
  // updateHabit
  // -------------------------------------------------------------------------
  @override
  Future<void> updateHabit(HabitModel habit) async {
    await (_db.update(_db.habits)..where((h) => h.id.equals(habit.id))).write(
      HabitsCompanion(
        name: Value(habit.name),
        iconEmoji: Value(habit.iconEmoji),
        category: Value(habit.category),
        frequency: Value(habit.frequency),
        targetValue: Value(habit.targetValue),
        unit: Value(habit.unit),
        chainNextId: Value(habit.chainNextId),
        isActive: Value(habit.isActive),
        updatedAt: Value(DateTime.now()),
        syncStatus: const Value(0),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // deleteHabit — soft delete (isActive = false)
  // -------------------------------------------------------------------------
  @override
  Future<void> deleteHabit(String id) async {
    await (_db.update(_db.habits)..where((h) => h.id.equals(id))).write(
      HabitsCompanion(
        isActive: const Value(false),
        updatedAt: Value(DateTime.now()),
        syncStatus: const Value(0),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // logHabit
  // -------------------------------------------------------------------------
  @override
  Future<void> logHabit(HabitLogModel log) async {
    await _db.into(_db.habitLogs).insertOnConflictUpdate(
          HabitLogsCompanion(
            id: Value(log.id),
            habitId: Value(log.habitId),
            userId: Value(log.userId ?? ''),
            logDate: Value(log.logDate),
            value: Value(log.value),
            moodAfter: Value(log.moodAfter),
            notes: Value(log.notes),
            syncStatus: const Value(0),
          ),
        );
  }

  // -------------------------------------------------------------------------
  // getLogsForHabit
  // -------------------------------------------------------------------------
  @override
  Future<List<HabitLogModel>> getLogsForHabit(
    String habitId, {
    int days = 30,
  }) async {
    final rows = await _fetchRecentLogs(habitId, days);
    return rows.map(_logRowToModel).toList();
  }

  // =========================================================================
  // Private helpers
  // =========================================================================

  Future<List<HabitLog>> _fetchRecentLogs(String habitId, int days) {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return (_db.select(_db.habitLogs)
          ..where(
            (l) =>
                l.habitId.equals(habitId) &
                l.logDate.isBiggerOrEqualValue(cutoff),
          )
          ..orderBy([(l) => OrderingTerm.desc(l.logDate)]))
        .get();
  }

  HabitLogModel _logRowToModel(HabitLog row) => HabitLogModel(
        id: row.id,
        habitId: row.habitId,
        logDate: row.logDate,
        value: row.value,
        moodAfter: row.moodAfter,
        notes: row.notes,
        userId: row.userId,
      );

  HabitModel _enrichHabit(
    Habit habit,
    List<HabitLog> logs,
    DateTime now,
    DateTime todayStart,
  ) {
    // Unique calendar dates that have at least one log
    final logDateSet = logs
        .map((l) => DateTime(l.logDate.year, l.logDate.month, l.logDate.day))
        .toSet();

    // Today's aggregated value
    final todayLogs = logs.where((l) {
      final d = DateTime(l.logDate.year, l.logDate.month, l.logDate.day);
      return d == todayStart;
    });
    final completedToday = todayLogs.isNotEmpty;
    final todayValue = todayLogs.fold(0.0, (s, l) => s + l.value);
    final todayProgress = habit.targetValue > 0
        ? (todayValue / habit.targetValue).clamp(0.0, 1.0)
        : 0.0;

    // Streaks
    final currentStreak = _currentStreak(logDateSet, todayStart);
    final longestStreak = _longestStreak(logDateSet);

    // Last 30 completed dates for heatmap / week dots
    final thirtyDaysAgo = todayStart.subtract(const Duration(days: 30));
    final completedDates = logDateSet
        .where((d) => !d.isBefore(thirtyDaysAgo))
        .toList()
      ..sort();

    return HabitModel(
      id: habit.id,
      userId: habit.userId,
      name: habit.name,
      iconEmoji: habit.iconEmoji,
      category: habit.category,
      frequency: habit.frequency,
      targetValue: habit.targetValue,
      unit: habit.unit,
      chainNextId: habit.chainNextId,
      isActive: habit.isActive,
      createdAt: habit.createdAt,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      completedToday: completedToday,
      todayProgress: todayProgress,
      completedDates: completedDates,
    );
  }

  int _currentStreak(Set<DateTime> logDates, DateTime todayStart) {
    if (logDates.isEmpty) return 0;
    var streak = 0;
    var check = todayStart;
    if (!logDates.contains(check)) {
      check = check.subtract(const Duration(days: 1));
      if (!logDates.contains(check)) return 0;
    }
    while (logDates.contains(check) && streak <= 365) {
      streak++;
      check = check.subtract(const Duration(days: 1));
    }
    return streak;
  }

  int _longestStreak(Set<DateTime> logDates) {
    if (logDates.isEmpty) return 0;
    final sorted = logDates.toList()..sort();
    var longest = 1;
    var current = 1;
    for (var i = 1; i < sorted.length; i++) {
      if (sorted[i].difference(sorted[i - 1]).inDays == 1) {
        current++;
        if (current > longest) longest = current;
      } else {
        current = 1;
      }
    }
    return longest;
  }
}
