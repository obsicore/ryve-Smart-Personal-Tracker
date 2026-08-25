import 'package:drift/drift.dart';

class Partners extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get partnerId => text().nullable()();
  TextColumn get inviteCode => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class PartnerCheckIns extends Table {
  TextColumn get id => text()();
  TextColumn get partnershipId => text().references(Partners, #id)();
  TextColumn get userId => text()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class CommunityChallenges extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get challengeType => text()();
  IntColumn get targetValue => integer()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class CommunityParticipants extends Table {
  TextColumn get id => text()();
  TextColumn get challengeId => text().references(CommunityChallenges, #id)();
  TextColumn get userId => text()();
  TextColumn get displayName => text()();
  IntColumn get currentValue => integer().withDefault(const Constant(0))();
  DateTimeColumn get joinedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
