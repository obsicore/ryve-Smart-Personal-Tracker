import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/features/goals/data/models/goal_model.dart';
import 'package:hybrid_tracker/features/goals/data/models/life_area_score_model.dart';
import 'package:hybrid_tracker/features/goals/data/models/milestone_model.dart';
import 'package:hybrid_tracker/features/goals/data/models/weekly_report_model.dart';

const _uuid = Uuid();

abstract class GoalsRepository {
  Stream<List<GoalModel>> watchGoals(String userId, {String? lifeArea});
  Future<GoalModel?> getGoal(String id);
  Future<void> createGoal(GoalModel goal);
  Future<void> updateGoal(GoalModel goal);
  Future<void> deleteGoal(String id);
  Future<void> updateProgress(String goalId, double currentValue);
  Future<void> toggleMilestone(String milestoneId, bool isComplete);
  Future<void> linkHabit(String goalId, String habitId);
  Future<void> linkTask(String goalId, String taskId);
  Future<void> incrementLinkedGoals(String habitId, {double amount = 1});

  Future<LifeAreaScoreModel?> getLatestLifeAreaScore(String userId);
  Future<void> saveLifeAreaScore(LifeAreaScoreModel score);

  Future<WeeklyReportModel?> getLatestWeeklyReport(String userId);
  Future<WeeklyReportModel> generateWeeklyReport(String userId, DateTime weekStart);
}

class GoalsRepositoryImpl implements GoalsRepository {
  GoalsRepositoryImpl(this._db);

  final AppDatabase _db;

  Future<List<MilestoneModel>> _milestonesFor(String goalId) async {
    final rows = await (_db.select(_db.milestones)
          ..where((m) => m.goalId.equals(goalId))
          ..orderBy([(m) => OrderingTerm.asc(m.sortOrder)]))
        .get();
    return rows
        .map((r) => MilestoneModel(
              id: r.id,
              goalId: r.goalId,
              title: r.title,
              targetValue: r.targetValue,
              sortOrder: r.sortOrder,
              isComplete: r.isComplete,
              completedAt: r.completedAt,
              createdAt: r.createdAt,
            ))
        .toList();
  }

  Future<GoalModel> _goalRowToModel(Goal row) async {
    final milestones = await _milestonesFor(row.id);
    final habitLinks = await (_db.select(_db.goalHabitLinks)
          ..where((l) => l.goalId.equals(row.id)))
        .get();
    final taskLinks = await (_db.select(_db.goalTaskLinks)
          ..where((l) => l.goalId.equals(row.id)))
        .get();
    return GoalModel(
      id: row.id,
      userId: row.userId,
      title: row.title,
      description: row.description,
      lifeArea: row.lifeArea,
      metricType: row.metricType,
      targetValue: row.targetValue,
      currentValue: row.currentValue,
      unit: row.unit,
      targetDate: row.targetDate,
      priority: row.priority,
      status: row.status,
      icon: row.icon,
      colorHex: row.colorHex,
      visibility: row.visibility,
      completedAt: row.completedAt,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      deletedAt: row.deletedAt,
      syncStatus: row.syncStatus,
      milestones: milestones,
      linkedHabitIds: habitLinks.map((l) => l.habitId).toList(),
      linkedTaskIds: taskLinks.map((l) => l.taskId).toList(),
    );
  }

  @override
  Stream<List<GoalModel>> watchGoals(String userId, {String? lifeArea}) {
    final query = _db.select(_db.goals)
      ..where((g) => g.userId.equals(userId) & g.deletedAt.isNull());
    if (lifeArea != null) {
      query.where((g) => g.lifeArea.equals(lifeArea));
    }
    query.orderBy([(g) => OrderingTerm.desc(g.createdAt)]);
    return query.watch().asyncMap((rows) async {
      final result = <GoalModel>[];
      for (final row in rows) {
        result.add(await _goalRowToModel(row));
      }
      return result;
    });
  }

