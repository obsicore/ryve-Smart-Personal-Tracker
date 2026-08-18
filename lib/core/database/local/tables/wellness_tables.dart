import 'package:drift/drift.dart';

class MoodLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get logDate => dateTime()();
  DateTimeColumn get logTime => dateTime().withDefault(currentDateAndTime)();
  IntColumn get moodScore => integer()();
  IntColumn get energyScore => integer().nullable()();
  TextColumn get moodTags => text().nullable()();
  TextColumn get factors => text().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class EnergyLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get logDate => dateTime()();
  DateTimeColumn get logTime => dateTime().withDefault(currentDateAndTime)();
  IntColumn get energyLevel => integer()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class WaterLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get logDate => dateTime()();
  DateTimeColumn get logTime => dateTime().withDefault(currentDateAndTime)();
  IntColumn get amountMl => integer()();
  TextColumn get containerType => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class WorkoutLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get workoutType => text()();
  TextColumn get name => text().nullable()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  IntColumn get durationMin => integer().nullable()();
  RealColumn get distanceM => real().nullable()();
  IntColumn get calories => integer().nullable()();
  IntColumn get avgHeartRate => integer().nullable()();
  TextColumn get source => text().withDefault(const Constant('manual'))();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class WorkoutSets extends Table {
  TextColumn get id => text()();
  TextColumn get workoutId => text()();
  TextColumn get exerciseName => text()();
  IntColumn get setNumber => integer()();
  IntColumn get reps => integer().nullable()();
  RealColumn get weightKg => real().nullable()();
  IntColumn get durationSec => integer().nullable()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class BreathingSessions extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get technique => text()();
  IntColumn get durationMin => integer()();
  IntColumn get cyclesCompleted => integer().withDefault(const Constant(0))();
  IntColumn get moodBefore => integer().nullable()();
  IntColumn get moodAfter => integer().nullable()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class DailyStepLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get logDate => dateTime()();
  IntColumn get stepCount => integer()();
  RealColumn get distanceM => real().nullable()();
  IntColumn get calories => integer().nullable()();
  TextColumn get source => text().withDefault(const Constant('manual'))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {userId, logDate},
      ];
}
