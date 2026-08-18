import 'package:drift/drift.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/features/focus/data/models/focus_session_model.dart';

abstract class FocusRepository {
  Stream<List<FocusSessionModel>> watchTodaySessions(String userId);
  Stream<FocusSettingsModel?> watchSettings(String userId);
  Future<void> saveSession(FocusSessionModel s);
  Future<void> saveSettings(FocusSettingsModel s);
  Future<int> getTotalFocusMinutesToday(String userId);
  Future<int> getSessionsCountToday(String userId);
  Future<int> getStreakDays(String userId);
}

class FocusRepositoryImpl implements FocusRepository {
  FocusRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Stream<List<FocusSessionModel>> watchTodaySessions(String userId) {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    return (_db.select(_db.focusSessions)
          ..where(
            (s) =>
                s.userId.equals(userId) &
                s.startedAt.isBiggerOrEqualValue(todayStart),
          )
          ..orderBy([(s) => OrderingTerm.desc(s.startedAt)]))
        .watch()
        .map((rows) => rows.map(_rowToModel).toList());
  }

  @override
  Stream<FocusSettingsModel?> watchSettings(String userId) {
    return (_db.select(_db.focusSettings)
          ..where((s) => s.userId.equals(userId)))
        .watchSingleOrNull()
        .map((row) => row == null ? null : _settingsRowToModel(row));
  }

  @override
  Future<void> saveSession(FocusSessionModel s) async {
    await _db.into(_db.focusSessions).insertOnConflictUpdate(
          FocusSessionsCompanion(
            id: Value(s.id),
            userId: Value(s.userId),
            durationMinutes: Value(s.durationMinutes),
            sessionType: Value(_typeToString(s.sessionType)),
            wasCompleted: Value(s.wasCompleted),
            linkedTaskId: Value(s.linkedTaskId),
            startedAt: Value(s.startedAt),
            endedAt: Value(s.endedAt),
            syncStatus: Value(s.syncStatus),
          ),
        );
  }

  @override
  Future<void> saveSettings(FocusSettingsModel s) async {
    await _db.into(_db.focusSettings).insertOnConflictUpdate(
          FocusSettingsCompanion(
            userId: Value(s.userId),
            workMinutes: Value(s.workMinutes),
            shortBreakMinutes: Value(s.shortBreakMinutes),
            longBreakMinutes: Value(s.longBreakMinutes),
            sessionsBeforeLongBreak: Value(s.sessionsBeforeLongBreak),
            autoStartBreaks: Value(s.autoStartBreaks),
            soundEnabled: Value(s.soundEnabled),
          ),
        );
  }

  @override
  Future<int> getTotalFocusMinutesToday(String userId) async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final rows = await (_db.select(_db.focusSessions)
          ..where(
            (s) =>
                s.userId.equals(userId) &
                s.startedAt.isBiggerOrEqualValue(todayStart) &
                s.sessionType.equals('work'),
          ))
        .get();
    return rows.fold<int>(0, (sum, r) => sum + r.durationMinutes);
  }

  @override
  Future<int> getSessionsCountToday(String userId) async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final rows = await (_db.select(_db.focusSessions)
          ..where(
            (s) =>
                s.userId.equals(userId) &
                s.startedAt.isBiggerOrEqualValue(todayStart) &
                s.sessionType.equals('work') &
                s.wasCompleted.equals(true),
          ))
        .get();
    return rows.length;
  }

  @override
  Future<int> getStreakDays(String userId) async {
    final rows = await (_db.select(_db.focusSessions)
          ..where(
            (s) =>
                s.userId.equals(userId) &
                s.sessionType.equals('work') &
                s.wasCompleted.equals(true),
          )
          ..orderBy([(s) => OrderingTerm.desc(s.startedAt)]))
        .get();

    if (rows.isEmpty) return 0;

    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    final dates = rows
        .map(
          (r) => DateTime(
            r.startedAt.year,
            r.startedAt.month,
            r.startedAt.day,
          ),
        )
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));

    if (dates.first.isBefore(todayStart.subtract(const Duration(days: 1)))) {
      return 0;
    }

    var streak = 0;
    var expected = dates.first;
    for (final date in dates) {
      if (date == expected) {
        streak++;
        expected = expected.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    return streak;
  }

  FocusSessionModel _rowToModel(FocusSession row) => FocusSessionModel(
        id: row.id,
        userId: row.userId,
        durationMinutes: row.durationMinutes,
        sessionType: _typeFromString(row.sessionType),
        wasCompleted: row.wasCompleted,
        linkedTaskId: row.linkedTaskId,
        startedAt: row.startedAt,
        endedAt: row.endedAt,
        syncStatus: row.syncStatus,
      );

  FocusSettingsModel _settingsRowToModel(FocusSetting row) => FocusSettingsModel(
        userId: row.userId,
        workMinutes: row.workMinutes,
        shortBreakMinutes: row.shortBreakMinutes,
        longBreakMinutes: row.longBreakMinutes,
        sessionsBeforeLongBreak: row.sessionsBeforeLongBreak,
        autoStartBreaks: row.autoStartBreaks,
        soundEnabled: row.soundEnabled,
      );

  String _typeToString(FocusSessionType type) {
    switch (type) {
      case FocusSessionType.work:
        return 'work';
      case FocusSessionType.shortBreak:
        return 'short_break';
      case FocusSessionType.longBreak:
        return 'long_break';
    }
  }

  FocusSessionType _typeFromString(String s) {
    switch (s) {
      case 'short_break':
        return FocusSessionType.shortBreak;
      case 'long_break':
        return FocusSessionType.longBreak;
      default:
        return FocusSessionType.work;
    }
  }
}
