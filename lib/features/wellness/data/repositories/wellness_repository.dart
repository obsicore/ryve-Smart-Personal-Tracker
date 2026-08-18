import 'dart:convert';

import 'package:drift/drift.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/features/wellness/data/models/breathing_session_model.dart';
import 'package:hybrid_tracker/features/wellness/data/models/energy_log_model.dart';
import 'package:hybrid_tracker/features/wellness/data/models/mood_log_model.dart';
import 'package:hybrid_tracker/features/wellness/data/models/step_log_model.dart';
import 'package:hybrid_tracker/features/wellness/data/models/water_log_model.dart';
import 'package:hybrid_tracker/features/wellness/data/models/workout_model.dart';

DateTime _dayStart(DateTime d) => DateTime(d.year, d.month, d.day);

abstract class WellnessRepository {
  Stream<List<MoodLogModel>> watchRecentMoodLogs(String userId, {int days = 7});
  Future<MoodLogModel?> getTodayMood(String userId);
  Future<void> logMood(MoodLogModel log);

  Future<void> logEnergy(EnergyLogModel log);

  Stream<List<WaterLogModel>> watchTodayWater(String userId);
  Future<void> logWater(WaterLogModel log);

  Future<StepLogModel?> getTodaySteps(String userId);
  Future<StepLogModel?> getYesterdaySteps(String userId);
  Future<void> logSteps(StepLogModel log);

  Future<void> logWorkout(WorkoutLogModel workout);
  Stream<List<WorkoutLogModel>> watchRecentWorkouts(String userId, {int days = 14});

  Future<void> logBreathingSession(BreathingSessionModel session);
  Stream<List<BreathingSessionModel>> watchRecentBreathingSessions(String userId, {int days = 14});
}

class WellnessRepositoryImpl implements WellnessRepository {
  WellnessRepositoryImpl(this._db);

  final AppDatabase _db;

  MoodLogModel _moodRowToModel(MoodLog row) => MoodLogModel(
        id: row.id,
        userId: row.userId,
        logDate: row.logDate,
        logTime: row.logTime,
        moodScore: row.moodScore,
        energyScore: row.energyScore,
        moodTags: row.moodTags == null
            ? []
            : List<String>.from(jsonDecode(row.moodTags!) as List),
        factors: row.factors == null
            ? []
            : List<String>.from(jsonDecode(row.factors!) as List),
        note: row.note,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
        syncStatus: row.syncStatus,
      );

  WaterLogModel _waterRowToModel(WaterLog row) => WaterLogModel(
        id: row.id,
        userId: row.userId,
        logDate: row.logDate,
        logTime: row.logTime,
        amountMl: row.amountMl,
        containerType: row.containerType,
        createdAt: row.createdAt,
        syncStatus: row.syncStatus,
      );

  StepLogModel _stepRowToModel(DailyStepLog row) => StepLogModel(
        id: row.id,
        userId: row.userId,
        logDate: row.logDate,
        stepCount: row.stepCount,
        distanceM: row.distanceM,
        calories: row.calories,
        source: row.source,
        updatedAt: row.updatedAt,
      );

  WorkoutLogModel _workoutRowToModel(WorkoutLog row, List<WorkoutSet> sets) =>
      WorkoutLogModel(
        id: row.id,
        userId: row.userId,
        workoutType: row.workoutType,
        name: row.name,
        startedAt: row.startedAt,
        endedAt: row.endedAt,
        durationMin: row.durationMin,
        distanceM: row.distanceM,
        calories: row.calories,
        avgHeartRate: row.avgHeartRate,
        source: row.source,
        note: row.note,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
        syncStatus: row.syncStatus,
        sets: sets
            .map((s) => WorkoutSetModel(
                  id: s.id,
                  workoutId: s.workoutId,
                  exerciseName: s.exerciseName,
                  setNumber: s.setNumber,
                  reps: s.reps,
                  weightKg: s.weightKg,
                  durationSec: s.durationSec,
                  note: s.note,
                ))
            .toList(),
      );

