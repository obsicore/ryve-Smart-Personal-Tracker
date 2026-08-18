import 'package:drift/drift.dart';

class FocusSessions extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  IntColumn get durationMinutes => integer()();
  TextColumn get sessionType => text().withDefault(const Constant('work'))();
  BoolColumn get wasCompleted => boolean().withDefault(const Constant(true))();
  TextColumn get linkedTaskId => text().nullable()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime()();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class FocusSettings extends Table {
  TextColumn get userId => text()();
  IntColumn get workMinutes => integer().withDefault(const Constant(25))();
  IntColumn get shortBreakMinutes => integer().withDefault(const Constant(5))();
  IntColumn get longBreakMinutes => integer().withDefault(const Constant(15))();
  IntColumn get sessionsBeforeLongBreak => integer().withDefault(const Constant(4))();
  BoolColumn get autoStartBreaks => boolean().withDefault(const Constant(false))();
  BoolColumn get soundEnabled => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {userId};
}
