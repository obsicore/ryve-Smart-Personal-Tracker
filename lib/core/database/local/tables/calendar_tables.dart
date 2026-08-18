import 'package:drift/drift.dart';

class CalendarEvents extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get location => text().nullable()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
  BoolColumn get isAllDay =>
      boolean().withDefault(const Constant(false))();
  TextColumn get color =>
      text().withDefault(const Constant('#4CAF82'))();
  TextColumn get recurrenceRule => text().nullable()();
  TextColumn get linkedTaskId => text().nullable()();
  IntColumn get reminderMinutes => integer().nullable()();
  IntColumn get syncStatus =>
      integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
