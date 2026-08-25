import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hybrid_tracker/main.dart' show databaseProvider;
import 'package:hybrid_tracker/core/services/xp_service.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/profile/data/models/profile_model.dart';

part 'profile_providers.g.dart';

@riverpod
Future<ProfileModel> userProfile(Ref ref) async {
  final user = ref.watch(authStateProvider).value;
  if (user == null) {
    return const ProfileModel(
      userId: '',
      displayName: 'Guest',
      level: 1,
      xpTotal: 0,
      xpToNextLevel: 100,
    );
  }

  final db = ref.watch(databaseProvider);
  final xpService = ref.watch(xpServiceProvider);

  final totalXp = await xpService.getTotalXp();
  final level = levelFromXP(totalXp);
  final stats = await xpService.getUserStats();

  final focusSessions = await (db.select(db.focusSessions)
        ..where((f) =>
            f.userId.equals(user.uid) &
            f.sessionType.equals('work') &
            f.wasCompleted.equals(true)))
      .get();
  final focusMinutes = focusSessions.fold<int>(0, (sum, f) => sum + f.durationMinutes);

  return ProfileModel(
    userId: user.uid,
    displayName: user.displayName ?? 'Ryver',
    email: user.email,
    avatarUrl: user.photoURL,
    level: level,
    xpTotal: xpIntoCurrentLevel(totalXp),
    xpToNextLevel: xpNeededForNextLevel(totalXp),
    currentStreak: stats.currentStreak,
    bestStreak: stats.bestStreak,
    tasksCompleted: stats.tasksCompleted,
    habitsLogged: stats.habitLogsCount,
    focusHours: (focusMinutes / 60).round(),
  );
}

@riverpod
Future<List<BadgeModel>> userBadges(Ref ref) async {
  final userId = ref.watch(authStateProvider).valueOrNull?.uid ?? '';
  final db = ref.watch(databaseProvider);
  final xpService = ref.watch(xpServiceProvider);

  await xpService.seedBadgeDefinitionsIfNeeded();

  final definitions = await db.select(db.badgeDefinitions).get();
  final earned = await (db.select(db.userBadges)..where((b) => b.userId.equals(userId))).get();
  final earnedById = {for (final e in earned) e.badgeId: e};

  return definitions
      .map((d) => BadgeModel(
            id: d.id,
            name: d.name,
            description: d.description,
            iconEmoji: d.iconEmoji,
            category: d.category,
            rarity: d.rarity,
            isEarned: earnedById.containsKey(d.id),
            earnedAt: earnedById[d.id]?.earnedAt,
          ))
      .toList();
}

@riverpod
class XpNotifier extends _$XpNotifier {
  @override
  int build() => 0;

  Future<void> awardXp(
    int amount, {
    required String eventType,
    String? referenceId,
  }) async {
    state = state + amount;
  }
}
