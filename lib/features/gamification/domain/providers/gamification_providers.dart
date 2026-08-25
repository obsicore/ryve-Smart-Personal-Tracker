import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hybrid_tracker/main.dart' show databaseProvider;
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/gamification/data/models/challenge_model.dart';
import 'package:hybrid_tracker/features/gamification/data/repositories/gamification_repository.dart';

part 'gamification_providers.g.dart';

final gamificationRepositoryProvider = Provider<GamificationRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return GamificationRepositoryImpl(db);
});

String _uid(Ref ref) => ref.watch(authStateProvider).valueOrNull?.uid ?? '';

@riverpod
Future<List<ChallengeModel>> allChallenges(Ref ref) {
  return ref.watch(gamificationRepositoryProvider).getChallenges(_uid(ref));
}

@riverpod
class ChallengeNotifier extends _$ChallengeNotifier {
  @override
  Future<void> build() async {}

  Future<void> join(String challengeId) async {
    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    await ref.read(gamificationRepositoryProvider).joinChallenge(userId, challengeId);
    ref.invalidate(allChallengesProvider);
  }
}
