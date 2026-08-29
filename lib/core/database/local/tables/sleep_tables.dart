import 'package:drift/drift.dart';

class SleepLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get bedtime => dateTime()();
  DateTimeColumn get wakeTime => dateTime()();
  IntColumn get qualityRating => integer().withDefault(const Constant(3))();
  IntColumn get sleepLatencyMinutes => integer().nullable()();
  BoolColumn get hadNightmares => boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class SleepSettings extends Table {
  TextColumn get userId => text()();
  TextColumn get targetBedtime => text().withDefault(const Constant('22:00'))();
  TextColumn get targetWakeTime => text().withDefault(const Constant('06:00'))();
  IntColumn get targetHours => integer().withDefault(const Constant(8))();
  BoolColumn get bedtimeReminderEnabled => boolean().withDefault(const Constant(true))();
  IntColumn get reminderMinutesBefore => integer().withDefault(const Constant(30))();

  @override
  Set<Column> get primaryKey => {userId};
}

class Alarms extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get label => text().withDefault(const Constant('Wake Up'))();
  TextColumn get time => text()();
  TextColumn get daysOfWeek => text().withDefault(const Constant('1,2,3,4,5,6,7'))();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
  TextColumn get missionType => text().withDefault(const Constant('none'))();
  IntColumn get snoozeCount => integer().withDefault(const Constant(3))();
  IntColumn get snoozeDurationMinutes => integer().withDefault(const Constant(5))();
  TextColumn get soundName => text().withDefault(const Constant('default'))();
  IntColumn get mathLevel => integer().withDefault(const Constant(1))();
  IntColumn get mathProblemCount => integer().withDefault(const Constant(3))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