  BreathingSessionModel _breathingRowToModel(BreathingSession row) =>
      BreathingSessionModel(
        id: row.id,
        userId: row.userId,
        technique: row.technique,
        durationMin: row.durationMin,
        cyclesCompleted: row.cyclesCompleted,
        moodBefore: row.moodBefore,
        moodAfter: row.moodAfter,
        completed: row.completed,
        startedAt: row.startedAt,
        endedAt: row.endedAt,
        createdAt: row.createdAt,
      );

  @override
  Stream<List<MoodLogModel>> watchRecentMoodLogs(String userId, {int days = 7}) {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return (_db.select(_db.moodLogs)
          ..where((m) => m.userId.equals(userId) & m.logDate.isBiggerOrEqualValue(cutoff))
          ..orderBy([(m) => OrderingTerm.asc(m.logDate)]))
        .watch()
        .map((rows) => rows.map(_moodRowToModel).toList());
  }

  @override
  Future<MoodLogModel?> getTodayMood(String userId) async {
    final start = _dayStart(DateTime.now());
    final row = await (_db.select(_db.moodLogs)
          ..where((m) => m.userId.equals(userId) & m.logDate.isBiggerOrEqualValue(start))
          ..orderBy([(m) => OrderingTerm.desc(m.logTime)])
          ..limit(1))
        .getSingleOrNull();
    return row == null ? null : _moodRowToModel(row);
  }

  @override
  Future<void> logMood(MoodLogModel log) async {
    await _db.into(_db.moodLogs).insertOnConflictUpdate(
          MoodLogsCompanion(
            id: Value(log.id),
            userId: Value(log.userId),
            logDate: Value(log.logDate),
            logTime: Value(log.logTime),
            moodScore: Value(log.moodScore),
            energyScore: Value(log.energyScore),
            moodTags: Value(jsonEncode(log.moodTags)),
            factors: Value(jsonEncode(log.factors)),
            note: Value(log.note),
            createdAt: Value(log.createdAt),
            updatedAt: Value(log.updatedAt),
            syncStatus: const Value(0),
          ),
        );
  }

  @override
  Future<void> logEnergy(EnergyLogModel log) async {
    await _db.into(_db.energyLogs).insertOnConflictUpdate(
          EnergyLogsCompanion(
            id: Value(log.id),
            userId: Value(log.userId),
            logDate: Value(log.logDate),
            logTime: Value(log.logTime),
            energyLevel: Value(log.energyLevel),
            note: Value(log.note),
            createdAt: Value(log.createdAt),
          ),
        );
  }

  @override
  Stream<List<WaterLogModel>> watchTodayWater(String userId) {
    final start = _dayStart(DateTime.now());
    return (_db.select(_db.waterLogs)
          ..where((w) => w.userId.equals(userId) & w.logDate.isBiggerOrEqualValue(start))
          ..orderBy([(w) => OrderingTerm.asc(w.logTime)]))
        .watch()
        .map((rows) => rows.map(_waterRowToModel).toList());
  }

  @override
  Future<void> logWater(WaterLogModel log) async {
    await _db.into(_db.waterLogs).insertOnConflictUpdate(
          WaterLogsCompanion(
            id: Value(log.id),
            userId: Value(log.userId),
            logDate: Value(log.logDate),
            logTime: Value(log.logTime),
            amountMl: Value(log.amountMl),
            containerType: Value(log.containerType),
            createdAt: Value(log.createdAt),
            syncStatus: const Value(0),
          ),
        );
  }

  @override
  Future<StepLogModel?> getTodaySteps(String userId) async {
    final start = _dayStart(DateTime.now());
    final row = await (_db.select(_db.dailyStepLogs)
          ..where((s) => s.userId.equals(userId) & s.logDate.equals(start)))
        .getSingleOrNull();
    return row == null ? null : _stepRowToModel(row);
  }

