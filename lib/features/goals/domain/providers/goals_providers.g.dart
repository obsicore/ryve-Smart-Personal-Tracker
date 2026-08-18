// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allGoalsHash() => r'f6cd93a1f00da0f65a528025b25ed67597108983';

/// See also [allGoals].
@ProviderFor(allGoals)
final allGoalsProvider = AutoDisposeStreamProvider<List<GoalModel>>.internal(
  allGoals,
  name: r'allGoalsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allGoalsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllGoalsRef = AutoDisposeStreamProviderRef<List<GoalModel>>;
String _$goalsByLifeAreaHash() => r'bcd9b172b941610771e427a2c44fa2c96ead436e';

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

/// See also [goalsByLifeArea].
@ProviderFor(goalsByLifeArea)
const goalsByLifeAreaProvider = GoalsByLifeAreaFamily();

/// See also [goalsByLifeArea].
class GoalsByLifeAreaFamily extends Family<AsyncValue<List<GoalModel>>> {
  /// See also [goalsByLifeArea].
  const GoalsByLifeAreaFamily();

  /// See also [goalsByLifeArea].
  GoalsByLifeAreaProvider call(
    String lifeArea,
  ) {
    return GoalsByLifeAreaProvider(
      lifeArea,
    );
  }

  @override
  GoalsByLifeAreaProvider getProviderOverride(
    covariant GoalsByLifeAreaProvider provider,
  ) {
    return call(
      provider.lifeArea,
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
  String? get name => r'goalsByLifeAreaProvider';
}

/// See also [goalsByLifeArea].
class GoalsByLifeAreaProvider
    extends AutoDisposeStreamProvider<List<GoalModel>> {
  /// See also [goalsByLifeArea].
  GoalsByLifeAreaProvider(
    String lifeArea,
  ) : this._internal(
          (ref) => goalsByLifeArea(
            ref as GoalsByLifeAreaRef,
            lifeArea,
          ),
          from: goalsByLifeAreaProvider,
          name: r'goalsByLifeAreaProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$goalsByLifeAreaHash,
          dependencies: GoalsByLifeAreaFamily._dependencies,
          allTransitiveDependencies:
              GoalsByLifeAreaFamily._allTransitiveDependencies,
          lifeArea: lifeArea,
        );

  GoalsByLifeAreaProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lifeArea,
  }) : super.internal();

  final String lifeArea;

  @override
  Override overrideWith(
    Stream<List<GoalModel>> Function(GoalsByLifeAreaRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GoalsByLifeAreaProvider._internal(
        (ref) => create(ref as GoalsByLifeAreaRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lifeArea: lifeArea,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<GoalModel>> createElement() {
    return _GoalsByLifeAreaProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GoalsByLifeAreaProvider && other.lifeArea == lifeArea;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lifeArea.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GoalsByLifeAreaRef on AutoDisposeStreamProviderRef<List<GoalModel>> {
  /// The parameter `lifeArea` of this provider.
  String get lifeArea;
}

class _GoalsByLifeAreaProviderElement
    extends AutoDisposeStreamProviderElement<List<GoalModel>>
    with GoalsByLifeAreaRef {
  _GoalsByLifeAreaProviderElement(super.provider);

  @override
  String get lifeArea => (origin as GoalsByLifeAreaProvider).lifeArea;
}

String _$goalByIdHash() => r'78fab5335714375c97d1ecff1f57cea1407e2896';

/// See also [goalById].
@ProviderFor(goalById)
const goalByIdProvider = GoalByIdFamily();

/// See also [goalById].
class GoalByIdFamily extends Family<AsyncValue<GoalModel?>> {
  /// See also [goalById].
  const GoalByIdFamily();

  /// See also [goalById].
  GoalByIdProvider call(
    String id,
  ) {
    return GoalByIdProvider(
      id,
    );
  }

  @override
  GoalByIdProvider getProviderOverride(
    covariant GoalByIdProvider provider,
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
  String? get name => r'goalByIdProvider';
}

/// See also [goalById].
class GoalByIdProvider extends AutoDisposeFutureProvider<GoalModel?> {
  /// See also [goalById].
  GoalByIdProvider(
    String id,
  ) : this._internal(
          (ref) => goalById(
            ref as GoalByIdRef,
            id,
          ),
          from: goalByIdProvider,
          name: r'goalByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$goalByIdHash,
          dependencies: GoalByIdFamily._dependencies,
          allTransitiveDependencies: GoalByIdFamily._allTransitiveDependencies,
          id: id,
        );

  GoalByIdProvider._internal(
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
    FutureOr<GoalModel?> Function(GoalByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GoalByIdProvider._internal(
        (ref) => create(ref as GoalByIdRef),
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
  AutoDisposeFutureProviderElement<GoalModel?> createElement() {
    return _GoalByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GoalByIdProvider && other.id == id;
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
mixin GoalByIdRef on AutoDisposeFutureProviderRef<GoalModel?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _GoalByIdProviderElement
    extends AutoDisposeFutureProviderElement<GoalModel?> with GoalByIdRef {
  _GoalByIdProviderElement(super.provider);

  @override
  String get id => (origin as GoalByIdProvider).id;
}

String _$latestLifeAreaScoreHash() =>
    r'393dca6c1326785235d4ba68ac7c76628d4f910b';

/// See also [latestLifeAreaScore].
@ProviderFor(latestLifeAreaScore)
final latestLifeAreaScoreProvider =
    AutoDisposeFutureProvider<LifeAreaScoreModel?>.internal(
  latestLifeAreaScore,
  name: r'latestLifeAreaScoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$latestLifeAreaScoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LatestLifeAreaScoreRef
    = AutoDisposeFutureProviderRef<LifeAreaScoreModel?>;
String _$latestWeeklyReportHash() =>
    r'b5f1df8cc245ce98542a630a904cb63744733cc6';

/// See also [latestWeeklyReport].
@ProviderFor(latestWeeklyReport)
final latestWeeklyReportProvider =
    AutoDisposeFutureProvider<WeeklyReportModel?>.internal(
  latestWeeklyReport,
  name: r'latestWeeklyReportProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$latestWeeklyReportHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LatestWeeklyReportRef
    = AutoDisposeFutureProviderRef<WeeklyReportModel?>;
String _$goalNotifierHash() => r'4226d8f4f4a8bd65577ffbcf48ebc236b3880314';

/// See also [GoalNotifier].
@ProviderFor(GoalNotifier)
final goalNotifierProvider =
    AutoDisposeAsyncNotifierProvider<GoalNotifier, void>.internal(
  GoalNotifier.new,
  name: r'goalNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$goalNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GoalNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
