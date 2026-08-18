// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userProfileHash() => r'a2529446b3a9eceb53b49f4544390912f39a99cc';

/// See also [userProfile].
@ProviderFor(userProfile)
final userProfileProvider = AutoDisposeFutureProvider<ProfileModel>.internal(
  userProfile,
  name: r'userProfileProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserProfileRef = AutoDisposeFutureProviderRef<ProfileModel>;
String _$userBadgesHash() => r'48e91ecb6249811489e5d50c4f85c0bfc7d0276a';

/// See also [userBadges].
@ProviderFor(userBadges)
final userBadgesProvider = AutoDisposeFutureProvider<List<BadgeModel>>.internal(
  userBadges,
  name: r'userBadgesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userBadgesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserBadgesRef = AutoDisposeFutureProviderRef<List<BadgeModel>>;
String _$xpNotifierHash() => r'0dd5f2c878785e47da12fef8b62ec7c6b8ccb8d7';

/// See also [XpNotifier].
@ProviderFor(XpNotifier)
final xpNotifierProvider =
    AutoDisposeNotifierProvider<XpNotifier, int>.internal(
  XpNotifier.new,
  name: r'xpNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$xpNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$XpNotifier = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
