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
  IntColumn get xpReward => integer().withDefault(const Constant(0))();

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

  @override
  List<Set<Column>> get uniqueKeys => [
        {userId, badgeId},
      ];
}

class Streaks extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get streakType => text()();
  TextColumn get referenceId => text().nullable()();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastActivityDate => dateTime().nullable()();
  IntColumn get freezeTokens => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class Challenges extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get challengeType => text()();
  IntColumn get targetValue => integer()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  IntColumn get xpReward => integer().withDefault(const Constant(0))();
  TextColumn get badgeId => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class UserChallenges extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get challengeId => text()();
  DateTimeColumn get joinedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get status => text().withDefault(const Constant('active'))();
  IntColumn get currentValue => integer().withDefault(const Constant(0))();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {userId, challengeId},
      ];
}

class ChallengeEntries extends Table {
  TextColumn get id => text()();
  TextColumn get userChallengeId => text()();
  IntColumn get value => integer()();
  DateTimeColumn get recordedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
