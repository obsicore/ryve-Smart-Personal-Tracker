import 'dart:async';

import 'package:drift/drift.dart';
import 'package:home_widget/home_widget.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/core/services/xp_service.dart';

/// Pushes fresh data to the three Android home-screen widgets. Called after
/// the actions each widget cares about (habit log, water log); the focus
/// quick-start widget has no live data to push, it just deep-links back in.
class HomeWidgetService {
  static Future<void> updateHabitProgress({required int done, required int total}) async {
    await HomeWidget.saveWidgetData<String>('habitsDone', done.toString());
    await HomeWidget.saveWidgetData<String>('habitsTotal', total.toString());
    await HomeWidget.updateWidget(
      name: 'HabitProgressWidgetProvider',
      androidName: 'HabitProgressWidgetProvider',
    );
  }

  static Future<void> updateWaterTracker({required int consumedMl, required int goalMl}) async {
    await HomeWidget.saveWidgetData<String>('waterConsumedMl', consumedMl.toString());
    await HomeWidget.saveWidgetData<String>('waterGoalMl', goalMl.toString());
    await HomeWidget.updateWidget(
      name: 'WaterTrackerWidgetProvider',
      androidName: 'WaterTrackerWidgetProvider',
    );
  }

  /// Registers a listener for widget taps that carry a `ryve://` deep link
  /// (currently just the focus quick-start widget). [onFocusAutoStart] is
  /// invoked when the user tapped "Start Focus" from the home screen.
  static void listenForClicks({required void Function() onFocusAutoStart}) {
    HomeWidget.widgetClicked.listen((uri) {
      if (uri == null) return;
      if (uri.host == 'focus' && uri.queryParameters['autostart'] == 'true') {
        onFocusAutoStart();
      }
    });
  }

  /// Widget data has no access to Riverpod state, so the signed-in user's id
  /// is mirrored here whenever it changes — the headless background callback
  /// reads it back to attribute a widget-triggered water log to the right user.
  static Future<void> saveCurrentUserId(String? userId) async {
    if (userId == null) return;
    await HomeWidget.saveWidgetData<String>('currentUserId', userId);
  }

  /// Wires up [_addWaterInBackground] as the entrypoint Android invokes via
  /// `HomeWidgetBackgroundIntent` when the Water Tracker widget's "+" button
  /// is tapped — runs in a headless Flutter engine, no app UI is shown.
  static Future<void> registerBackgroundCallback() {
    return HomeWidget.registerInteractivityCallback(_addWaterInBackground);
  }
}

@pragma('vm:entry-point')
Future<void> _addWaterInBackground(Uri? uri) async {
  if (uri?.host != 'widget' || uri?.path != '/water/add') return;
  final userId = await HomeWidget.getWidgetData<String>('currentUserId');
  if (userId == null) return;

  final db = AppDatabase();
  final now = DateTime.now();
  final logId = const Uuid().v4();
  await db.into(db.waterLogs).insert(WaterLogsCompanion.insert(
        id: logId,
        userId: userId,
        logDate: now,
        amountMl: 250,
      ));
  // XPService only needs a db handle + userId (no Ref), so the headless
  // engine can award XP and update challenge progress the same way the
  // in-app water-log path does, instead of silently skipping both.
  await XPService(db, userId).award(XPEvent.waterLog, entityId: logId);

  final todayStart = DateTime(now.year, now.month, now.day);
  final todayLogs = await (db.select(db.waterLogs)
        ..where((l) =>
            l.userId.equals(userId) & l.logDate.isBiggerOrEqualValue(todayStart)))
      .get();
  final totalMl = todayLogs.fold(0, (sum, l) => sum + l.amountMl);
  await db.close();

  await HomeWidget.saveWidgetData<String>('waterConsumedMl', totalMl.toString());
  await HomeWidget.updateWidget(
    name: 'WaterTrackerWidgetProvider',
    androidName: 'WaterTrackerWidgetProvider',
  );
}
