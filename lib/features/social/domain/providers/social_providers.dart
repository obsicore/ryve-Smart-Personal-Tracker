import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hybrid_tracker/core/services/neon_connection.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/social/data/models/community_challenge_model.dart';
import 'package:hybrid_tracker/features/social/data/models/partner_model.dart';
import 'package:hybrid_tracker/features/social/data/repositories/social_repository.dart';

part 'social_providers.g.dart';

final socialRepositoryProvider = Provider<SocialRepository>((ref) {
  final holder = ref.watch(neonConnectionHolderProvider);
  return SocialRepository(holder);
});

String _uid(Ref ref) => ref.watch(authStateProvider).value?.uid ?? '';
String _displayName(Ref ref) => ref.watch(authStateProvider).value?.displayName ?? 'Ryver';

@riverpod
Future<List<PartnerModel>> myPartners(Ref ref) {
  return ref.watch(socialRepositoryProvider).myPartners(_uid(ref));
}

@riverpod
Future<List<PartnerCheckInModel>> recentCheckIns(Ref ref) {
  return ref.watch(socialRepositoryProvider).recentCheckIns(_uid(ref));
}

@riverpod
Future<List<CommunityChallengeModel>> communityChallenges(Ref ref) {
  return ref.watch(socialRepositoryProvider).browseCommunityChallenges(_uid(ref));
}

@riverpod
class SocialActions extends _$SocialActions {
  @override
  void build() {}

  Future<String> createInvite() async {
    final code = await ref.read(socialRepositoryProvider).createInvite(_uid(ref));
    return code;
  }

  Future<void> redeemInvite(String code) async {
    await ref.read(socialRepositoryProvider).redeemInvite(_uid(ref), code);
    ref.invalidate(myPartnersProvider);
  }

  Future<void> checkIn(String partnershipId) async {
    await ref.read(socialRepositoryProvider).checkIn(partnershipId, _uid(ref), _displayName(ref));
    ref.invalidate(recentCheckInsProvider);
  }

  Future<void> joinChallenge(String challengeId) async {
    await ref.read(socialRepositoryProvider).joinCommunityChallenge(challengeId, _uid(ref), _displayName(ref));
    ref.invalidate(communityChallengesProvider);
  }
}
