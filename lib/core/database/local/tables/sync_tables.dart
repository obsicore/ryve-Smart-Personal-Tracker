import 'package:drift/drift.dart';

@DataClassName('AppThemeRecord')
class AppThemes extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get primaryHex => text()();
  TextColumn get accentHex => text()();
  TextColumn get backgroundHex => text()();
  TextColumn get surfaceHex => text()();
  BoolColumn get isDark => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class WidgetConfigs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get widgetType => text()();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
  IntColumn get position => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncMeta extends Table {
  TextColumn get entityTable => text()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {entityTable};
}

class SyncQueue extends Table {
  TextColumn get id => text()();
  TextColumn get entityTable => text()();
  TextColumn get recordId => text()();
  TextColumn get payloadJson => text()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  BoolColumn get isFailed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class BackupManifests extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get filePath => text()();
  TextColumn get version => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class EncryptionConfigs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
