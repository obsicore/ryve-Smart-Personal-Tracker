import 'dart:async';
import 'dart:math' as math;

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/main.dart' show databaseProvider;
import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/core/utils/wellness_constants.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';

part 'xp_service.g.dart';

const _uuid = Uuid();

enum XPEvent {
  taskComplete(10, 'task_complete'),
  habitLog(5, 'habit_log'),
  streakMaintain(3, 'streak_maintain'),
  focusSessionComplete(15, 'focus_session_complete'),
  moodLog(2, 'mood_log'),
  waterLog(2, 'water_log'),
  journalEntry(8, 'journal_entry');

  const XPEvent(this.amount, this.eventType);
  final int amount;
  final String eventType;
}

class XpAwardResult {
  const XpAwardResult({
    required this.amount,
    required this.newTotal,
    required this.leveledUp,
    required this.newLevel,
    required this.newlyEarnedBadgeIds,
  });

  final int amount;
  final int newTotal;
  final bool leveledUp;
  final int newLevel;
  final List<String> newlyEarnedBadgeIds;
}

/// Level curve: level N requires xpForLevel(N) cumulative XP.
/// xpForLevel(n) = 50 * (n-1)^2  →  level = floor(sqrt(total/50)) + 1.
/// Computed via integer search rather than `sqrt` — float rounding at a
/// perfect-square boundary could otherwise show a level one lower than
/// the formula intends for large XP totals.
int xpForLevel(int level) => 50 * (level - 1) * (level - 1);

int levelFromXP(int totalXp) {
  if (totalXp <= 0) return 1;
  var level = 1;
  while (xpForLevel(level + 1) <= totalXp) {
    level++;
  }
  return level;
}

int xpIntoCurrentLevel(int totalXp) {
  final level = levelFromXP(totalXp);
  return totalXp - xpForLevel(level);
}

int xpNeededForNextLevel(int totalXp) {
  final level = levelFromXP(totalXp);
  return xpForLevel(level + 1) - xpForLevel(level);
}

const _defaultBadges = <(String id, String name, String description, String emoji, String category, String requirement, int rarity, int xpReward)>[
  ('1', 'First Step', 'Complete your first task', '👟', 'tasks', 'tasks_completed>=1', 1, 10),
  ('2', 'Habit Starter', 'Log a habit for 3 days', '🌱', 'habits', 'habit_logs>=3', 1, 10),
  ('3', 'Week Warrior', '7-day streak', '⚔️', 'streaks', 'best_streak>=7', 2, 25),
  ('4', 'Focus Master', 'Complete 10 focus sessions', '🎯', 'focus', 'focus_sessions>=10', 2, 25),
  ('5', 'Century Club', '100-day streak', '💯', 'streaks', 'best_streak>=100', 4, 100),
  ('6', 'Task Machine', 'Complete 100 tasks', '⚡', 'tasks', 'tasks_completed>=100', 3, 50),
];

class UserStats {
  const UserStats({
    required this.tasksCompleted,
    required this.habitLogsCount,
    required this.bestStreak,
    required this.currentStreak,
    required this.focusSessionsCompleted,
  });

  final int tasksCompleted;
  final int habitLogsCount;
  final int bestStreak;
  final int currentStreak;
  final int focusSessionsCompleted;
}

class XPService {
  XPService(this._db, this._userId);

  final AppDatabase _db;
  final String _userId;

  final _xpEarnedController = StreamController<int>.broadcast();
  final _levelUpController = StreamController<int>.broadcast();

  Stream<int> get xpEarnedStream => _xpEarnedController.stream;
  Stream<int> get levelUpStream => _levelUpController.stream;

  void dispose() {
    _xpEarnedController.close();
    _levelUpController.close();
  }

  Future<int> getTotalXp() async {
    final rows = await (_db.select(_db.xpEvents)
          ..where((x) => x.userId.equals(_userId)))
        .get();
    return rows.fold<int>(0, (sum, r) => sum + r.xpAmount);
  }

  Future<UserStats> getUserStats() async {
    final tasks = await (_db.select(_db.tasks)
          ..where((t) => t.userId.equals(_userId) & t.isCompleted.equals(true)))
        .get();
    final habitLogs = await (_db.select(_db.habitLogs)
          ..where((h) => h.userId.equals(_userId)))
        .get();
    final habits = await (_db.select(_db.habits)
          ..where((h) => h.userId.equals(_userId)))
        .get();
    final focusSessions = await (_db.select(_db.focusSessions)
          ..where((f) =>
              f.userId.equals(_userId) &
              f.sessionType.equals('work') &
              f.wasCompleted.equals(true)))
        .get();

    int bestStreak = 0;
    int currentStreak = 0;
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    for (final h in habits) {
      final logDates = habitLogs
          .where((l) => l.habitId == h.id)
          .map((l) => DateTime(l.logDate.year, l.logDate.month, l.logDate.day))
          .toSet();
      final streak = _longestStreak(logDates);
      if (streak > bestStreak) bestStreak = streak;
      final current = _currentStreak(logDates, todayOnly);
      if (current > currentStreak) currentStreak = current;
    }

    return UserStats(
      tasksCompleted: tasks.length,
      habitLogsCount: habitLogs.length,
      bestStreak: bestStreak,
      currentStreak: currentStreak,
      focusSessionsCompleted: focusSessions.length,
    );
  }

