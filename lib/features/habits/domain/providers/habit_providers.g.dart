// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allHabitsHash() => r'88ce82d82219163f151cb7730b0603cd941699ce';

/// See also [allHabits].
@ProviderFor(allHabits)
final allHabitsProvider = AutoDisposeStreamProvider<List<HabitModel>>.internal(
  allHabits,
  name: r'allHabitsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allHabitsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllHabitsRef = AutoDisposeStreamProviderRef<List<HabitModel>>;
String _$habitByIdHash() => r'68d4057867589d9c5f68ae1d7544f9dcc4b71b6f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [habitById].
@ProviderFor(habitById)
const habitByIdProvider = HabitByIdFamily();

/// See also [habitById].
class HabitByIdFamily extends Family<AsyncValue<HabitModel?>> {
  /// See also [habitById].
  const HabitByIdFamily();

  /// See also [habitById].
  HabitByIdProvider call(
    String id,
  ) {
    return HabitByIdProvider(
      id,
    );
  }

  @override
  HabitByIdProvider getProviderOverride(
    covariant HabitByIdProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'habitByIdProvider';
}

/// See also [habitById].
class HabitByIdProvider extends AutoDisposeFutureProvider<HabitModel?> {
  /// See also [habitById].
  HabitByIdProvider(
    String id,
  ) : this._internal(
          (ref) => habitById(
            ref as HabitByIdRef,
            id,
          ),
          from: habitByIdProvider,
          name: r'habitByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$habitByIdHash,
          dependencies: HabitByIdFamily._dependencies,
          allTransitiveDependencies: HabitByIdFamily._allTransitiveDependencies,
          id: id,
        );

  HabitByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<HabitModel?> Function(HabitByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HabitByIdProvider._internal(
        (ref) => create(ref as HabitByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<HabitModel?> createElement() {
    return _HabitByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HabitByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HabitByIdRef on AutoDisposeFutureProviderRef<HabitModel?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _HabitByIdProviderElement
    extends AutoDisposeFutureProviderElement<HabitModel?> with HabitByIdRef {
  _HabitByIdProviderElement(super.provider);

  @override
  String get id => (origin as HabitByIdProvider).id;
}

String _$habitLogsHash() => r'07782ba6b8f50f47a24cc1bbca3e334a9bf32d19';

/// See also [habitLogs].
@ProviderFor(habitLogs)
const habitLogsProvider = HabitLogsFamily();

/// See also [habitLogs].
class HabitLogsFamily extends Family<AsyncValue<List<HabitLogModel>>> {
  /// See also [habitLogs].
  const HabitLogsFamily();

  /// See also [habitLogs].
  HabitLogsProvider call(
    String habitId,
  ) {
    return HabitLogsProvider(
      habitId,
    );
  }

  @override
  HabitLogsProvider getProviderOverride(
    covariant HabitLogsProvider provider,
  ) {
    return call(
      provider.habitId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'habitLogsProvider';
}

/// See also [habitLogs].
class HabitLogsProvider extends AutoDisposeFutureProvider<List<HabitLogModel>> {
  /// See also [habitLogs].
  HabitLogsProvider(
    String habitId,
  ) : this._internal(
          (ref) => habitLogs(
            ref as HabitLogsRef,
            habitId,
          ),
          from: habitLogsProvider,
          name: r'habitLogsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$habitLogsHash,
          dependencies: HabitLogsFamily._dependencies,
          allTransitiveDependencies: HabitLogsFamily._allTransitiveDependencies,
          habitId: habitId,
        );

  HabitLogsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.habitId,
  }) : super.internal();

  final String habitId;

  @override
  Override overrideWith(
    FutureOr<List<HabitLogModel>> Function(HabitLogsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HabitLogsProvider._internal(
        (ref) => create(ref as HabitLogsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        habitId: habitId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<HabitLogModel>> createElement() {
    return _HabitLogsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HabitLogsProvider && other.habitId == habitId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, habitId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HabitLogsRef on AutoDisposeFutureProviderRef<List<HabitLogModel>> {
  /// The parameter `habitId` of this provider.
  String get habitId;
}

class _HabitLogsProviderElement
    extends AutoDisposeFutureProviderElement<List<HabitLogModel>>
    with HabitLogsRef {
  _HabitLogsProviderElement(super.provider);

  @override
  String get habitId => (origin as HabitLogsProvider).habitId;
}

String _$habitNotifierHash() => r'284f8a5f4567b2fdb0710e15c43d6a958b3e8858';

/// See also [HabitNotifier].
@ProviderFor(HabitNotifier)
final habitNotifierProvider =
    AutoDisposeAsyncNotifierProvider<HabitNotifier, void>.internal(
  HabitNotifier.new,
  name: r'habitNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$habitNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HabitNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