  @override
  Future<StepLogModel?> getYesterdaySteps(String userId) async {
    final start = _dayStart(DateTime.now().subtract(const Duration(days: 1)));
    final row = await (_db.select(_db.dailyStepLogs)
          ..where((s) => s.userId.equals(userId) & s.logDate.equals(start)))
        .getSingleOrNull();
    return row == null ? null : _stepRowToModel(row);
  }

  @override
  Future<void> logSteps(StepLogModel log) async {
    await _db.into(_db.dailyStepLogs).insertOnConflictUpdate(
          DailyStepLogsCompanion(
            id: Value(log.id),
            userId: Value(log.userId),
            logDate: Value(_dayStart(log.logDate)),
            stepCount: Value(log.stepCount),
            distanceM: Value(log.distanceM),
            calories: Value(log.calories),
            source: Value(log.source),
            updatedAt: Value(log.updatedAt),
          ),
        );
  }

  @override
  Future<void> logWorkout(WorkoutLogModel workout) async {
    await _db.into(_db.workoutLogs).insertOnConflictUpdate(
          WorkoutLogsCompanion(
            id: Value(workout.id),
            userId: Value(workout.userId),
            workoutType: Value(workout.workoutType),
            name: Value(workout.name),
            startedAt: Value(workout.startedAt),
            endedAt: Value(workout.endedAt),
            durationMin: Value(workout.durationMin),
            distanceM: Value(workout.distanceM),
            calories: Value(workout.calories),
            avgHeartRate: Value(workout.avgHeartRate),
            source: Value(workout.source),
            note: Value(workout.note),
            createdAt: Value(workout.createdAt),
            updatedAt: Value(workout.updatedAt),
            syncStatus: const Value(0),
          ),
        );
    for (final s in workout.sets) {
      await _db.into(_db.workoutSets).insertOnConflictUpdate(
            WorkoutSetsCompanion(
              id: Value(s.id),
              workoutId: Value(workout.id),
              exerciseName: Value(s.exerciseName),
              setNumber: Value(s.setNumber),
              reps: Value(s.reps),
              weightKg: Value(s.weightKg),
              durationSec: Value(s.durationSec),
              note: Value(s.note),
            ),
          );
    }
  }

  @override
  Stream<List<WorkoutLogModel>> watchRecentWorkouts(String userId, {int days = 14}) {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return (_db.select(_db.workoutLogs)
          ..where((w) => w.userId.equals(userId) & w.startedAt.isBiggerOrEqualValue(cutoff))
          ..orderBy([(w) => OrderingTerm.desc(w.startedAt)]))
        .watch()
        .asyncMap((rows) async {
      final result = <WorkoutLogModel>[];
      for (final row in rows) {
        final sets = await (_db.select(_db.workoutSets)
              ..where((s) => s.workoutId.equals(row.id))
              ..orderBy([(s) => OrderingTerm.asc(s.setNumber)]))
            .get();
        result.add(_workoutRowToModel(row, sets));
      }
      return result;
    });
  }

  @override
  Future<void> logBreathingSession(BreathingSessionModel session) async {
    await _db.into(_db.breathingSessions).insertOnConflictUpdate(
          BreathingSessionsCompanion(
            id: Value(session.id),
            userId: Value(session.userId),
            technique: Value(session.technique),
            durationMin: Value(session.durationMin),
            cyclesCompleted: Value(session.cyclesCompleted),
            moodBefore: Value(session.moodBefore),
            moodAfter: Value(session.moodAfter),
            completed: Value(session.completed),
            startedAt: Value(session.startedAt),
            endedAt: Value(session.endedAt),
            createdAt: Value(session.createdAt),
          ),
        );
  }

  @override
  Stream<List<BreathingSessionModel>> watchRecentBreathingSessions(String userId, {int days = 14}) {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return (_db.select(_db.breathingSessions)
          ..where((b) => b.userId.equals(userId) & b.startedAt.isBiggerOrEqualValue(cutoff))
          ..orderBy([(b) => OrderingTerm.desc(b.startedAt)]))
        .watch()
        .map((rows) => rows.map(_breathingRowToModel).toList());
  }
}
