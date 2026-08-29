import 'package:drift/drift.dart';
import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/features/tasks/data/models/task_model.dart';

// ---------------------------------------------------------------------------
// Abstract interface
// ---------------------------------------------------------------------------
abstract class TaskRepository {
  Stream<List<TaskModel>> watchAllTasks(String userId);
  Stream<List<TaskModel>> watchTodayTasks(String userId);
  Future<TaskModel?> getTask(String id);
  Future<void> createTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
  Future<void> completeTask(String id);
  Future<void> createSubtask(SubtaskModel subtask);
  Future<void> toggleSubtask(String subtaskId);
}

// ---------------------------------------------------------------------------
// Drift implementation
// ---------------------------------------------------------------------------
class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl(this._db);

  final AppDatabase _db;

  // -------------------------------------------------------------------------
  // Priority helpers
  // -------------------------------------------------------------------------
  static TaskPriority _priorityFromInt(int v) {
    switch (v) {
      case 0:
        return TaskPriority.low;
      case 1:
        return TaskPriority.medium;
      case 3:
        return TaskPriority.urgent;
      case 2:
      default:
        return TaskPriority.high;
    }
  }

  static int _priorityToInt(TaskPriority p) {
    switch (p) {
      case TaskPriority.low:
        return 0;
      case TaskPriority.medium:
        return 1;
      case TaskPriority.high:
        return 2;
      case TaskPriority.urgent:
        return 3;
    }
  }

  // -------------------------------------------------------------------------
  // Row → model helpers
  // -------------------------------------------------------------------------
  SubtaskModel _subtaskFromRow(Subtask row) => SubtaskModel(
        id: row.id,
        taskId: row.taskId,
        title: row.title,
        isCompleted: row.isCompleted,
        order: row.order,
      );

  Future<TaskModel> _taskFromRow(Task row) async {
    final subtaskRows = await (_db.select(_db.subtasks)
          ..where((s) => s.taskId.equals(row.id))
          ..orderBy([(s) => OrderingTerm.asc(s.order)]))
        .get();

    final taskTagRows = await (_db.select(_db.taskTags)
          ..where((tt) => tt.taskId.equals(row.id)))
        .get();

    return TaskModel(
      id: row.id,
      userId: row.userId,
      title: row.title,
      description: row.description,
      priority: _priorityFromInt(row.priority),
      isUrgent: row.isUrgent,
      isImportant: row.isImportant,
      dueDate: row.dueDate,
      reminderMinutesBefore: row.reminderMinutesBefore,
      isCompleted: row.isCompleted,
      completedAt: row.completedAt,
      subtasks: subtaskRows.map(_subtaskFromRow).toList(),
      tagIds: taskTagRows.map((tt) => tt.tagId).toList(),
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  // -------------------------------------------------------------------------
  // Streams
  // -------------------------------------------------------------------------
  @override
  Stream<List<TaskModel>> watchAllTasks(String userId) {
    return (_db.select(_db.tasks)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([
            (t) => OrderingTerm.desc(t.createdAt),
          ]))
        .watch()
        .asyncMap((rows) => Future.wait(rows.map(_taskFromRow)));
  }

  @override
  Stream<List<TaskModel>> watchTodayTasks(String userId) {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (_db.select(_db.tasks)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.dueDate.isBiggerOrEqualValue(startOfDay) &
                t.dueDate.isSmallerThanValue(endOfDay),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.dueDate)]))
        .watch()
        .asyncMap((rows) => Future.wait(rows.map(_taskFromRow)));
  }

  // -------------------------------------------------------------------------
  // Single task fetch
  // -------------------------------------------------------------------------
  @override
  Future<TaskModel?> getTask(String id) async {
    final row = await (_db.select(_db.tasks)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return null;
    return _taskFromRow(row);
  }

  // -------------------------------------------------------------------------
  // Create
  // -------------------------------------------------------------------------
  @override
  Future<void> createTask(TaskModel task) async {
    await _db.into(_db.tasks).insertOnConflictUpdate(
          TasksCompanion(
            id: Value(task.id),
            userId: Value(task.userId),
            title: Value(task.title),
            description: Value(task.description),
            priority: Value(_priorityToInt(task.priority)),
            isUrgent: Value(task.isUrgent),
            isImportant: Value(task.isImportant),
            dueDate: Value(task.dueDate),
            reminderMinutesBefore: Value(task.reminderMinutesBefore),
            isCompleted: Value(task.isCompleted),
            completedAt: Value(task.completedAt),
            createdAt: Value(task.createdAt),
            updatedAt: Value(task.updatedAt),
            syncStatus: const Value(0),
          ),
        );

    for (final subtask in task.subtasks) {
      await createSubtask(subtask);
    }
  }

  // -------------------------------------------------------------------------
  // Update
  // -------------------------------------------------------------------------
  @override
  Future<void> updateTask(TaskModel task) async {
    await (_db.update(_db.tasks)..where((t) => t.id.equals(task.id))).write(
      TasksCompanion(
        title: Value(task.title),
        description: Value(task.description),
        priority: Value(_priorityToInt(task.priority)),
        isUrgent: Value(task.isUrgent),
        isImportant: Value(task.isImportant),
        dueDate: Value(task.dueDate),
        reminderMinutesBefore: Value(task.reminderMinutesBefore),
        isCompleted: Value(task.isCompleted),
        completedAt: Value(task.completedAt),
        updatedAt: Value(DateTime.now()),
        syncStatus: const Value(0),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Delete
  // -------------------------------------------------------------------------
  @override
  Future<void> deleteTask(String id) async {
    await (_db.delete(_db.subtasks)..where((s) => s.taskId.equals(id))).go();
    await (_db.delete(_db.taskTags)..where((tt) => tt.taskId.equals(id))).go();
    await (_db.delete(_db.goalTaskLinks)..where((l) => l.taskId.equals(id))).go();
    await (_db.delete(_db.tasks)..where((t) => t.id.equals(id))).go();
  }

  // -------------------------------------------------------------------------
  // Complete
  // -------------------------------------------------------------------------
  @override
  Future<void> completeTask(String id) async {
    await (_db.update(_db.tasks)..where((t) => t.id.equals(id))).write(
      TasksCompanion(
        isCompleted: const Value(true),
        completedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        syncStatus: const Value(0),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Subtask CRUD
  // -------------------------------------------------------------------------
  @override
  Future<void> createSubtask(SubtaskModel subtask) async {
    await _db.into(_db.subtasks).insertOnConflictUpdate(
          SubtasksCompanion(
            id: Value(subtask.id),
            taskId: Value(subtask.taskId),
            title: Value(subtask.title),
            isCompleted: Value(subtask.isCompleted),
            order: Value(subtask.order),
          ),
        );
  }

  @override
  Future<void> toggleSubtask(String subtaskId) async {
    final row = await (_db.select(_db.subtasks)
          ..where((s) => s.id.equals(subtaskId)))
        .getSingleOrNull();
    if (row == null) return;
    await (_db.update(_db.subtasks)..where((s) => s.id.equals(subtaskId)))
        .write(SubtasksCompanion(isCompleted: Value(!row.isCompleted)));
  }
}
