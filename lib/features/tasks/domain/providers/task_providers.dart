import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hybrid_tracker/main.dart' show databaseProvider;
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/tasks/data/models/task_model.dart';
import 'package:hybrid_tracker/features/tasks/data/repositories/task_repository.dart';

part 'task_providers.g.dart';

// ---------------------------------------------------------------------------
// Repository provider
// ---------------------------------------------------------------------------
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return TaskRepositoryImpl(db);
});

// ---------------------------------------------------------------------------
// Stream providers
// ---------------------------------------------------------------------------
@riverpod
Stream<List<TaskModel>> allTasks(AllTasksRef ref) {
  final authState = ref.watch(authStateProvider);
  final userId = authState.valueOrNull?.uid ?? '';
  return ref.watch(taskRepositoryProvider).watchAllTasks(userId);
}

@riverpod
Stream<List<TaskModel>> todayTasks(TodayTasksRef ref) {
  final authState = ref.watch(authStateProvider);
  final userId = authState.valueOrNull?.uid ?? '';
  return ref.watch(taskRepositoryProvider).watchTodayTasks(userId);
}

// Derived streams — filter from allTasks
@riverpod
Stream<List<TaskModel>> upcomingTasks(UpcomingTasksRef ref) {
  return ref.watch(allTasksProvider.stream).map(
        (tasks) {
          final now = DateTime.now();
          final startOfTomorrow = DateTime(now.year, now.month, now.day + 1);
          return tasks
              .where(
                (t) =>
                    !t.isCompleted &&
                    t.dueDate != null &&
                    t.dueDate!.isAfter(startOfTomorrow),
              )
              .toList();
        },
      );
}

@riverpod
Stream<List<TaskModel>> highPriorityTasks(HighPriorityTasksRef ref) {
  return ref.watch(allTasksProvider.stream).map(
        (tasks) => tasks
            .where(
              (t) =>
                  !t.isCompleted &&
                  (t.priority == TaskPriority.high ||
                      t.priority == TaskPriority.urgent),
            )
            .toList(),
      );
}

// Single task by ID
@riverpod
Future<TaskModel?> taskById(TaskByIdRef ref, String id) {
  return ref.watch(taskRepositoryProvider).getTask(id);
}

// ---------------------------------------------------------------------------
// CRUD notifier
// ---------------------------------------------------------------------------
@riverpod
class TaskNotifier extends _$TaskNotifier {
  @override
  Future<void> build() async {}

  Future<void> createTask(TaskModel task) =>
      ref.read(taskRepositoryProvider).createTask(task);

  Future<void> updateTask(TaskModel task) =>
      ref.read(taskRepositoryProvider).updateTask(task);

  Future<void> completeTask(String id) =>
      ref.read(taskRepositoryProvider).completeTask(id);

  Future<void> deleteTask(String id) =>
      ref.read(taskRepositoryProvider).deleteTask(id);

  Future<void> createSubtask(SubtaskModel subtask) =>
      ref.read(taskRepositoryProvider).createSubtask(subtask);

  Future<void> toggleSubtask(String subtaskId) =>
      ref.read(taskRepositoryProvider).toggleSubtask(subtaskId);
}