  @override
  Future<GoalModel?> getGoal(String id) async {
    final row = await (_db.select(_db.goals)..where((g) => g.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return null;
    return _goalRowToModel(row);
  }

  @override
  Future<void> createGoal(GoalModel goal) async {
    await _db.into(_db.goals).insertOnConflictUpdate(
          GoalsCompanion(
            id: Value(goal.id),
            userId: Value(goal.userId),
            title: Value(goal.title),
            description: Value(goal.description),
            lifeArea: Value(goal.lifeArea),
            metricType: Value(goal.metricType),
            targetValue: Value(goal.targetValue),
            currentValue: Value(goal.currentValue),
            unit: Value(goal.unit),
            targetDate: Value(goal.targetDate),
            priority: Value(goal.priority),
            status: Value(goal.status),
            icon: Value(goal.icon),
            colorHex: Value(goal.colorHex),
            visibility: Value(goal.visibility),
            createdAt: Value(goal.createdAt),
            updatedAt: Value(goal.updatedAt),
            syncStatus: const Value(0),
          ),
        );
    for (final m in goal.milestones) {
      await _db.into(_db.milestones).insertOnConflictUpdate(
            MilestonesCompanion(
              id: Value(m.id),
              goalId: Value(goal.id),
              title: Value(m.title),
              targetValue: Value(m.targetValue),
              sortOrder: Value(m.sortOrder),
              createdAt: Value(m.createdAt),
            ),
          );
    }
    for (final habitId in goal.linkedHabitIds) {
      await linkHabit(goal.id, habitId);
    }
    for (final taskId in goal.linkedTaskIds) {
      await linkTask(goal.id, taskId);
    }
  }

  @override
  Future<void> updateGoal(GoalModel goal) async {
    await (_db.update(_db.goals)..where((g) => g.id.equals(goal.id))).write(
      GoalsCompanion(
        title: Value(goal.title),
        description: Value(goal.description),
        lifeArea: Value(goal.lifeArea),
        metricType: Value(goal.metricType),
        targetValue: Value(goal.targetValue),
        currentValue: Value(goal.currentValue),
        unit: Value(goal.unit),
        targetDate: Value(goal.targetDate),
        priority: Value(goal.priority),
        status: Value(goal.status),
        icon: Value(goal.icon),
        colorHex: Value(goal.colorHex),
        visibility: Value(goal.visibility),
        completedAt: Value(goal.completedAt),
        updatedAt: Value(DateTime.now()),
        syncStatus: const Value(0),
      ),
    );
  }

  @override
  Future<void> deleteGoal(String id) async {
    await (_db.update(_db.goals)..where((g) => g.id.equals(id)))
        .write(GoalsCompanion(deletedAt: Value(DateTime.now())));
  }

  @override
  Future<void> updateProgress(String goalId, double currentValue) async {
    final row = await (_db.select(_db.goals)..where((g) => g.id.equals(goalId)))
        .getSingleOrNull();
    if (row == null) return;
    final clamped = currentValue.clamp(0, row.targetValue).toDouble();
    final isDone = clamped >= row.targetValue;
    await (_db.update(_db.goals)..where((g) => g.id.equals(goalId))).write(
      GoalsCompanion(
        currentValue: Value(clamped),
        status: Value(isDone ? 'completed' : row.status),
        completedAt: Value(isDone ? DateTime.now() : row.completedAt),
        updatedAt: Value(DateTime.now()),
        syncStatus: const Value(0),
      ),
    );
  }

  @override
  Future<void> toggleMilestone(String milestoneId, bool isComplete) async {
    await (_db.update(_db.milestones)..where((m) => m.id.equals(milestoneId))).write(
      MilestonesCompanion(
        isComplete: Value(isComplete),
        completedAt: Value(isComplete ? DateTime.now() : null),
      ),
    );
    final milestone = await (_db.select(_db.milestones)
          ..where((m) => m.id.equals(milestoneId)))
        .getSingleOrNull();
    if (milestone == null) return;
    final completedCount = await (_db.select(_db.milestones)
          ..where((m) => m.goalId.equals(milestone.goalId) & m.isComplete.equals(true)))
        .get();
    final total = await (_db.select(_db.milestones)
          ..where((m) => m.goalId.equals(milestone.goalId)))
        .get();
    if (total.isNotEmpty) {
      final goal = await (_db.select(_db.goals)..where((g) => g.id.equals(milestone.goalId)))
          .getSingleOrNull();
      if (goal != null && goal.metricType == 'numeric' && goal.targetValue > 0) {
        final ratio = completedCount.length / total.length;
        await updateProgress(milestone.goalId, goal.targetValue * ratio);
      }
    }
  }

  @override
  Future<void> linkHabit(String goalId, String habitId) async {
    await _db.into(_db.goalHabitLinks).insertOnConflictUpdate(
          GoalHabitLinksCompanion(
            goalId: Value(goalId),
            habitId: Value(habitId),
            createdAt: Value(DateTime.now()),
          ),
        );
  }

  @override
  Future<void> linkTask(String goalId, String taskId) async {
    await _db.into(_db.goalTaskLinks).insertOnConflictUpdate(
          GoalTaskLinksCompanion(
            goalId: Value(goalId),
            taskId: Value(taskId),
            createdAt: Value(DateTime.now()),
          ),
        );
  }

  @override
  Future<void> incrementLinkedGoals(String habitId, {double amount = 1}) async {
    final links = await (_db.select(_db.goalHabitLinks)
          ..where((l) => l.habitId.equals(habitId)))
        .get();
    for (final link in links) {
      final goal = await (_db.select(_db.goals)..where((g) => g.id.equals(link.goalId)))
          .getSingleOrNull();
      if (goal == null || goal.status != 'active') continue;
      await updateProgress(goal.id, goal.currentValue + amount);
    }
  }

  @override
  Future<LifeAreaScoreModel?> getLatestLifeAreaScore(String userId) async {
    final row = await (_db.select(_db.lifeAreaScores)
          ..where((s) => s.userId.equals(userId))
          ..orderBy([(s) => OrderingTerm.desc(s.scoredAt)])
          ..limit(1))
        .getSingleOrNull();
    if (row == null) return null;
    return LifeAreaScoreModel(
      id: row.id,
      userId: row.userId,
      scoredAt: row.scoredAt,
      health: row.health,
      work: row.work,
      finance: row.finance,
      relationships: row.relationships,
      personalGrowth: row.personalGrowth,
      learning: row.learning,
      recreation: row.recreation,
      createdAt: row.createdAt,
    );
  }

  @override
  Future<void> saveLifeAreaScore(LifeAreaScoreModel score) async {
    await _db.into(_db.lifeAreaScores).insertOnConflictUpdate(
          LifeAreaScoresCompanion(
            id: Value(score.id),
            userId: Value(score.userId),
            scoredAt: Value(score.scoredAt),
            health: Value(score.health),
            work: Value(score.work),
            finance: Value(score.finance),
            relationships: Value(score.relationships),
            personalGrowth: Value(score.personalGrowth),
            learning: Value(score.learning),
            recreation: Value(score.recreation),
            createdAt: Value(score.createdAt),
          ),
        );
  }

  @override
  Future<WeeklyReportModel?> getLatestWeeklyReport(String userId) async {
    final row = await (_db.select(_db.weeklyReports)
          ..where((r) => r.userId.equals(userId))
          ..orderBy([(r) => OrderingTerm.desc(r.weekStart)])
          ..limit(1))
        .getSingleOrNull();
    if (row == null) return null;
    return WeeklyReportModel(
      id: row.id,
      userId: row.userId,
      weekStart: row.weekStart,
      weekEnd: row.weekEnd,
      habitsCompleted: row.habitsCompleted,
      habitsTotal: row.habitsTotal,
      tasksCompleted: row.tasksCompleted,
      focusMinutes: row.focusMinutes,
      avgMood: row.avgMood,
      avgSleepHours: row.avgSleepHours,
      xpEarned: row.xpEarned,
      aiSummary: row.aiSummary,
      aiWins: row.aiWins,
      aiSuggestions: row.aiSuggestions,
      generatedAt: row.generatedAt,
      createdAt: row.createdAt,
    );
  }

  @override
  Future<WeeklyReportModel> generateWeeklyReport(String userId, DateTime weekStart) async {
    final weekEnd = weekStart.add(const Duration(days: 7));

    final habitLogs = await (_db.select(_db.habitLogs)
          ..where((l) =>
              l.userId.equals(userId) &
              l.logDate.isBiggerOrEqualValue(weekStart) &
              l.logDate.isSmallerThanValue(weekEnd)))
        .get();
    final activeHabits = await (_db.select(_db.habits)
          ..where((h) => h.userId.equals(userId) & h.isActive.equals(true)))
        .get();

    final completedTasks = await (_db.select(_db.tasks)
          ..where((t) =>
              t.userId.equals(userId) &
              t.isCompleted.equals(true) &
              t.completedAt.isBiggerOrEqualValue(weekStart) &
              t.completedAt.isSmallerThanValue(weekEnd)))
        .get();

    final focusSessions = await (_db.select(_db.focusSessions)
          ..where((f) =>
              f.userId.equals(userId) &
              f.sessionType.equals('work') &
              f.startedAt.isBiggerOrEqualValue(weekStart) &
              f.startedAt.isSmallerThanValue(weekEnd)))
        .get();
    final focusMinutes = focusSessions.fold<int>(0, (sum, f) => sum + f.durationMinutes);

    final moodLogs = await (_db.select(_db.moodLogs)
          ..where((m) =>
              m.userId.equals(userId) &
              m.logDate.isBiggerOrEqualValue(weekStart) &
              m.logDate.isSmallerThanValue(weekEnd)))
        .get();
    final avgMood = moodLogs.isEmpty
        ? 0.0
        : moodLogs.map((m) => m.moodScore).reduce((a, b) => a + b) / moodLogs.length;

    final sleepLogs = await (_db.select(_db.sleepLogs)
          ..where((s) =>
              s.userId.equals(userId) &
              s.createdAt.isBiggerOrEqualValue(weekStart) &
              s.createdAt.isSmallerThanValue(weekEnd)))
        .get();
    final avgSleep = sleepLogs.isEmpty
        ? 0.0
        : sleepLogs
                .map((s) => s.wakeTime.difference(s.bedtime).inMinutes / 60.0)
                .reduce((a, b) => a + b) /
            sleepLogs.length;

    final xpEvents = await (_db.select(_db.xpEvents)
          ..where((x) =>
              x.userId.equals(userId) &
              x.createdAt.isBiggerOrEqualValue(weekStart) &
              x.createdAt.isSmallerThanValue(weekEnd)))
        .get();
    final xpEarned = xpEvents.fold<int>(0, (sum, x) => sum + x.xpAmount);

    final report = WeeklyReportModel(
      id: _uuid.v4(),
      userId: userId,
      weekStart: weekStart,
      weekEnd: weekEnd,
      habitsCompleted: habitLogs.map((l) => l.habitId).toSet().length,
      habitsTotal: activeHabits.length,
      tasksCompleted: completedTasks.length,
      focusMinutes: focusMinutes,
      avgMood: avgMood,
      avgSleepHours: avgSleep,
      xpEarned: xpEarned,
      generatedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );

    await _db.into(_db.weeklyReports).insertOnConflictUpdate(
          WeeklyReportsCompanion(
            id: Value(report.id),
            userId: Value(report.userId),
            weekStart: Value(report.weekStart),
            weekEnd: Value(report.weekEnd),
            habitsCompleted: Value(report.habitsCompleted),
            habitsTotal: Value(report.habitsTotal),
            tasksCompleted: Value(report.tasksCompleted),
            focusMinutes: Value(report.focusMinutes),
            avgMood: Value(report.avgMood),
            avgSleepHours: Value(report.avgSleepHours),
            xpEarned: Value(report.xpEarned),
            generatedAt: Value(report.generatedAt),
            createdAt: Value(report.createdAt),
          ),
        );

    return report;
  }
}
