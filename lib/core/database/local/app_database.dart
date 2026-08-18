import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/auth_tables.dart';
import 'tables/calendar_tables.dart';
import 'tables/dashboard_tables.dart';
import 'tables/focus_tables.dart';
import 'tables/sleep_tables.dart';
import 'tables/task_tables.dart';
import 'tables/habit_tables.dart';
import 'tables/gamification_tables.dart';
import 'tables/wellness_tables.dart';
import 'tables/goals_tables.dart';

part 'app_database.g.dart';

// ---------------------------------------------------------------------------
// AppDatabase
//
// Single Drift database for Ryve. Tables are split across domain-specific
// files and included via the @DriftDatabase annotation.
//
// Additional table files will be added here as more phases are implemented
// (focus, sleep, wellness, goals, journal, social).
// ---------------------------------------------------------------------------
@DriftDatabase(
  tables: [
    // auth
    Users,
    UserProfiles,
    OnboardingResponses,
    PinConfigs,
    // dashboard
    DashboardLayouts,
    DashboardCards,
    NotificationHistory,
    // tasks
    RecurringConfigs,
    Tasks,
    Tags,
    TaskTags,
    TimeBlocks,
    TaskTemplates,
    TaskTemplateItems,
    Subtasks,
    // habits
    Habits,
    HabitLogs,
    Routines,
    RoutineSteps,
    RoutineLogs,
    // gamification
    XpEvents,
    BadgeDefinitions,
    UserBadges,
    Streaks,
    // calendar
    CalendarEvents,
    // focus
    FocusSessions,
    FocusSettings,
    // sleep + alarms
    SleepLogs,
    SleepSettings,
    Alarms,
    // wellness
    MoodLogs,
    EnergyLogs,
    WaterLogs,
    WorkoutLogs,
    WorkoutSets,
    BreathingSessions,
    DailyStepLogs,
    // goals
    Goals,
    Milestones,
    GoalHabitLinks,
    GoalTaskLinks,
    LifeAreaScores,
    WeeklyReports,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'ryve_local');
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 3) {
            await m.createTable(moodLogs);
            await m.createTable(energyLogs);
            await m.createTable(waterLogs);
            await m.createTable(workoutLogs);
            await m.createTable(workoutSets);
            await m.createTable(breathingSessions);
            await m.createTable(dailyStepLogs);
            await m.createTable(goals);
            await m.createTable(milestones);
            await m.createTable(goalHabitLinks);
            await m.createTable(goalTaskLinks);
            await m.createTable(lifeAreaScores);
            await m.createTable(weeklyReports);
          }
          if (from < 4) {
            // Firebase Auth dropped in favor of local email/password auth.
            // No real accounts existed pre-v4 (Firebase was never configured), so
            // the users table is safely recreated with the new passwordHash column.
            await m.deleteTable('users');
            await m.createTable(users);
          }
        },
      );
}
