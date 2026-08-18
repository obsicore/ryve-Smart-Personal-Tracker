import 'package:drift/drift.dart';
import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/features/calendar/data/models/calendar_event_model.dart';

// ---------------------------------------------------------------------------
// Abstract interface
// ---------------------------------------------------------------------------
abstract class CalendarRepository {
  Stream<List<CalendarEventModel>> watchEventsForMonth(
    String userId,
    DateTime month,
  );

  Stream<List<CalendarEventModel>> watchEventsForDay(
    String userId,
    DateTime day,
  );

  Future<void> createEvent(CalendarEventModel e);
  Future<void> updateEvent(CalendarEventModel e);
  Future<void> deleteEvent(String id);
}

// ---------------------------------------------------------------------------
// Drift implementation
// ---------------------------------------------------------------------------
class CalendarRepositoryImpl implements CalendarRepository {
  CalendarRepositoryImpl(this._db);

  final AppDatabase _db;

  // -------------------------------------------------------------------------
  // Row → model
  // -------------------------------------------------------------------------
  CalendarEventModel _fromRow(CalendarEvent row) => CalendarEventModel(
        id: row.id,
        userId: row.userId,
        title: row.title,
        description: row.description,
        location: row.location,
        startTime: row.startTime,
        endTime: row.endTime,
        isAllDay: row.isAllDay,
        color: row.color,
        recurrenceRule: row.recurrenceRule,
        linkedTaskId: row.linkedTaskId,
        reminderMinutes: row.reminderMinutes,
        syncStatus: row.syncStatus,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );

  // -------------------------------------------------------------------------
  // Model → companion
  // -------------------------------------------------------------------------
  CalendarEventsCompanion _toCompanion(CalendarEventModel e) =>
      CalendarEventsCompanion(
        id: Value(e.id),
        userId: Value(e.userId),
        title: Value(e.title),
        description: Value(e.description),
        location: Value(e.location),
        startTime: Value(e.startTime),
        endTime: Value(e.endTime),
        isAllDay: Value(e.isAllDay),
        color: Value(e.color),
        recurrenceRule: Value(e.recurrenceRule),
        linkedTaskId: Value(e.linkedTaskId),
        reminderMinutes: Value(e.reminderMinutes),
        syncStatus: Value(e.syncStatus),
        createdAt: Value(e.createdAt),
        updatedAt: Value(e.updatedAt),
      );

  // -------------------------------------------------------------------------
  // Queries
  // -------------------------------------------------------------------------
  @override
  Stream<List<CalendarEventModel>> watchEventsForMonth(
    String userId,
    DateTime month,
  ) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0, 23, 59, 59);
    return (_db.select(_db.calendarEvents)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.startTime.isBetweenValues(firstDay, lastDay),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.startTime)]))
        .watch()
        .map((rows) => rows.map(_fromRow).toList());
  }

  @override
  Stream<List<CalendarEventModel>> watchEventsForDay(
    String userId,
    DateTime day,
  ) {
    final start = DateTime(day.year, day.month, day.day);
    final end = DateTime(day.year, day.month, day.day, 23, 59, 59);
    return (_db.select(_db.calendarEvents)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.startTime.isBetweenValues(start, end),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.startTime)]))
        .watch()
        .map((rows) => rows.map(_fromRow).toList());
  }

  @override
  Future<void> createEvent(CalendarEventModel e) =>
      _db.into(_db.calendarEvents).insert(_toCompanion(e));

  @override
  Future<void> updateEvent(CalendarEventModel e) =>
      (_db.update(_db.calendarEvents)..where((t) => t.id.equals(e.id)))
          .write(_toCompanion(e));

  @override
  Future<void> deleteEvent(String id) =>
      (_db.delete(_db.calendarEvents)..where((t) => t.id.equals(id))).go();
}
