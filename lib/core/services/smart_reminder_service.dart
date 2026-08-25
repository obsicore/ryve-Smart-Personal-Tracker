import 'package:drift/drift.dart';
import 'package:geolocator/geolocator.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/core/services/notification_service.dart';
import 'package:hybrid_tracker/features/ai/data/models/smart_reminder_model.dart';
import 'package:hybrid_tracker/features/ai/data/repositories/smart_reminder_repository.dart';

/// Evaluates and fires smart reminders without any Firebase/push
/// infrastructure — time reminders are scheduled as local notifications
/// up-front, location and contextual reminders are checked on every
/// [evaluate] call (app resume + a foreground periodic timer, see
/// [main.dart]). Location checks only ever request foreground position
/// (no ACCESS_BACKGROUND_LOCATION), which is why this is foreground-only.
class SmartReminderService {
  SmartReminderService(this._repository, this._db);

  final SmartReminderRepository _repository;
  final AppDatabase _db;

  static const _locationCooldown = Duration(minutes: 30);
  static const _contextualCooldown = Duration(hours: 20);

  Future<void> applySchedule(SmartReminderModel reminder) async {
    if (reminder.triggerType != ReminderTriggerType.time || !reminder.isActive) {
      await NotificationService.instance.cancelReminder(reminder.id);
    }
    if (reminder.triggerType == ReminderTriggerType.time && reminder.isActive) {
      final hour = reminder.triggerConfig['hour'] as int? ?? 9;
      final minute = reminder.triggerConfig['minute'] as int? ?? 0;
      final weekdays = (reminder.triggerConfig['weekdays'] as List?)?.cast<int>();
      await NotificationService.instance.scheduleDailyReminder(
        reminder.id,
        reminder.title,
        reminder.body,
        hour: hour,
        minute: minute,
        weekdays: weekdays,
      );
    }
  }

  Future<void> cancelSchedule(String reminderId) =>
      NotificationService.instance.cancelReminder(reminderId);

  /// Checks location and contextual reminders against current state.
  /// Safe to call frequently — every reminder has its own cooldown.
  Future<void> evaluate(String userId) async {
    final reminders = await _repository.activeReminders(userId);
    final now = DateTime.now();
    final due = reminders.where((r) =>
        r.snoozedUntil == null || r.snoozedUntil!.isBefore(now));

    Position? position;
    for (final reminder in due) {
      switch (reminder.triggerType) {
        case ReminderTriggerType.location:
          position ??= await _tryGetPosition();
          if (position == null) continue;
          await _evaluateLocation(reminder, position, userId);
        case ReminderTriggerType.contextual:
          await _evaluateContextual(reminder, userId, now);
        case ReminderTriggerType.time:
          break;
      }
    }
  }

  Future<Position?> _tryGetPosition() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final requested = await Geolocator.requestPermission();
        if (requested == LocationPermission.denied ||
            requested == LocationPermission.deniedForever) {
          return null;
        }
      }
      if (permission == LocationPermission.deniedForever) return null;
      if (!await Geolocator.isLocationServiceEnabled()) return null;
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.medium),
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> _evaluateLocation(
    SmartReminderModel reminder,
    Position position,
    String userId,
  ) async {
    final triggerId = reminder.triggerConfig['triggerId'] as String?;
    if (triggerId == null) return;
    final row = await (_db.select(_db.locationTriggers)
          ..where((t) => t.id.equals(triggerId)))
        .getSingleOrNull();
    if (row == null) return;

    final distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      row.latitude,
      row.longitude,
    );
    if (distance > row.radiusMeters) return;

    if (reminder.lastTriggered != null &&
        DateTime.now().difference(reminder.lastTriggered!) < _locationCooldown) {
      return;
    }

    await NotificationService.instance.showReminderNow(
      reminder.id,
      reminder.title,
      reminder.body ?? "You're near ${row.label} — ${reminder.title}",
    );
    await _repository.markTriggered(reminder.id);
  }

  Future<void> _evaluateContextual(
    SmartReminderModel reminder,
    String userId,
    DateTime now,
  ) async {
    final hour = reminder.triggerConfig['hour'] as int?;
    final habitId = reminder.triggerConfig['habitId'] as String?;
    if (hour == null || habitId == null) return;
    if (now.hour < hour) return;

    if (reminder.lastTriggered != null &&
        now.difference(reminder.lastTriggered!) < _contextualCooldown) {
      return;
    }

    final loggedToday = await (_db.select(_db.habitLogs)
          ..where((l) =>
              l.habitId.equals(habitId) &
              l.logDate.isBiggerOrEqualValue(DateTime(now.year, now.month, now.day))))
        .get();
    if (loggedToday.isNotEmpty) return;

    await NotificationService.instance.showReminderNow(
      reminder.id,
      reminder.title,
      reminder.body ?? 'Still pending today — ${reminder.title}',
    );
    await _repository.markTriggered(reminder.id);
  }
}
