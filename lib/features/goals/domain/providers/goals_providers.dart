import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/main.dart' show databaseProvider;
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/goals/data/models/goal_model.dart';
import 'package:hybrid_tracker/features/goals/data/models/life_area_score_model.dart';
import 'package:hybrid_tracker/features/goals/data/models/weekly_report_model.dart';
import 'package:hybrid_tracker/features/goals/data/repositories/goals_repository.dart';

part 'goals_providers.g.dart';

const _uuid = Uuid();
String get newGoalId => _uuid.v4();
String get newMilestoneId => _uuid.v4();

final goalsRepositoryProvider = Provider<GoalsRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return GoalsRepositoryImpl(db);
});

String _uid(Ref ref) => ref.watch(authStateProvider).valueOrNull?.uid ?? '';

@riverpod
Stream<List<GoalModel>> allGoals(Ref ref) {
  return ref.watch(goalsRepositoryProvider).watchGoals(_uid(ref));
}

@riverpod
Stream<List<GoalModel>> goalsByLifeArea(Ref ref, String lifeArea) {
  return ref.watch(goalsRepositoryProvider).watchGoals(_uid(ref), lifeArea: lifeArea);
}

@riverpod
Future<GoalModel?> goalById(Ref ref, String id) {
  return ref.watch(goalsRepositoryProvider).getGoal(id);
}

@riverpod
Future<LifeAreaScoreModel?> latestLifeAreaScore(Ref ref) {
  return ref.watch(goalsRepositoryProvider).getLatestLifeAreaScore(_uid(ref));
}

@riverpod
Future<WeeklyReportModel?> latestWeeklyReport(Ref ref) {
  return ref.watch(goalsRepositoryProvider).getLatestWeeklyReport(_uid(ref));
}

@riverpod
class GoalNotifier extends _$GoalNotifier {
  @override
  Future<void> build() async {}

  Future<void> createGoal(GoalModel goal) =>
      ref.read(goalsRepositoryProvider).createGoal(goal);

  Future<void> updateGoal(GoalModel goal) =>
      ref.read(goalsRepositoryProvider).updateGoal(goal);

  Future<void> deleteGoal(String id) =>
      ref.read(goalsRepositoryProvider).deleteGoal(id);

  Future<void> updateProgress(String goalId, double value) =>
      ref.read(goalsRepositoryProvider).updateProgress(goalId, value);

  Future<void> toggleMilestone(String milestoneId, bool isComplete) =>
      ref.read(goalsRepositoryProvider).toggleMilestone(milestoneId, isComplete);

  Future<void> generateWeeklyReport(DateTime weekStart) async {
    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    await ref.read(goalsRepositoryProvider).generateWeeklyReport(userId, weekStart);
  }

  Future<void> saveLifeAreaScore(LifeAreaScoreModel score) =>
      ref.read(goalsRepositoryProvider).saveLifeAreaScore(score);
}
