// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$monthEventsHash() => r'8ad157428b7ff430cd44dfa5fa5d8e2006da8141';

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

/// See also [monthEvents].
@ProviderFor(monthEvents)
const monthEventsProvider = MonthEventsFamily();

/// See also [monthEvents].
class MonthEventsFamily extends Family<AsyncValue<List<CalendarEventModel>>> {
  /// See also [monthEvents].
  const MonthEventsFamily();

  /// See also [monthEvents].
  MonthEventsProvider call(
    String userId,
    DateTime month,
  ) {
    return MonthEventsProvider(
      userId,
      month,
    );
  }

  @override
  MonthEventsProvider getProviderOverride(
    covariant MonthEventsProvider provider,
  ) {
    return call(
      provider.userId,
      provider.month,
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
  String? get name => r'monthEventsProvider';
}

/// See also [monthEvents].
class MonthEventsProvider
    extends AutoDisposeStreamProvider<List<CalendarEventModel>> {
  /// See also [monthEvents].
  MonthEventsProvider(
    String userId,
    DateTime month,
  ) : this._internal(
          (ref) => monthEvents(
            ref as MonthEventsRef,
            userId,
            month,
          ),
          from: monthEventsProvider,
          name: r'monthEventsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$monthEventsHash,
          dependencies: MonthEventsFamily._dependencies,
          allTransitiveDependencies:
              MonthEventsFamily._allTransitiveDependencies,
          userId: userId,
          month: month,
        );

  MonthEventsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.month,
  }) : super.internal();

  final String userId;
  final DateTime month;

  @override
  Override overrideWith(
    Stream<List<CalendarEventModel>> Function(MonthEventsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MonthEventsProvider._internal(
        (ref) => create(ref as MonthEventsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<CalendarEventModel>> createElement() {
    return _MonthEventsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MonthEventsProvider &&
        other.userId == userId &&
        other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MonthEventsRef on AutoDisposeStreamProviderRef<List<CalendarEventModel>> {
  /// The parameter `userId` of this provider.
  String get userId;

  /// The parameter `month` of this provider.
  DateTime get month;
}

class _MonthEventsProviderElement
    extends AutoDisposeStreamProviderElement<List<CalendarEventModel>>
    with MonthEventsRef {
  _MonthEventsProviderElement(super.provider);

  @override
  String get userId => (origin as MonthEventsProvider).userId;
  @override
  DateTime get month => (origin as MonthEventsProvider).month;
}

String _$dayEventsHash() => r'bb27b0d123c0db86f228fb83b8e364f26f861a8e';

/// See also [dayEvents].
@ProviderFor(dayEvents)
const dayEventsProvider = DayEventsFamily();

/// See also [dayEvents].
class DayEventsFamily extends Family<AsyncValue<List<CalendarEventModel>>> {
  /// See also [dayEvents].
  const DayEventsFamily();

  /// See also [dayEvents].
  DayEventsProvider call(
    String userId,
    DateTime day,
  ) {
    return DayEventsProvider(
      userId,
      day,
    );
  }

  @override
  DayEventsProvider getProviderOverride(
    covariant DayEventsProvider provider,
  ) {
    return call(
      provider.userId,
      provider.day,
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
  String? get name => r'dayEventsProvider';
}

/// See also [dayEvents].
class DayEventsProvider
    extends AutoDisposeStreamProvider<List<CalendarEventModel>> {
  /// See also [dayEvents].
  DayEventsProvider(
    String userId,
    DateTime day,
  ) : this._internal(
          (ref) => dayEvents(
            ref as DayEventsRef,
            userId,
            day,
          ),
          from: dayEventsProvider,
          name: r'dayEventsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dayEventsHash,
          dependencies: DayEventsFamily._dependencies,
          allTransitiveDependencies: DayEventsFamily._allTransitiveDependencies,
          userId: userId,
          day: day,
        );

  DayEventsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.day,
  }) : super.internal();

  final String userId;
  final DateTime day;

  @override
  Override overrideWith(
    Stream<List<CalendarEventModel>> Function(DayEventsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DayEventsProvider._internal(
        (ref) => create(ref as DayEventsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        day: day,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<CalendarEventModel>> createElement() {
    return _DayEventsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DayEventsProvider &&
        other.userId == userId &&
        other.day == day;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, day.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DayEventsRef on AutoDisposeStreamProviderRef<List<CalendarEventModel>> {
  /// The parameter `userId` of this provider.
  String get userId;

  /// The parameter `day` of this provider.
  DateTime get day;
}

class _DayEventsProviderElement
    extends AutoDisposeStreamProviderElement<List<CalendarEventModel>>
    with DayEventsRef {
  _DayEventsProviderElement(super.provider);

  @override
  String get userId => (origin as DayEventsProvider).userId;
  @override
  DateTime get day => (origin as DayEventsProvider).day;
}

String _$calendarNotifierHash() => r'501b0d3ce7a356020d0e2ac735e7a74d127f08d9';

/// See also [CalendarNotifier].
@ProviderFor(CalendarNotifier)
final calendarNotifierProvider =
    AutoDisposeAsyncNotifierProvider<CalendarNotifier, void>.internal(
  CalendarNotifier.new,
  name: r'calendarNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$calendarNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CalendarNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
