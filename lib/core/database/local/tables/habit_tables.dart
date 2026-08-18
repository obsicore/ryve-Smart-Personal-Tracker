import 'package:drift/drift.dart';

class Habits extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get name => text()();
  TextColumn get iconEmoji => text().withDefault(const Constant('⭐'))();
  TextColumn get category => text().withDefault(const Constant('general'))();
  TextColumn get frequency => text().withDefault(const Constant('daily'))();
  IntColumn get targetValue => integer().withDefault(const Constant(1))();
  TextColumn get unit => text().nullable()();
  TextColumn get chainNextId => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class HabitLogs extends Table {
  TextColumn get id => text()();
  TextColumn get habitId => text().references(Habits, #id)();
  TextColumn get userId => text()();
  DateTimeColumn get logDate => dateTime()();
  RealColumn get value => real().withDefault(const Constant(1.0))();
  IntColumn get moodAfter => integer().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class Routines extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get name => text()();
  TextColumn get routineType => text()();
  TextColumn get scheduleTime => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class RoutineSteps extends Table {
  TextColumn get id => text()();
  TextColumn get routineId => text().references(Routines, #id)();
  TextColumn get title => text()();
  IntColumn get durationMinutes => integer().nullable()();
  IntColumn get order => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class RoutineLogs extends Table {
  TextColumn get id => text()();
  TextColumn get routineId => text().references(Routines, #id)();
  TextColumn get userId => text()();
  DateTimeColumn get completedAt => dateTime()();
  IntColumn get stepsCompleted => integer().withDefault(const Constant(0))();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
