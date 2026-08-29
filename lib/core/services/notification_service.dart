import 'dart:async';
import 'dart:convert';

import 'package:alarm/alarm.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'package:hybrid_tracker/features/focus/data/models/focus_session_model.dart';
import 'package:hybrid_tracker/features/sleep/data/models/alarm_model.dart';

// ── Reminder channel (habits, smart reminders) ───────────────────────────────
const _reminderChannelId = 'ryve_reminders';
const _reminderChannelName = 'Smart Reminders';
const _reminderChannelDescription = 'Ryve time, location and contextual reminders';

// ── Alerts channel (focus timer + task deadlines — full-screen intent) ────────
const _alertChannelId = 'ryve_alerts';
const _alertChannelName = 'Focus & Task Alerts';
const _alertChannelDescription = 'Focus session completions and task deadline alerts';

const _taskReminderIdBand = 0x20000000;
const _focusNotifId = 0x30000001;

@pragma('vm:entry-point')
void _onBackgroundNotificationResponse(NotificationResponse response) {
  // reminders only — alarms handled by alarm package
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const _batteryChannel =
      MethodChannel('com.hybridtracker.hybrid_tracker/battery');

  Future<bool> isIgnoringBatteryOptimizations() async {
    try {
      return await _batteryChannel
              .invokeMethod<bool>('isIgnoringBatteryOptimizations') ??
          true;
    } catch (_) {
      return true;
    }
  }

  Future<void> requestIgnoreBatteryOptimizations() async {
    try {
      await _batteryChannel
          .invokeMethod('requestIgnoreBatteryOptimizations');
    } catch (_) {}
  }

  Future<void> init() async {
    if (_initialized) return;

    // Initialize alarm package (setAlarmClock + foreground service).
    await Alarm.init();

    tz_data.initializeTimeZones();
    final offsetHours = DateTime.now().timeZoneOffset.inHours;
    final etcName = offsetHours == 0
        ? 'UTC'
        : 'Etc/GMT${offsetHours > 0 ? '-' : '+'}${offsetHours.abs()}';
    tz.setLocalLocation(tz.getLocation(etcName));

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
      onDidReceiveNotificationResponse: _handleReminderResponse,
      onDidReceiveBackgroundNotificationResponse: _onBackgroundNotificationResponse,
    );

    final androidImpl = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidImpl?.createNotificationChannel(
      const AndroidNotificationChannel(
        _reminderChannelId,
        _reminderChannelName,
        description: _reminderChannelDescription,
        importance: Importance.high,
        playSound: true,
      ),
    );

    await androidImpl?.createNotificationChannel(
      const AndroidNotificationChannel(
        _alertChannelId,
        _alertChannelName,
        description: _alertChannelDescription,
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
      ),
    );

    _initialized = true;
  }

  Future<void> requestPermissions() async {
    final androidImpl = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidImpl?.requestNotificationsPermission();
    await androidImpl?.requestExactAlarmsPermission();

    final iosImpl = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    await iosImpl?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<bool> hasExactAlarmPermission() async {
    final androidImpl = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    return await androidImpl?.canScheduleExactNotifications() ?? true;
  }

  // ── Alarm scheduling via `alarm` package ──────────────────────────────────
  //
  // The `alarm` package uses AlarmManager.setAlarmClock() — the same API used
  // by the built-in clock app. It is backed by a foreground service with a
  // WakeLock, so it fires reliably on Samsung regardless of battery optimization.
  //
  // One AlarmSettings per (alarmId, weekday) pair. We derive a stable int id
  // by hashing the string id + weekday into the 31-bit range the alarm package
  // expects.

  // Available alarm sounds — must match asset filenames in assets/audio/
  static const alarmSounds = [
    ('default', 'Digital Alarm'),
    ('gentle', 'Gentle Chime'),
    ('digital', 'Digital Buzz'),
    ('classic', 'Classic Ring'),
  ];

  static String assetForSound(String soundName) {
    switch (soundName) {
      case 'gentle':
        return 'assets/audio/alarm_gentle.mp3';
      case 'digital':
        return 'assets/audio/alarm_digital.mp3';
      case 'classic':
        return 'assets/audio/alarm_classic.mp3';
      default:
        return 'assets/audio/alarm_default.mp3';
    }
  }

  int _alarmIntId(String alarmId, int weekday) =>
      Object.hash(alarmId, weekday) & 0x7fffffff;

  int _snoozeIntId(String alarmId) =>
      (0x40000000 + alarmId.hashCode) & 0x7fffffff;

  Future<void> scheduleAlarm(AlarmModel alarm) async {
    await cancelAlarm(alarm.id);
    if (!alarm.isEnabled) return;

    final parts = alarm.time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    for (final weekday in alarm.activeDays) {
      final fireAt = _nextInstanceOfWeekdayTimeLocal(weekday, hour, minute);

      await Alarm.set(
        alarmSettings: AlarmSettings(
          id: _alarmIntId(alarm.id, weekday),
          dateTime: fireAt,
          assetAudioPath: NotificationService.assetForSound(alarm.soundName),
          loopAudio: true,
          vibrate: true,
          warningNotificationOnKill: true,
          androidFullScreenIntent: true,
          volumeSettings: const VolumeSettings.fixed(volume: 1.0),
          notificationSettings: NotificationSettings(
            title: alarm.label,
            body: 'Tap to dismiss',
            stopButton: 'Dismiss',
            icon: 'ic_launcher',
          ),
        ),
      );
    }
  }

  Future<void> snoozeAlarm(AlarmModel alarm) async {
    final fireAt = DateTime.now().add(Duration(minutes: alarm.snoozeDurationMinutes));
    await Alarm.set(
      alarmSettings: AlarmSettings(
        id: _snoozeIntId(alarm.id),
        dateTime: fireAt,
        assetAudioPath: 'assets/audio/alarm_default.mp3',
        loopAudio: true,
        vibrate: true,
        warningNotificationOnKill: true,
        androidFullScreenIntent: true,
        volumeSettings: const VolumeSettings.fixed(volume: 1.0),
        notificationSettings: NotificationSettings(
          title: alarm.label,
          body: 'Snoozed alarm',
          stopButton: 'Dismiss',
          icon: 'ic_launcher',
        ),
      ),
    );
  }

  Future<void> cancelAlarm(String alarmId) async {
    for (var weekday = 1; weekday <= 7; weekday++) {
      await Alarm.stop(_alarmIntId(alarmId, weekday));
    }
    await Alarm.stop(_snoozeIntId(alarmId));
  }

  // ── Reminder notifications (flutter_local_notifications) ──────────────────

  void _handleReminderResponse(NotificationResponse response) {}

  int _notificationIdForReminder(String reminderId) =>
      reminderId.hashCode & 0x7fffffff;

  Future<void> showReminderNow(String reminderId, String title, String? body) async {
    await _plugin.show(
      _notificationIdForReminder(reminderId),
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _reminderChannelId,
          _reminderChannelName,
          channelDescription: _reminderChannelDescription,
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      payload: reminderId,
    );
  }

  Future<void> scheduleDailyReminder(
    String reminderId,
    String title,
    String? body, {
    required int hour,
    required int minute,
    List<int>? weekdays,
  }) async {
    await cancelReminder(reminderId);
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        _reminderChannelId,
        _reminderChannelName,
        channelDescription: _reminderChannelDescription,
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    if (weekdays == null || weekdays.isEmpty) {
      await _plugin.zonedSchedule(
        _notificationIdForReminder(reminderId),
        title,
        body,
        _nextInstanceOfTime(hour, minute),
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: reminderId,
      );
    } else {
      for (final weekday in weekdays) {
        await _plugin.zonedSchedule(
          Object.hash(reminderId, weekday) & 0x7fffffff,
          title,
          body,
          _nextInstanceOfWeekdayTime(weekday, hour, minute),
          details,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
          payload: reminderId,
        );
      }
    }
  }

  Future<void> cancelReminder(String reminderId) async {
    await _plugin.cancel(_notificationIdForReminder(reminderId));
    for (var weekday = 1; weekday <= 7; weekday++) {
      await _plugin.cancel(Object.hash(reminderId, weekday) & 0x7fffffff);
    }
  }

  // ── Focus timer completion alert ──────────────────────────────────────────

  static const _alertDetails = AndroidNotificationDetails(
    _alertChannelId,
    _alertChannelName,
    channelDescription: _alertChannelDescription,
    importance: Importance.max,
    priority: Priority.max,
    fullScreenIntent: true,
    playSound: true,
    enableVibration: true,
    ticker: 'Ryve Alert',
  );

  Future<void> showFocusComplete(FocusSessionType sessionType) async {
    final (title, body) = switch (sessionType) {
      FocusSessionType.work => ('Time\'s up! 🧠', 'Work session complete. Take a break.'),
      FocusSessionType.shortBreak => ('Break over! 💪', 'Ready for the next focus session?'),
      FocusSessionType.longBreak => ('Long break done! 🚀', 'Back to crushing it?'),
    };

    await _plugin.show(
      _focusNotifId,
      title,
      body,
      const NotificationDetails(android: _alertDetails),
    );
  }

  // ── Task deadline alerts ──────────────────────────────────────────────────

  int _notificationIdForTaskReminder(String taskId) =>
      (_taskReminderIdBand + taskId.hashCode) & 0x7fffffff;

  Future<void> scheduleTaskReminder(String taskId, String title, DateTime? fireAt) async {
    await cancelTaskReminder(taskId);
    if (fireAt == null) return;

    final scheduled = tz.TZDateTime.from(fireAt, tz.local);
    if (scheduled.isBefore(tz.TZDateTime.now(tz.local))) return;

    await _plugin.zonedSchedule(
      _notificationIdForTaskReminder(taskId),
      '⏰ $title',
      'Task deadline',
      scheduled,
      const NotificationDetails(android: _alertDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: jsonEncode({'taskId': taskId}),
    );
  }

  Future<void> cancelTaskReminder(String taskId) async {
    await _plugin.cancel(_notificationIdForTaskReminder(taskId));
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  // Used by reminder scheduling (flutter_local_notifications).
  tz.TZDateTime _nextInstanceOfWeekdayTime(int weekday, int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    while (scheduled.weekday != weekday || scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  // Used by alarm scheduling (alarm package) — returns plain DateTime.
  DateTime _nextInstanceOfWeekdayTimeLocal(int weekday, int hour, int minute) {
    final now = DateTime.now();
    var scheduled = DateTime(now.year, now.month, now.day, hour, minute);
    while (scheduled.weekday != weekday || scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
