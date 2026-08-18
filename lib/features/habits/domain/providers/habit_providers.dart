import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/main.dart' show databaseProvider;
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/goals/domain/providers/goals_providers.dart';
import 'package:hybrid_tracker/features/habits/data/models/habit_model.dart';
import 'package:hybrid_tracker/features/habits/data/repositories/habit_repository.dart';

part 'habit_providers.g.dart';

// ---------------------------------------------------------------------------
// Repository provider
// ---------------------------------------------------------------------------
final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return HabitRepositoryImpl(db);
});

// ---------------------------------------------------------------------------
// Stream — all active habits for the current user
// ---------------------------------------------------------------------------
@riverpod
Stream<List<HabitModel>> allHabits(Ref ref) {
  final userId = ref.watch(authStateProvider).valueOrNull?.uid ?? '';
  return ref.watch(habitRepositoryProvider).watchHabits(userId);
}

// ---------------------------------------------------------------------------
// Single habit by ID
// ---------------------------------------------------------------------------
@riverpod
Future<HabitModel?> habitById(Ref ref, String id) {
  return ref.watch(habitRepositoryProvider).getHabit(id);
}

// ---------------------------------------------------------------------------
// Logs for a habit (last 30 days by default)
// ---------------------------------------------------------------------------
@riverpod
Future<List<HabitLogModel>> habitLogs(Ref ref, String habitId) {
  return ref.watch(habitRepositoryProvider).getLogsForHabit(habitId, days: 30);
}

// ---------------------------------------------------------------------------
// CRUD notifier
// ---------------------------------------------------------------------------
@riverpod
class HabitNotifier extends _$HabitNotifier {
  @override
  Future<void> build() async {}

  Future<void> createHabit(HabitModel habit) =>
      ref.read(habitRepositoryProvider).createHabit(habit);

  Future<void> updateHabit(HabitModel habit) =>
      ref.read(habitRepositoryProvider).updateHabit(habit);

  Future<void> deleteHabit(String habitId) =>
      ref.read(habitRepositoryProvider).deleteHabit(habitId);

  Future<void> logHabit(
    String habitId, {
    double value = 1.0,
    int? moodAfter,
    String? notes,
  }) async {
    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    final log = HabitLogModel(
      id: const Uuid().v4(),
      habitId: habitId,
      logDate: DateTime.now(),
      value: value,
      moodAfter: moodAfter,
      notes: notes,
      userId: userId,
    );
    await ref.read(habitRepositoryProvider).logHabit(log);
    await ref.read(goalsRepositoryProvider).incrementLinkedGoals(habitId, amount: value);
  }
}
