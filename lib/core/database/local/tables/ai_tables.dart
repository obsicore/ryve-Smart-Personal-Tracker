import 'package:drift/drift.dart';

class AiPlans extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get planDate => dateTime()();
  TextColumn get status => text().withDefault(const Constant('draft'))();
  TextColumn get promptContext => text().nullable()();
  TextColumn get modelUsed => text().nullable()();
  DateTimeColumn get generatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get acceptedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {userId, planDate},
      ];
}

class AiPlanItems extends Table {
  TextColumn get id => text()();
  TextColumn get planId => text()();
  TextColumn get slotStart => text()();
  TextColumn get slotEnd => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get itemType => text()();
  TextColumn get linkedTaskId => text().nullable()();
  TextColumn get linkedHabitId => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  TextColumn get itemStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

class SmartReminders extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get linkedType => text().nullable()();
  TextColumn get linkedId => text().nullable()();
  TextColumn get title => text()();
  TextColumn get body => text().nullable()();
  TextColumn get triggerType => text()();
  TextColumn get triggerConfig => text().withDefault(const Constant('{}'))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get snoozedUntil => dateTime().nullable()();
  DateTimeColumn get lastTriggered => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class LocationTriggers extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get label => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get radiusMeters => real().withDefault(const Constant(150))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class CoachingInsights extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get category => text()();
  TextColumn get content => text()();
  TextColumn get contextJson => text().nullable()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  BoolColumn get isDismissed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get generatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get readAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
