import 'package:drift/drift.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/features/sleep/data/models/alarm_model.dart';
import 'package:hybrid_tracker/features/sleep/data/models/sleep_log_model.dart';

abstract class SleepRepository {
  Stream<List<SleepLogModel>> watchRecentSleepLogs(
    String userId, {
    int days = 7,
  });
  Stream<List<AlarmModel>> watchAlarms(String userId);
  Future<AlarmModel?> getAlarm(String id);
  Future<SleepLogModel?> getLastSleepLog(String userId);
  Future<void> logSleep(SleepLogModel log);
  Future<void> updateSleepLog(SleepLogModel log);
  Future<void> deleteSleepLog(String id);
  Future<void> createAlarm(AlarmModel alarm);
  Future<void> updateAlarm(AlarmModel alarm);
  Future<void> deleteAlarm(String id);
  Future<void> toggleAlarm(String id, bool enabled);
}

class SleepRepositoryImpl implements SleepRepository {
  SleepRepositoryImpl(this._db);

  final AppDatabase _db;

  static AlarmMissionType _missionFromString(String s) {
    switch (s) {
      case 'math':
        return AlarmMissionType.math;
      case 'shake':
        return AlarmMissionType.shake;
      default:
        return AlarmMissionType.none;
    }
  }

  static String _missionToString(AlarmMissionType t) {
    switch (t) {
      case AlarmMissionType.math:
        return 'math';
      case AlarmMissionType.shake:
        return 'shake';
      case AlarmMissionType.none:
        return 'none';
    }
  }

  SleepLogModel _logRowToModel(SleepLog row) => SleepLogModel(
        id: row.id,
        userId: row.userId,
        bedtime: row.bedtime,
        wakeTime: row.wakeTime,
        qualityRating: row.qualityRating,
        sleepLatencyMinutes: row.sleepLatencyMinutes,
        hadNightmares: row.hadNightmares,
        notes: row.notes,
        syncStatus: row.syncStatus,
        createdAt: row.createdAt,
      );

  AlarmModel _alarmRowToModel(Alarm row) => AlarmModel(
        id: row.id,
        userId: row.userId,
        label: row.label,
        time: row.time,
        daysOfWeek: row.daysOfWeek,
        isEnabled: row.isEnabled,
        missionType: _missionFromString(row.missionType),
        snoozeCount: row.snoozeCount,
        snoozeDurationMinutes: row.snoozeDurationMinutes,
        soundName: row.soundName,
        mathLevel: row.mathLevel,
        mathProblemCount: row.mathProblemCount,
        createdAt: row.createdAt,
      );

  @override
  Stream<List<SleepLogModel>> watchRecentSleepLogs(
    String userId, {
    int days = 7,
  }) {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return (_db.select(_db.sleepLogs)
          ..where(
            (l) =>
                l.userId.equals(userId) &
                l.createdAt.isBiggerOrEqualValue(cutoff),
          )
          ..orderBy([(l) => OrderingTerm.desc(l.createdAt)]))
        .watch()
        .map((rows) => rows.map(_logRowToModel).toList());
  }

  @override
  Stream<List<AlarmModel>> watchAlarms(String userId) {
    return (_db.select(_db.alarms)
          ..where((a) => a.userId.equals(userId))
          ..orderBy([(a) => OrderingTerm.asc(a.createdAt)]))
        .watch()
        .map((rows) => rows.map(_alarmRowToModel).toList());
  }

  @override
  Future<AlarmModel?> getAlarm(String id) async {
    final row = await (_db.select(_db.alarms)..where((a) => a.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return null;
    return _alarmRowToModel(row);
  }

  @override
  Future<SleepLogModel?> getLastSleepLog(String userId) async {
    final row = await (_db.select(_db.sleepLogs)
          ..where((l) => l.userId.equals(userId))
          ..orderBy([(l) => OrderingTerm.desc(l.createdAt)])
          ..limit(1))
        .getSingleOrNull();
    if (row == null) return null;
    return _logRowToModel(row);
  }

  @override
  Future<void> logSleep(SleepLogModel log) async {
    await _db.into(_db.sleepLogs).insertOnConflictUpdate(
          SleepLogsCompanion(
            id: Value(log.id),
            userId: Value(log.userId),
            bedtime: Value(log.bedtime),
            wakeTime: Value(log.wakeTime),
            qualityRating: Value(log.qualityRating),
            sleepLatencyMinutes: Value(log.sleepLatencyMinutes),
            hadNightmares: Value(log.hadNightmares),
            notes: Value(log.notes),
            syncStatus: const Value(0),
            createdAt: Value(log.createdAt),
          ),
        );
  }

  @override
  Future<void> updateSleepLog(SleepLogModel log) async {
    await (_db.update(_db.sleepLogs)..where((l) => l.id.equals(log.id))).write(
      SleepLogsCompanion(
        bedtime: Value(log.bedtime),
        wakeTime: Value(log.wakeTime),
        qualityRating: Value(log.qualityRating),
        sleepLatencyMinutes: Value(log.sleepLatencyMinutes),
        hadNightmares: Value(log.hadNightmares),
        notes: Value(log.notes),
        syncStatus: const Value(0),
      ),
    );
  }

  @override
  Future<void> deleteSleepLog(String id) async {
    await (_db.delete(_db.sleepLogs)..where((l) => l.id.equals(id))).go();
  }

  @override
  Future<void> createAlarm(AlarmModel alarm) async {
    await _db.into(_db.alarms).insertOnConflictUpdate(
          AlarmsCompanion(
            id: Value(alarm.id),
            userId: Value(alarm.userId),
            label: Value(alarm.label),
            time: Value(alarm.time),
            daysOfWeek: Value(alarm.daysOfWeek),
            isEnabled: Value(alarm.isEnabled),
            missionType: Value(_missionToString(alarm.missionType)),
            snoozeCount: Value(alarm.snoozeCount),
            snoozeDurationMinutes: Value(alarm.snoozeDurationMinutes),
            soundName: Value(alarm.soundName),
            mathLevel: Value(alarm.mathLevel),
            mathProblemCount: Value(alarm.mathProblemCount),
            createdAt: Value(alarm.createdAt),
          ),
        );
  }

  @override
  Future<void> updateAlarm(AlarmModel alarm) async {
    await (_db.update(_db.alarms)..where((a) => a.id.equals(alarm.id))).write(
      AlarmsCompanion(
        label: Value(alarm.label),
        time: Value(alarm.time),
        daysOfWeek: Value(alarm.daysOfWeek),
        isEnabled: Value(alarm.isEnabled),
        missionType: Value(_missionToString(alarm.missionType)),
        snoozeCount: Value(alarm.snoozeCount),
        snoozeDurationMinutes: Value(alarm.snoozeDurationMinutes),
        soundName: Value(alarm.soundName),
        mathLevel: Value(alarm.mathLevel),
        mathProblemCount: Value(alarm.mathProblemCount),
      ),
    );
  }

  @override
  Future<void> deleteAlarm(String id) async {
    await (_db.delete(_db.alarms)..where((a) => a.id.equals(id))).go();
  }

  @override
  Future<void> toggleAlarm(String id, bool enabled) async {
    await (_db.update(_db.alarms)..where((a) => a.id.equals(id))).write(
      AlarmsCompanion(isEnabled: Value(enabled)),
    );
  }
}
