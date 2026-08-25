// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$journalEntriesHash() => r'27ed01f48258db39cce6ba14a330d3b5c86ab60b';

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

/// See also [journalEntries].
@ProviderFor(journalEntries)
const journalEntriesProvider = JournalEntriesFamily();

/// See also [journalEntries].
class JournalEntriesFamily extends Family<AsyncValue<List<JournalEntryModel>>> {
  /// See also [journalEntries].
  const JournalEntriesFamily();

  /// See also [journalEntries].
  JournalEntriesProvider call({
    String? search,
  }) {
    return JournalEntriesProvider(
      search: search,
    );
  }

  @override
  JournalEntriesProvider getProviderOverride(
    covariant JournalEntriesProvider provider,
  ) {
    return call(
      search: provider.search,
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
  String? get name => r'journalEntriesProvider';
}

/// See also [journalEntries].
class JournalEntriesProvider
    extends AutoDisposeStreamProvider<List<JournalEntryModel>> {
  /// See also [journalEntries].
  JournalEntriesProvider({
    String? search,
  }) : this._internal(
          (ref) => journalEntries(
            ref as JournalEntriesRef,
            search: search,
          ),
          from: journalEntriesProvider,
          name: r'journalEntriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$journalEntriesHash,
          dependencies: JournalEntriesFamily._dependencies,
          allTransitiveDependencies:
              JournalEntriesFamily._allTransitiveDependencies,
          search: search,
        );

  JournalEntriesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.search,
  }) : super.internal();

  final String? search;

