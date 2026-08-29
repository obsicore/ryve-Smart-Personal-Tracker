import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hybrid_tracker/main.dart' show databaseProvider;
import 'package:hybrid_tracker/core/services/notification_service.dart';
import 'package:hybrid_tracker/core/services/xp_service.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/tasks/data/models/task_model.dart';
import 'package:hybrid_tracker/features/tasks/data/repositories/task_repository.dart';
import 'package:hybrid_tracker/features/goals/domain/providers/goals_providers.dart' show goalsRepositoryProvider;

part 'task_providers.g.dart';

DateTime? taskReminderFireTime(TaskModel task) {
  final due = task.dueDate;
  final minutesBefore = task.reminderMinutesBefore;
  if (due == null || minutesBefore == null) return null;
  return due.subtract(Duration(minutes: minutesBefore));
}

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

  // Scheduling a reminder must not block/roll back a task save — the task
  // row is the source of truth, the OS-level schedule is best-effort.
  Future<void> _scheduleReminderOrIgnore(TaskModel task) async {
    try {
      await NotificationService.instance
          .scheduleTaskReminder(task.id, task.title, taskReminderFireTime(task));
    } catch (_) {
      // Task is saved; only the OS notification failed to schedule.
    }
  }

  Future<void> createTask(TaskModel task) async {
    await ref.read(taskRepositoryProvider).createTask(task);
    await _scheduleReminderOrIgnore(task);
  }

  Future<void> updateTask(TaskModel task) async {
    await ref.read(taskRepositoryProvider).updateTask(task);
    await _scheduleReminderOrIgnore(task);
  }

  Future<void> completeTask(String id) async {
    await ref.read(taskRepositoryProvider).completeTask(id);
    await NotificationService.instance.cancelTaskReminder(id);
    await ref.read(xpServiceProvider).award(XPEvent.taskComplete, entityId: id);
    await ref.read(goalsRepositoryProvider).incrementLinkedGoalsForTask(id);
  }

  Future<void> deleteTask(String id) async {
    await ref.read(taskRepositoryProvider).deleteTask(id);
    await NotificationService.instance.cancelTaskReminder(id);
  }

  Future<void> createSubtask(SubtaskModel subtask) =>
      ref.read(taskRepositoryProvider).createSubtask(subtask);

  Future<void> toggleSubtask(String subtaskId) =>
      ref.read(taskRepositoryProvider).toggleSubtask(subtaskId);
}
