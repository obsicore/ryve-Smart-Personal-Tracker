// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allChallengesHash() => r'7b66bc25c8fbe548515eea06ef7f1c1c7e43d92f';

/// See also [allChallenges].
@ProviderFor(allChallenges)
final allChallengesProvider =
    AutoDisposeFutureProvider<List<ChallengeModel>>.internal(
  allChallenges,
  name: r'allChallengesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allChallengesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllChallengesRef = AutoDisposeFutureProviderRef<List<ChallengeModel>>;
String _$challengeNotifierHash() => r'c6872f8ba5bd169de37f14328d196faace266f59';

/// See also [ChallengeNotifier].
@ProviderFor(ChallengeNotifier)
final challengeNotifierProvider =
    AutoDisposeAsyncNotifierProvider<ChallengeNotifier, void>.internal(
  ChallengeNotifier.new,
  name: r'challengeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$challengeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChallengeNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
