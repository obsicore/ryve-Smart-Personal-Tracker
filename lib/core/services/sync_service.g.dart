// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$syncServiceHash() => r'253ffc25f333b1f805f94f4dc674d7d9b23f02ac';

/// See also [syncService].
@ProviderFor(syncService)
final syncServiceProvider = Provider<SyncService>.internal(
  syncService,
  name: r'syncServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$syncServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncServiceRef = ProviderRef<SyncService>;
String _$syncControllerHash() => r'e755892195d90216087e943dce4b7295f355888f';

/// See also [SyncController].
@ProviderFor(SyncController)
final syncControllerProvider =
    AutoDisposeNotifierProvider<SyncController, SyncStatus>.internal(
  SyncController.new,
  name: r'syncControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$syncControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SyncController = AutoDisposeNotifier<SyncStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