  int _currentStreak(Set<DateTime> dates, DateTime todayOnly) {
    var streak = 0;
    var check = todayOnly;
    while (dates.contains(check) && streak <= 365) {
      streak++;
      check = check.subtract(const Duration(days: 1));
    }
    return streak;
  }

  int _longestStreak(Set<DateTime> dates) {
    if (dates.isEmpty) return 0;
    final sorted = dates.toList()..sort();
    var longest = 1;
    var current = 1;
    for (var i = 1; i < sorted.length; i++) {
      if (sorted[i].difference(sorted[i - 1]).inDays == 1) {
        current++;
        longest = math.max(longest, current);
      } else {
        current = 1;
      }
    }
    return longest;
  }

  Future<void> seedBadgeDefinitionsIfNeeded() async {
    final existing = await _db.select(_db.badgeDefinitions).get();
    if (existing.isNotEmpty) return;
    for (final b in _defaultBadges) {
      await _db.into(_db.badgeDefinitions).insertOnConflictUpdate(
            BadgeDefinitionsCompanion.insert(
              id: b.$1,
              name: b.$2,
              description: b.$3,
              iconEmoji: b.$4,
              category: b.$5,
              requirement: b.$6,
              rarity: Value(b.$7),
              xpReward: Value(b.$8),
            ),
          );
    }
  }

  Future<XpAwardResult> award(
    XPEvent event, {
    String? entityId,
    String? description,
    int? metricValue,
  }) async {
    final oldTotal = await getTotalXp();
    final oldLevel = levelFromXP(oldTotal);

    await _db.into(_db.xpEvents).insert(
          XpEventsCompanion.insert(
            id: _uuid.v4(),
            userId: _userId,
            eventType: event.eventType,
            xpAmount: event.amount,
            referenceId: Value(entityId),
          ),
        );

    final newTotal = oldTotal + event.amount;
    final newLevel = levelFromXP(newTotal);
    final leveledUp = newLevel > oldLevel;

    _xpEarnedController.add(event.amount);
    if (leveledUp) {
      _levelUpController.add(newLevel);
    }

    final newlyEarned = await _checkBadgeUnlocks();
    await _updateChallengeProgress(event, entityId: entityId, metricValue: metricValue);

    return XpAwardResult(
      amount: event.amount,
      newTotal: newTotal,
      leveledUp: leveledUp,
      newLevel: newLevel,
      newlyEarnedBadgeIds: newlyEarned,
    );
  }

  Future<List<String>> _checkBadgeUnlocks() async {
    await seedBadgeDefinitionsIfNeeded();
    final stats = await getUserStats();
    final earned = await (_db.select(_db.userBadges)
          ..where((u) => u.userId.equals(_userId)))
        .get();
    final earnedIds = earned.map((e) => e.badgeId).toSet();

    final newlyEarned = <String>[];
    for (final b in _defaultBadges) {
      if (earnedIds.contains(b.$1)) continue;
      if (!_meetsRequirement(b.$6, stats)) continue;

      // insertOrIgnore + the (userId, badgeId) unique constraint means a
      // concurrent award() call that already granted this badge makes this
      // insert a no-op (rowid 0) instead of double-granting the xp_reward.
      final rowId = await _db.into(_db.userBadges).insert(
            UserBadgesCompanion.insert(
              id: _uuid.v4(),
              userId: _userId,
              badgeId: b.$1,
              earnedAt: DateTime.now(),
            ),
            mode: InsertMode.insertOrIgnore,
          );
      if (rowId == 0) continue;

      if (b.$8 > 0) {
        await _db.into(_db.xpEvents).insert(
              XpEventsCompanion.insert(
                id: _uuid.v4(),
                userId: _userId,
                eventType: 'badge_bonus',
                xpAmount: b.$8,
                referenceId: Value(b.$1),
              ),
            );
      }
      newlyEarned.add(b.$1);
    }
    return newlyEarned;
  }

  bool _meetsRequirement(String requirement, UserStats stats) {
    final match = RegExp(r'^(\w+)>=(\d+)$').firstMatch(requirement);
    if (match == null) return false;
    final field = match.group(1);
    final threshold = int.parse(match.group(2)!);
    final value = switch (field) {
      'tasks_completed' => stats.tasksCompleted,
      'habit_logs' => stats.habitLogsCount,
      'best_streak' => stats.bestStreak,
      'focus_sessions' => stats.focusSessionsCompleted,
      _ => 0,
    };
    return value >= threshold;
  }

