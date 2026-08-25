// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todayAIPlanHash() => r'dbb706c9fde8da8231d35558b3ee7af96d4bc7ef';

/// See also [todayAIPlan].
@ProviderFor(todayAIPlan)
final todayAIPlanProvider = AutoDisposeFutureProvider<AIPlanModel?>.internal(
  todayAIPlan,
  name: r'todayAIPlanProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todayAIPlanHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayAIPlanRef = AutoDisposeFutureProviderRef<AIPlanModel?>;
String _$coachingInsightsHash() => r'539c172cda293c8484376675453d8c79b6f6ab36';

/// See also [coachingInsights].
@ProviderFor(coachingInsights)
final coachingInsightsProvider =
    AutoDisposeStreamProvider<List<CoachingInsightModel>>.internal(
  coachingInsights,
  name: r'coachingInsightsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$coachingInsightsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CoachingInsightsRef
    = AutoDisposeStreamProviderRef<List<CoachingInsightModel>>;
String _$aIPlannerNotifierHash() => r'10b89146afb9689093aa9b24a5f7cab0302cd5e0';

/// See also [AIPlannerNotifier].
@ProviderFor(AIPlannerNotifier)
final aIPlannerNotifierProvider =
    AutoDisposeAsyncNotifierProvider<AIPlannerNotifier, AIPlanModel?>.internal(
  AIPlannerNotifier.new,
  name: r'aIPlannerNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$aIPlannerNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AIPlannerNotifier = AutoDisposeAsyncNotifier<AIPlanModel?>;
String _$coachingInsightsNotifierHash() =>
    r'38756a38838422865cfab77bf08bba78ecf2d479';

/// See also [CoachingInsightsNotifier].
@ProviderFor(CoachingInsightsNotifier)
final coachingInsightsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<CoachingInsightsNotifier, void>.internal(
  CoachingInsightsNotifier.new,
  name: r'coachingInsightsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$coachingInsightsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CoachingInsightsNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
