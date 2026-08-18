// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wellness_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recentMoodLogsHash() => r'095a3b1d70d155650e1bab450338ea16d1f06a5c';

/// See also [recentMoodLogs].
@ProviderFor(recentMoodLogs)
final recentMoodLogsProvider =
    AutoDisposeStreamProvider<List<MoodLogModel>>.internal(
  recentMoodLogs,
  name: r'recentMoodLogsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recentMoodLogsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RecentMoodLogsRef = AutoDisposeStreamProviderRef<List<MoodLogModel>>;
String _$todayMoodHash() => r'6b03d513324c51d14d5324963de046a3d627fb80';

/// See also [todayMood].
@ProviderFor(todayMood)
final todayMoodProvider = AutoDisposeFutureProvider<MoodLogModel?>.internal(
  todayMood,
  name: r'todayMoodProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todayMoodHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayMoodRef = AutoDisposeFutureProviderRef<MoodLogModel?>;
String _$todayWaterLogsHash() => r'917ddca3664d22a25f4d740e99905cc77218225f';

/// See also [todayWaterLogs].
@ProviderFor(todayWaterLogs)
final todayWaterLogsProvider =
    AutoDisposeStreamProvider<List<WaterLogModel>>.internal(
  todayWaterLogs,
  name: r'todayWaterLogsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todayWaterLogsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayWaterLogsRef = AutoDisposeStreamProviderRef<List<WaterLogModel>>;
String _$todayStepsHash() => r'b36cc1c7765bccefc6e7b181569e4986b224f701';

/// See also [todaySteps].
@ProviderFor(todaySteps)
final todayStepsProvider = AutoDisposeFutureProvider<StepLogModel?>.internal(
  todaySteps,
  name: r'todayStepsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todayStepsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayStepsRef = AutoDisposeFutureProviderRef<StepLogModel?>;
String _$yesterdayStepsHash() => r'7e36961e47c5adacb7979f2b29122f9e13ca1534';

/// See also [yesterdaySteps].
@ProviderFor(yesterdaySteps)
final yesterdayStepsProvider =
    AutoDisposeFutureProvider<StepLogModel?>.internal(
  yesterdaySteps,
  name: r'yesterdayStepsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$yesterdayStepsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef YesterdayStepsRef = AutoDisposeFutureProviderRef<StepLogModel?>;
String _$recentWorkoutsHash() => r'4366b75eed75e86420496833af35d9ceca38470b';

/// See also [recentWorkouts].
@ProviderFor(recentWorkouts)
final recentWorkoutsProvider =
    AutoDisposeStreamProvider<List<WorkoutLogModel>>.internal(
  recentWorkouts,
  name: r'recentWorkoutsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recentWorkoutsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RecentWorkoutsRef = AutoDisposeStreamProviderRef<List<WorkoutLogModel>>;
String _$recentBreathingSessionsHash() =>
    r'04a1e329cbc9c97e09db1ddd1f25b9d0372c87c5';

/// See also [recentBreathingSessions].
@ProviderFor(recentBreathingSessions)
final recentBreathingSessionsProvider =
    AutoDisposeStreamProvider<List<BreathingSessionModel>>.internal(
  recentBreathingSessions,
  name: r'recentBreathingSessionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recentBreathingSessionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RecentBreathingSessionsRef
    = AutoDisposeStreamProviderRef<List<BreathingSessionModel>>;
String _$wellnessNotifierHash() => r'0a0e0f831beea9e3f90bfa643b6a010ec9532449';

/// See also [WellnessNotifier].
@ProviderFor(WellnessNotifier)
final wellnessNotifierProvider =
    AutoDisposeAsyncNotifierProvider<WellnessNotifier, void>.internal(
  WellnessNotifier.new,
  name: r'wellnessNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wellnessNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WellnessNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
