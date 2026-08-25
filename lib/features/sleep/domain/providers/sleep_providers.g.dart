// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recentSleepLogsHash() => r'802ec44e242eb0ef1b7f9b3b74d1b7235161bbd3';

/// See also [recentSleepLogs].
@ProviderFor(recentSleepLogs)
final recentSleepLogsProvider =
    AutoDisposeStreamProvider<List<SleepLogModel>>.internal(
  recentSleepLogs,
  name: r'recentSleepLogsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recentSleepLogsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RecentSleepLogsRef = AutoDisposeStreamProviderRef<List<SleepLogModel>>;
String _$alarmsHash() => r'b4dc938434e7f91e0cf3f86e6478d6fce452b63a';

/// See also [alarms].
@ProviderFor(alarms)
final alarmsProvider = AutoDisposeStreamProvider<List<AlarmModel>>.internal(
  alarms,
  name: r'alarmsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$alarmsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AlarmsRef = AutoDisposeStreamProviderRef<List<AlarmModel>>;
String _$lastSleepLogHash() => r'cd5fa897b4ef6e667d0cc5a2b52d51f1ef0a4aec';

/// See also [lastSleepLog].
@ProviderFor(lastSleepLog)
final lastSleepLogProvider = AutoDisposeFutureProvider<SleepLogModel?>.internal(
  lastSleepLog,
  name: r'lastSleepLogProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$lastSleepLogHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LastSleepLogRef = AutoDisposeFutureProviderRef<SleepLogModel?>;
String _$sleepNotifierHash() => r'f22a8016b89fe6d46ebc5e1b8447ac15e2e268c4';

/// See also [SleepNotifier].
@ProviderFor(SleepNotifier)
final sleepNotifierProvider =
    AutoDisposeAsyncNotifierProvider<SleepNotifier, void>.internal(
  SleepNotifier.new,
  name: r'sleepNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sleepNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SleepNotifier = AutoDisposeAsyncNotifier<void>;
String _$alarmNotifierHash() => r'782fcff97f2e5161aed2b20fec191f2f1461e049';

/// See also [AlarmNotifier].
@ProviderFor(AlarmNotifier)
final alarmNotifierProvider =
    AutoDisposeAsyncNotifierProvider<AlarmNotifier, void>.internal(
  AlarmNotifier.new,
  name: r'alarmNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$alarmNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AlarmNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
