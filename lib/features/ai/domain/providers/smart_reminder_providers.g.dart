// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_reminder_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$smartRemindersHash() => r'd526563bd7f461006a5bc6315a7df74a61a163c8';

/// See also [smartReminders].
@ProviderFor(smartReminders)
final smartRemindersProvider =
    AutoDisposeStreamProvider<List<SmartReminderModel>>.internal(
  smartReminders,
  name: r'smartRemindersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$smartRemindersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SmartRemindersRef
    = AutoDisposeStreamProviderRef<List<SmartReminderModel>>;
String _$locationTriggersHash() => r'2991b1bee78fac89c2eabfefe2ad044962fc7590';

/// See also [locationTriggers].
@ProviderFor(locationTriggers)
final locationTriggersProvider =
    AutoDisposeStreamProvider<List<LocationTriggerModel>>.internal(
  locationTriggers,
  name: r'locationTriggersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationTriggersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocationTriggersRef
    = AutoDisposeStreamProviderRef<List<LocationTriggerModel>>;
String _$smartReminderNotifierHash() =>
    r'075a7a3e9625ff011a1cc3400178bbcbf8ccae95';

/// See also [SmartReminderNotifier].
@ProviderFor(SmartReminderNotifier)
final smartReminderNotifierProvider =
    AutoDisposeNotifierProvider<SmartReminderNotifier, void>.internal(
  SmartReminderNotifier.new,
  name: r'smartReminderNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$smartReminderNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SmartReminderNotifier = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