  @override
  Override overrideWith(
    Stream<List<JournalEntryModel>> Function(JournalEntriesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: JournalEntriesProvider._internal(
        (ref) => create(ref as JournalEntriesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        search: search,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<JournalEntryModel>> createElement() {
    return _JournalEntriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JournalEntriesProvider && other.search == search;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, search.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin JournalEntriesRef
    on AutoDisposeStreamProviderRef<List<JournalEntryModel>> {
  /// The parameter `search` of this provider.
  String? get search;
}

class _JournalEntriesProviderElement
    extends AutoDisposeStreamProviderElement<List<JournalEntryModel>>
    with JournalEntriesRef {
  _JournalEntriesProviderElement(super.provider);

  @override
  String? get search => (origin as JournalEntriesProvider).search;
}

String _$journalEntryByIdHash() => r'960c0702d213b7f1356d2fd655f735d7fe2b4e32';

/// See also [journalEntryById].
@ProviderFor(journalEntryById)
const journalEntryByIdProvider = JournalEntryByIdFamily();

/// See also [journalEntryById].
class JournalEntryByIdFamily extends Family<AsyncValue<JournalEntryModel?>> {
  /// See also [journalEntryById].
  const JournalEntryByIdFamily();

  /// See also [journalEntryById].
  JournalEntryByIdProvider call(
    String id,
  ) {
    return JournalEntryByIdProvider(
      id,
    );
  }

  @override
  JournalEntryByIdProvider getProviderOverride(
    covariant JournalEntryByIdProvider provider,
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
  String? get name => r'journalEntryByIdProvider';
}

/// See also [journalEntryById].
class JournalEntryByIdProvider
    extends AutoDisposeFutureProvider<JournalEntryModel?> {
  /// See also [journalEntryById].
  JournalEntryByIdProvider(
    String id,
  ) : this._internal(
          (ref) => journalEntryById(
            ref as JournalEntryByIdRef,
            id,
          ),
          from: journalEntryByIdProvider,
          name: r'journalEntryByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$journalEntryByIdHash,
          dependencies: JournalEntryByIdFamily._dependencies,
          allTransitiveDependencies:
              JournalEntryByIdFamily._allTransitiveDependencies,
          id: id,
        );

  JournalEntryByIdProvider._internal(
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
    FutureOr<JournalEntryModel?> Function(JournalEntryByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: JournalEntryByIdProvider._internal(
        (ref) => create(ref as JournalEntryByIdRef),
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
  AutoDisposeFutureProviderElement<JournalEntryModel?> createElement() {
    return _JournalEntryByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JournalEntryByIdProvider && other.id == id;
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
mixin JournalEntryByIdRef on AutoDisposeFutureProviderRef<JournalEntryModel?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _JournalEntryByIdProviderElement
    extends AutoDisposeFutureProviderElement<JournalEntryModel?>
    with JournalEntryByIdRef {
  _JournalEntryByIdProviderElement(super.provider);

  @override
  String get id => (origin as JournalEntryByIdProvider).id;
}

String _$todayGratitudeHash() => r'fb7046e233bc25d82f106fc05e3965ead6b38d78';

/// See also [todayGratitude].
@ProviderFor(todayGratitude)
final todayGratitudeProvider =
    AutoDisposeFutureProvider<GratitudeLogModel?>.internal(
  todayGratitude,
  name: r'todayGratitudeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todayGratitudeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayGratitudeRef = AutoDisposeFutureProviderRef<GratitudeLogModel?>;
String _$todayReflectionPromptHash() =>
    r'd5a191fea16399194675126d42d62dfd1b42fdb2';

/// See also [todayReflectionPrompt].
@ProviderFor(todayReflectionPrompt)
final todayReflectionPromptProvider =
    AutoDisposeFutureProvider<ReflectionPromptModel>.internal(
  todayReflectionPrompt,
  name: r'todayReflectionPromptProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todayReflectionPromptHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayReflectionPromptRef
    = AutoDisposeFutureProviderRef<ReflectionPromptModel>;
String _$reflectionResponseForHash() =>
    r'603af5886c9b5f8161cc941229c84437a52e06e9';

/// See also [reflectionResponseFor].
@ProviderFor(reflectionResponseFor)
const reflectionResponseForProvider = ReflectionResponseForFamily();

/// See also [reflectionResponseFor].
class ReflectionResponseForFamily
    extends Family<AsyncValue<ReflectionResponseModel?>> {
  /// See also [reflectionResponseFor].
  const ReflectionResponseForFamily();

  /// See also [reflectionResponseFor].
  ReflectionResponseForProvider call(
    String promptId,
  ) {
    return ReflectionResponseForProvider(
      promptId,
    );
  }

  @override
  ReflectionResponseForProvider getProviderOverride(
    covariant ReflectionResponseForProvider provider,
  ) {
    return call(
      provider.promptId,
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
  String? get name => r'reflectionResponseForProvider';
}

/// See also [reflectionResponseFor].
class ReflectionResponseForProvider
    extends AutoDisposeFutureProvider<ReflectionResponseModel?> {
  /// See also [reflectionResponseFor].
  ReflectionResponseForProvider(
    String promptId,
  ) : this._internal(
          (ref) => reflectionResponseFor(
            ref as ReflectionResponseForRef,
            promptId,
          ),
          from: reflectionResponseForProvider,
          name: r'reflectionResponseForProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$reflectionResponseForHash,
          dependencies: ReflectionResponseForFamily._dependencies,
          allTransitiveDependencies:
              ReflectionResponseForFamily._allTransitiveDependencies,
          promptId: promptId,
        );

  ReflectionResponseForProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.promptId,
  }) : super.internal();

  final String promptId;

  @override
  Override overrideWith(
    FutureOr<ReflectionResponseModel?> Function(
            ReflectionResponseForRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReflectionResponseForProvider._internal(
        (ref) => create(ref as ReflectionResponseForRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        promptId: promptId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ReflectionResponseModel?> createElement() {
    return _ReflectionResponseForProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReflectionResponseForProvider && other.promptId == promptId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, promptId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReflectionResponseForRef
    on AutoDisposeFutureProviderRef<ReflectionResponseModel?> {
  /// The parameter `promptId` of this provider.
  String get promptId;
}

class _ReflectionResponseForProviderElement
    extends AutoDisposeFutureProviderElement<ReflectionResponseModel?>
    with ReflectionResponseForRef {
  _ReflectionResponseForProviderElement(super.provider);

  @override
  String get promptId => (origin as ReflectionResponseForProvider).promptId;
}

String _$journalNotifierHash() => r'a839824f5b11d3ab76e59b29dc7806e42a484f8d';

/// See also [JournalNotifier].
@ProviderFor(JournalNotifier)
final journalNotifierProvider =
    AutoDisposeAsyncNotifierProvider<JournalNotifier, void>.internal(
  JournalNotifier.new,
  name: r'journalNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$journalNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$JournalNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
