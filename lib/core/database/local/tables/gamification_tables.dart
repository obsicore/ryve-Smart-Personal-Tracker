import 'package:drift/drift.dart';

class XpEvents extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get eventType => text()();
  IntColumn get xpAmount => integer()();
  TextColumn get referenceId => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class BadgeDefinitions extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get iconEmoji => text()();
  TextColumn get category => text()();
  TextColumn get requirement => text()();
  IntColumn get rarity => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

class UserBadges extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get badgeId => text().references(BadgeDefinitions, #id)();
  DateTimeColumn get earnedAt => dateTime()();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class Streaks extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get streakType => text()();
  TextColumn get referenceId => text().nullable()();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastActivityDate => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
