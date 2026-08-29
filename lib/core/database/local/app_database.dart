import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'secure_db_key.dart';

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
import 'tables/journal_tables.dart';
import 'tables/ai_tables.dart';
import 'tables/social_tables.dart';
import 'tables/sync_tables.dart';

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
    // journal
    JournalEntries,
    JournalMedia,
    GratitudeLogs,
    ReflectionPrompts,
    ReflectionResponses,
    // AI
    AiPlans,
    AiPlanItems,
    SmartReminders,
    LocationTriggers,
    CoachingInsights,
    // gamification (phase 4 additions)
    Challenges,
    UserChallenges,
    ChallengeEntries,
    // social (phase 5)
    Partners,
    PartnerCheckIns,
    CommunityChallenges,
    CommunityParticipants,
    // customization + sync (phase 5)
    AppThemes,
    WidgetConfigs,
    SyncMeta,
    SyncQueue,
    BackupManifests,
    EncryptionConfigs,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @visibleForTesting
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 10;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'ryve_local.sqlite'));
      final passphrase = await SecureDbKey.getOrCreate();

      return NativeDatabase.createInBackground(
        file,
        isolateSetup: () async {
          if (Platform.isAndroid) {
            open.overrideFor(OperatingSystem.android, openCipherOnAndroid);
          }
        },
        setup: (db) {
          db.execute("PRAGMA key = '$passphrase';");
          try {
            db.select('SELECT count(*) FROM sqlite_master;');
          } catch (_) {
            db.execute("PRAGMA key = '';");
            db.execute("PRAGMA rekey = '$passphrase';");
          }
        },
      );
    });
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(calendarEvents);
            await m.createTable(focusSessions);
            await m.createTable(focusSettings);
            await m.createTable(sleepLogs);
            await m.createTable(sleepSettings);
            await m.createTable(alarms);
          }
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
          if (from < 5) {
            await m.createTable(journalEntries);
            await m.createTable(journalMedia);
            await m.createTable(gratitudeLogs);
            await m.createTable(reflectionPrompts);
            await m.createTable(reflectionResponses);
            await m.createTable(aiPlans);
            await m.createTable(aiPlanItems);
            await m.createTable(smartReminders);
            await m.createTable(coachingInsights);
            await m.createTable(challenges);
            await m.createTable(userChallenges);
            await m.createTable(challengeEntries);
            await m.addColumn(streaks, streaks.freezeTokens);
            await m.addColumn(badgeDefinitions, badgeDefinitions.xpReward);
          }
          if (from < 6) {
            await m.createTable(partners);
            await m.createTable(partnerCheckIns);
            await m.createTable(communityChallenges);
            await m.createTable(communityParticipants);
            await m.createTable(appThemes);
            await m.createTable(widgetConfigs);
            await m.createTable(syncMeta);
            await m.createTable(syncQueue);
            await m.createTable(backupManifests);
            await m.createTable(encryptionConfigs);
            await m.addColumn(userProfiles, userProfiles.activeThemeId);
            await m.addColumn(pinConfigs, pinConfigs.failedAttempts);
            await m.addColumn(pinConfigs, pinConfigs.lockedUntil);
          }
          if (from < 7) {
            // Passwords/PINs were unsalted SHA-256 before v7 — trivially
            // reversible for a 6-digit PIN's 1M-value space. No real users
            // exist yet, so recreate both tables with the new salt columns
            // (same precedent as the v3->v4 Firebase-removal migration)
            // rather than pretending old unsalted hashes are safe to keep.
            await m.deleteTable('users');
            await m.createTable(users);
            await m.deleteTable('pin_configs');
            await m.createTable(pinConfigs);
            // Recreate user_badges with the new (user_id, badge_id) unique
            // constraint; INSERT OR IGNORE collapses any pre-existing
            // duplicate grants from the double-award race down to one row.
            await m.issueCustomQuery('ALTER TABLE user_badges RENAME TO user_badges_old');
            await m.createTable(userBadges);
            await m.issueCustomQuery(
              'INSERT OR IGNORE INTO user_badges (id, user_id, badge_id, earned_at, sync_status) '
              'SELECT id, user_id, badge_id, earned_at, sync_status FROM user_badges_old',
            );
            await m.issueCustomQuery('DROP TABLE user_badges_old');
          }
          if (from < 8) {
            await m.createTable(locationTriggers);
          }
          if (from < 9) {
            await m.addColumn(tasks, tasks.reminderMinutesBefore);
          }
          if (from < 10) {
            await m.addColumn(alarms, alarms.mathLevel);
            await m.addColumn(alarms, alarms.mathProblemCount);
          }
        },
      );
}
