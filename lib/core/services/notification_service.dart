import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'package:hybrid_tracker/features/sleep/data/models/alarm_model.dart';

const _alarmChannelId = 'ryve_alarms';
const _alarmChannelName = 'Alarms';
const _alarmChannelDescription = 'Ryve wake-up alarm notifications';

const _reminderChannelId = 'ryve_reminders';
const _reminderChannelName = 'Smart Reminders';
const _reminderChannelDescription = 'Ryve time, location and contextual reminders';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

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
    );

    final androidImpl = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidImpl?.createNotificationChannel(
      const AndroidNotificationChannel(
        _alarmChannelId,
        _alarmChannelName,
        description: _alarmChannelDescription,
        importance: Importance.max,
        playSound: true,
      ),
    );

    await androidImpl?.createNotificationChannel(
      const AndroidNotificationChannel(
        _reminderChannelId,
        _reminderChannelName,
        description: _reminderChannelDescription,
        importance: Importance.high,
        playSound: true,
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

  int _notificationIdForAlarm(String alarmId, int weekday) =>
      Object.hash(alarmId, weekday) & 0x7fffffff;

  Future<void> scheduleAlarm(AlarmModel alarm) async {
    await cancelAlarm(alarm.id);
    if (!alarm.isEnabled) return;

    final parts = alarm.time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    for (final weekday in alarm.activeDays) {
      final scheduled = _nextInstanceOfWeekdayTime(weekday, hour, minute);

      await _plugin.zonedSchedule(
        _notificationIdForAlarm(alarm.id, weekday),
        alarm.label,
        'Time to wake up',
        scheduled,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            _alarmChannelId,
            _alarmChannelName,
            channelDescription: _alarmChannelDescription,
            importance: Importance.max,
            priority: Priority.high,
            category: AndroidNotificationCategory.alarm,
            fullScreenIntent: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        payload: alarm.id,
      );
    }
  }

  Future<void> cancelAlarm(String alarmId) async {
    for (var weekday = 1; weekday <= 7; weekday++) {
      await _plugin.cancel(_notificationIdForAlarm(alarmId, weekday));
    }
  }

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
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
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
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
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

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  tz.TZDateTime _nextInstanceOfWeekdayTime(int weekday, int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    while (scheduled.weekday != weekday || scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }
}
