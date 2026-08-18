import 'package:drift/drift.dart';

class Goals extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get lifeArea => text()();
  TextColumn get metricType => text()();
  RealColumn get targetValue => real()();
  RealColumn get currentValue => real().withDefault(const Constant(0))();
  TextColumn get unit => text().nullable()();
  DateTimeColumn get targetDate => dateTime().nullable()();
  IntColumn get priority => integer().withDefault(const Constant(1))();
  TextColumn get status => text().withDefault(const Constant('active'))();
  TextColumn get icon => text().nullable()();
  TextColumn get colorHex => text().withDefault(const Constant('#C9A84C'))();
  TextColumn get visibility => text().withDefault(const Constant('private'))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class Milestones extends Table {
  TextColumn get id => text()();
  TextColumn get goalId => text()();
  TextColumn get title => text()();
  RealColumn get targetValue => real()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isComplete => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class GoalHabitLinks extends Table {
  TextColumn get goalId => text()();
  TextColumn get habitId => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {goalId, habitId};
}

class GoalTaskLinks extends Table {
  TextColumn get goalId => text()();
  TextColumn get taskId => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {goalId, taskId};
}

class LifeAreaScores extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get scoredAt => dateTime()();
  IntColumn get health => integer()();
  IntColumn get work => integer()();
  IntColumn get finance => integer()();
  IntColumn get relationships => integer()();
  IntColumn get personalGrowth => integer()();
  IntColumn get learning => integer()();
  IntColumn get recreation => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {userId, scoredAt},
      ];
}

class WeeklyReports extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get weekStart => dateTime()();
  DateTimeColumn get weekEnd => dateTime()();
  IntColumn get habitsCompleted => integer().withDefault(const Constant(0))();
  IntColumn get habitsTotal => integer().withDefault(const Constant(0))();
  IntColumn get tasksCompleted => integer().withDefault(const Constant(0))();
  IntColumn get focusMinutes => integer().withDefault(const Constant(0))();
  RealColumn get avgMood => real().withDefault(const Constant(0))();
  RealColumn get avgSleepHours => real().withDefault(const Constant(0))();
  IntColumn get xpEarned => integer().withDefault(const Constant(0))();
  TextColumn get aiSummary => text().nullable()();
  TextColumn get aiWins => text().nullable()();
  TextColumn get aiSuggestions => text().nullable()();
  DateTimeColumn get generatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {userId, weekStart},
      ];
}
