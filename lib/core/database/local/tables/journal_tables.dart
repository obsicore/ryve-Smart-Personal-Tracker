import 'package:drift/drift.dart';

class JournalEntries extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get entryDate => dateTime()();
  TextColumn get title => text().nullable()();
  TextColumn get content => text()();
  TextColumn get moodTag => text().nullable()();
  BoolColumn get isPrivate => boolean().withDefault(const Constant(true))();
  IntColumn get wordCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class JournalMedia extends Table {
  TextColumn get id => text()();
  TextColumn get entryId => text()();
  TextColumn get mediaType => text().withDefault(const Constant('image'))();
  TextColumn get fileUrl => text()();
  TextColumn get thumbnailUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class GratitudeLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get logDate => dateTime()();
  TextColumn get item1 => text()();
  TextColumn get item2 => text().nullable()();
  TextColumn get item3 => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class ReflectionPrompts extends Table {
  TextColumn get id => text()();
  TextColumn get content => text()();
  TextColumn get category => text().withDefault(const Constant('general'))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class ReflectionResponses extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get promptId => text()();
  TextColumn get response => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
