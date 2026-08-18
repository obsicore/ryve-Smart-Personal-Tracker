import 'package:drift/drift.dart';

class RecurringConfigs extends Table {
  TextColumn get id => text()();
  TextColumn get frequency => text()();
  TextColumn get daysOfWeek => text().nullable()();
  IntColumn get interval => integer().withDefault(const Constant(1))();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  IntColumn get priority => integer().withDefault(const Constant(2))();
  BoolColumn get isUrgent => boolean().withDefault(const Constant(false))();
  BoolColumn get isImportant => boolean().withDefault(const Constant(true))();
  DateTimeColumn get dueDate => dateTime().nullable()();
  DateTimeColumn get dueTime => dateTime().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get recurringConfigId => text().nullable()();
  IntColumn get estimatedMinutes => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class Tags extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get name => text()();
  TextColumn get color => text().withDefault(const Constant('#C9A84C'))();

  @override
  Set<Column> get primaryKey => {id};
}

class TaskTags extends Table {
  TextColumn get taskId => text().references(Tasks, #id)();
  TextColumn get tagId => text().references(Tags, #id)();

  @override
  Set<Column> get primaryKey => {taskId, tagId};
}

class TimeBlocks extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get title => text()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
  TextColumn get taskId => text().nullable()();
  BoolColumn get isFocusBlock => boolean().withDefault(const Constant(false))();
  TextColumn get color => text().nullable()();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class TaskTemplates extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  IntColumn get priority => integer().withDefault(const Constant(2))();

  @override
  Set<Column> get primaryKey => {id};
}

class TaskTemplateItems extends Table {
  TextColumn get id => text()();
  TextColumn get templateId => text().references(TaskTemplates, #id)();
  TextColumn get title => text()();
  IntColumn get order => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class Subtasks extends Table {
  TextColumn get id => text()();
  TextColumn get taskId => text().references(Tasks, #id)();
  TextColumn get title => text()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  IntColumn get order => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
