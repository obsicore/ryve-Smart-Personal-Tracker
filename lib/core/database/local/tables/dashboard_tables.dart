import 'package:drift/drift.dart';

class DashboardLayouts extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get cardOrder => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class DashboardCards extends Table {
  TextColumn get id => text()();
  TextColumn get layoutId => text()();
  TextColumn get cardType => text()();
  BoolColumn get isVisible => boolean().withDefault(const Constant(true))();
  IntColumn get position => integer()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class NotificationHistory extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  TextColumn get notifType => text()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