  Future<void> _updateChallengeProgress(
    XPEvent event, {
    String? entityId,
    int? metricValue,
  }) async {
    final userChallenges = await (_db.select(_db.userChallenges)
          ..where((c) => c.userId.equals(_userId) & c.status.equals('active')))
        .get();
    if (userChallenges.isEmpty) return;
    final stats = await getUserStats();

    for (final uc in userChallenges) {
      final challenge = await (_db.select(_db.challenges)
            ..where((c) => c.id.equals(uc.challengeId)))
          .getSingleOrNull();
      if (challenge == null) continue;

      int? newValue;
      switch (challenge.challengeType) {
        case 'habit_streak':
          // Live streak, not the historic best — a streak that broke
          // months ago shouldn't instantly complete a fresh join.
          newValue = stats.currentStreak;
        case 'tasks_complete':
          newValue = stats.tasksCompleted;
        case 'focus_minutes':
          if (event == XPEvent.focusSessionComplete) {
            newValue = uc.currentValue + (metricValue ?? 0);
          }
        case 'water_goal_hit':
          if (event == XPEvent.waterLog) {
            final afterTotal = await _waterTotalForToday();
            final beforeTotal = entityId == null
                ? afterTotal
                : await _waterTotalForToday(excludeLogId: entityId);
            // Only count the day it first crosses the goal, not every log.
            if (beforeTotal < defaultWaterGoalMl && afterTotal >= defaultWaterGoalMl) {
              newValue = uc.currentValue + 1;
            }
          }
      }
      if (newValue == null) continue;

      final isDone = newValue >= challenge.targetValue;
      await (_db.update(_db.userChallenges)..where((c) => c.id.equals(uc.id))).write(
        UserChallengesCompanion(
          currentValue: Value(newValue),
          status: Value(isDone ? 'completed' : 'active'),
          completedAt: Value(isDone ? DateTime.now() : null),
        ),
      );
      if (isDone && challenge.xpReward > 0) {
        await _db.into(_db.xpEvents).insert(
              XpEventsCompanion.insert(
                id: _uuid.v4(),
                userId: _userId,
                eventType: 'challenge_reward',
                xpAmount: challenge.xpReward,
                referenceId: Value(challenge.id),
              ),
            );
      }
    }
  }

  Future<int> _waterTotalForToday({String? excludeLogId}) async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final rows = await (_db.select(_db.waterLogs)
          ..where((l) => l.userId.equals(_userId) & l.logDate.isBiggerOrEqualValue(todayStart)))
        .get();
    return rows
        .where((r) => r.id != excludeLogId)
        .fold<int>(0, (sum, r) => sum + r.amountMl);
  }

  Future<Streak?> _getStreakRow(String entityType, String? entityId) async {
    final query = _db.select(_db.streaks)
      ..where((s) => s.userId.equals(_userId) & s.streakType.equals(entityType));
    if (entityId != null) {
      query.where((s) => s.referenceId.equals(entityId));
    }
    return query.getSingleOrNull();
  }

  Future<bool> useStreakFreeze({required String entityType, String? entityId}) async {
    final row = await _getStreakRow(entityType, entityId);
    if (row == null || row.freezeTokens <= 0) return false;
    await (_db.update(_db.streaks)..where((s) => s.id.equals(row.id))).write(
      StreaksCompanion(freezeTokens: Value(row.freezeTokens - 1)),
    );
    return true;
  }

  Future<bool> purchaseFreezeToken({required String entityType, String? entityId}) async {
    final totalXp = await getTotalXp();
    if (totalXp < 100) return false;

    var row = await _getStreakRow(entityType, entityId);
    if (row != null && row.freezeTokens >= 2) return false;

    await _db.into(_db.xpEvents).insert(
          XpEventsCompanion.insert(
            id: _uuid.v4(),
            userId: _userId,
            eventType: 'freeze_token_purchase',
            xpAmount: -100,
            referenceId: Value(entityId),
          ),
        );

    if (row == null) {
      await _db.into(_db.streaks).insert(
            StreaksCompanion.insert(
              id: _uuid.v4(),
              userId: _userId,
              streakType: entityType,
              referenceId: Value(entityId),
              freezeTokens: const Value(1),
            ),
          );
    } else {
      await (_db.update(_db.streaks)..where((s) => s.id.equals(row.id))).write(
        StreaksCompanion(freezeTokens: Value(row.freezeTokens + 1)),
      );
    }
    return true;
  }
}

final xpServiceProvider = Provider<XPService>((ref) {
  final db = ref.watch(databaseProvider);
  final userId = ref.watch(authStateProvider).valueOrNull?.uid ?? '';
  final service = XPService(db, userId);
  ref.onDispose(service.dispose);
  return service;
});

@riverpod
Stream<int> xpEarnedEvents(Ref ref) {
  return ref.watch(xpServiceProvider).xpEarnedStream;
}

@riverpod
Stream<int> levelUpEvents(Ref ref) {
  return ref.watch(xpServiceProvider).levelUpStream;
}
