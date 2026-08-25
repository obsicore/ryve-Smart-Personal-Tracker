import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/features/ai/data/models/smart_reminder_model.dart';

const _uuid = Uuid();

abstract class SmartReminderRepository {
  Stream<List<SmartReminderModel>> watchReminders(String userId);
  Future<List<SmartReminderModel>> activeReminders(String userId);
  Future<void> saveReminder(SmartReminderModel reminder);
  Future<void> deleteReminder(String id);
  Future<void> setActive(String id, bool isActive);
  Future<void> snooze(String id, Duration duration);
  Future<void> markTriggered(String id);

  Stream<List<LocationTriggerModel>> watchLocationTriggers(String userId);
  Future<void> saveLocationTrigger(LocationTriggerModel trigger);
  Future<void> deleteLocationTrigger(String id);
}

class SmartReminderRepositoryImpl implements SmartReminderRepository {
  SmartReminderRepositoryImpl(this._db);

  final AppDatabase _db;

  SmartReminderModel _fromRow(SmartReminder r) => SmartReminderModel(
        id: r.id,
        userId: r.userId,
        linkedType: r.linkedType,
        linkedId: r.linkedId,
        title: r.title,
        body: r.body,
        triggerType: ReminderTriggerTypeX.fromStorage(r.triggerType),
        triggerConfig: jsonDecode(r.triggerConfig) as Map<String, dynamic>,
        isActive: r.isActive,
        snoozedUntil: r.snoozedUntil,
        lastTriggered: r.lastTriggered,
        createdAt: r.createdAt,
        updatedAt: r.updatedAt,
      );

  @override
  Stream<List<SmartReminderModel>> watchReminders(String userId) {
    final query = _db.select(_db.smartReminders)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    return query.watch().map((rows) => rows.map(_fromRow).toList());
  }

  @override
  Future<List<SmartReminderModel>> activeReminders(String userId) async {
    final rows = await (_db.select(_db.smartReminders)
          ..where((t) => t.userId.equals(userId) & t.isActive.equals(true)))
        .get();
    return rows.map(_fromRow).toList();
  }

  @override
  Future<void> saveReminder(SmartReminderModel reminder) async {
    await _db.into(_db.smartReminders).insertOnConflictUpdate(
          SmartRemindersCompanion(
            id: Value(reminder.id),
            userId: Value(reminder.userId),
            linkedType: Value(reminder.linkedType),
            linkedId: Value(reminder.linkedId),
            title: Value(reminder.title),
            body: Value(reminder.body),
            triggerType: Value(reminder.triggerType.storageValue),
            triggerConfig: Value(jsonEncode(reminder.triggerConfig)),
            isActive: Value(reminder.isActive),
            snoozedUntil: Value(reminder.snoozedUntil),
            lastTriggered: Value(reminder.lastTriggered),
            createdAt: Value(reminder.createdAt),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  @override
  Future<void> deleteReminder(String id) async {
    await (_db.delete(_db.smartReminders)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> setActive(String id, bool isActive) async {
    await (_db.update(_db.smartReminders)..where((t) => t.id.equals(id))).write(
      SmartRemindersCompanion(isActive: Value(isActive), updatedAt: Value(DateTime.now())),
    );
  }

  @override
  Future<void> snooze(String id, Duration duration) async {
    await (_db.update(_db.smartReminders)..where((t) => t.id.equals(id))).write(
      SmartRemindersCompanion(
        snoozedUntil: Value(DateTime.now().add(duration)),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> markTriggered(String id) async {
    await (_db.update(_db.smartReminders)..where((t) => t.id.equals(id))).write(
      SmartRemindersCompanion(lastTriggered: Value(DateTime.now())),
    );
  }

  @override
  Stream<List<LocationTriggerModel>> watchLocationTriggers(String userId) {
    final query = _db.select(_db.locationTriggers)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    return query.watch().map(
          (rows) => rows
              .map((r) => LocationTriggerModel(
                    id: r.id,
                    userId: r.userId,
                    label: r.label,
                    latitude: r.latitude,
                    longitude: r.longitude,
                    radiusMeters: r.radiusMeters,
                    createdAt: r.createdAt,
                  ))
              .toList(),
        );
  }

  @override
  Future<void> saveLocationTrigger(LocationTriggerModel trigger) async {
    await _db.into(_db.locationTriggers).insertOnConflictUpdate(
          LocationTriggersCompanion(
            id: Value(trigger.id),
            userId: Value(trigger.userId),
            label: Value(trigger.label),
            latitude: Value(trigger.latitude),
            longitude: Value(trigger.longitude),
            radiusMeters: Value(trigger.radiusMeters),
            createdAt: Value(trigger.createdAt),
          ),
        );
  }

  @override
  Future<void> deleteLocationTrigger(String id) async {
    await (_db.delete(_db.locationTriggers)..where((t) => t.id.equals(id))).go();
  }
}

String newSmartReminderId() => _uuid.v4();
