// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todaySessionsHash() => r'01e63f2e80bb767b785d23cc17b9d30061c7e462';

/// See also [todaySessions].
@ProviderFor(todaySessions)
final todaySessionsProvider =
    AutoDisposeStreamProvider<List<FocusSessionModel>>.internal(
  todaySessions,
  name: r'todaySessionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todaySessionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodaySessionsRef
    = AutoDisposeStreamProviderRef<List<FocusSessionModel>>;
String _$focusSettingsHash() => r'7c159d6da65bf1894915e331b4ba1b643488347a';

/// See also [focusSettings].
@ProviderFor(focusSettings)
final focusSettingsProvider =
    AutoDisposeStreamProvider<FocusSettingsModel?>.internal(
  focusSettings,
  name: r'focusSettingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$focusSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FocusSettingsRef = AutoDisposeStreamProviderRef<FocusSettingsModel?>;
String _$focusStreakHash() => r'2cd74d027fb1e453e4ab553e84a69c27b75e6517';

/// See also [focusStreak].
@ProviderFor(focusStreak)
final focusStreakProvider = AutoDisposeFutureProvider<int>.internal(
  focusStreak,
  name: r'focusStreakProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$focusStreakHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FocusStreakRef = AutoDisposeFutureProviderRef<int>;
String _$focusTimerNotifierHash() =>
    r'15e60506e1bb1cf0bba06bec555d05f35d11ff3d';

/// See also [FocusTimerNotifier].
@ProviderFor(FocusTimerNotifier)
final focusTimerNotifierProvider =
    AutoDisposeNotifierProvider<FocusTimerNotifier, FocusTimerState>.internal(
  FocusTimerNotifier.new,
  name: r'focusTimerNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$focusTimerNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FocusTimerNotifier = AutoDisposeNotifier<FocusTimerState>;
String _$focusSettingsNotifierHash() =>
    r'756f9466192a425152e71c0771520745a94797fe';

/// See also [FocusSettingsNotifier].
@ProviderFor(FocusSettingsNotifier)
final focusSettingsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<FocusSettingsNotifier, void>.internal(
  FocusSettingsNotifier.new,
  name: r'focusSettingsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$focusSettingsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FocusSettingsNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
