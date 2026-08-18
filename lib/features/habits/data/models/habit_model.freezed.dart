// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HabitModel {
  String get id;
  String get userId;
  String get name;
  String get iconEmoji;
  String get category;
  String get frequency;
  int get targetValue;
  String? get unit;
  String? get chainNextId;
  bool get isActive;
  DateTime get createdAt; // computed fields for UI — not persisted directly
  int get currentStreak;
  int get longestStreak;
  bool get completedToday;
  double get todayProgress;
  List<DateTime> get completedDates;

  /// Create a copy of HabitModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HabitModelCopyWith<HabitModel> get copyWith =>
      _$HabitModelCopyWithImpl<HabitModel>(this as HabitModel, _$identity);

  /// Serializes this HabitModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HabitModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.iconEmoji, iconEmoji) ||
                other.iconEmoji == iconEmoji) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.chainNextId, chainNextId) ||
                other.chainNextId == chainNextId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.completedToday, completedToday) ||
                other.completedToday == completedToday) &&
            (identical(other.todayProgress, todayProgress) ||
                other.todayProgress == todayProgress) &&
            const DeepCollectionEquality()
                .equals(other.completedDates, completedDates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      name,
      iconEmoji,
      category,
      frequency,
      targetValue,
      unit,
      chainNextId,
      isActive,
      createdAt,
      currentStreak,
      longestStreak,
      completedToday,
      todayProgress,
      const DeepCollectionEquality().hash(completedDates));

  @override
  String toString() {
    return 'HabitModel(id: $id, userId: $userId, name: $name, iconEmoji: $iconEmoji, category: $category, frequency: $frequency, targetValue: $targetValue, unit: $unit, chainNextId: $chainNextId, isActive: $isActive, createdAt: $createdAt, currentStreak: $currentStreak, longestStreak: $longestStreak, completedToday: $completedToday, todayProgress: $todayProgress, completedDates: $completedDates)';
  }
}

/// @nodoc
abstract mixin class $HabitModelCopyWith<$Res> {
  factory $HabitModelCopyWith(
          HabitModel value, $Res Function(HabitModel) _then) =
      _$HabitModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      String iconEmoji,
      String category,
      String frequency,
      int targetValue,
      String? unit,
      String? chainNextId,
      bool isActive,
      DateTime createdAt,
      int currentStreak,
      int longestStreak,
      bool completedToday,
      double todayProgress,
      List<DateTime> completedDates});
}

/// @nodoc
class _$HabitModelCopyWithImpl<$Res> implements $HabitModelCopyWith<$Res> {
  _$HabitModelCopyWithImpl(this._self, this._then);

  final HabitModel _self;
  final $Res Function(HabitModel) _then;

  /// Create a copy of HabitModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? iconEmoji = null,
    Object? category = null,
    Object? frequency = null,
    Object? targetValue = null,
    Object? unit = freezed,
    Object? chainNextId = freezed,
    Object? isActive = null,
    Object? createdAt = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? completedToday = null,
    Object? todayProgress = null,
    Object? completedDates = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      iconEmoji: null == iconEmoji
          ? _self.iconEmoji
          : iconEmoji // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      targetValue: null == targetValue
          ? _self.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as int,
      unit: freezed == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      chainNextId: freezed == chainNextId
          ? _self.chainNextId
          : chainNextId // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentStreak: null == currentStreak
          ? _self.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _self.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      completedToday: null == completedToday
          ? _self.completedToday
          : completedToday // ignore: cast_nullable_to_non_nullable
              as bool,
      todayProgress: null == todayProgress
          ? _self.todayProgress
          : todayProgress // ignore: cast_nullable_to_non_nullable
              as double,
      completedDates: null == completedDates
          ? _self.completedDates
          : completedDates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
    ));
  }
}

/// Adds pattern-matching-related methods to [HabitModel].
extension HabitModelPatterns on HabitModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_HabitModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HabitModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_HabitModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HabitModel():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_HabitModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HabitModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String userId,
            String name,
            String iconEmoji,
            String category,
            String frequency,
            int targetValue,
            String? unit,
            String? chainNextId,
            bool isActive,
            DateTime createdAt,
            int currentStreak,
            int longestStreak,
            bool completedToday,
            double todayProgress,
            List<DateTime> completedDates)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HabitModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.name,
            _that.iconEmoji,
            _that.category,
            _that.frequency,
            _that.targetValue,
            _that.unit,
            _that.chainNextId,
            _that.isActive,
            _that.createdAt,
            _that.currentStreak,
            _that.longestStreak,
            _that.completedToday,
            _that.todayProgress,
            _that.completedDates);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String userId,
            String name,
            String iconEmoji,
            String category,
            String frequency,
            int targetValue,
            String? unit,
            String? chainNextId,
            bool isActive,
            DateTime createdAt,
            int currentStreak,
            int longestStreak,
            bool completedToday,
            double todayProgress,
            List<DateTime> completedDates)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HabitModel():
        return $default(
            _that.id,
            _that.userId,
            _that.name,
            _that.iconEmoji,
            _that.category,
            _that.frequency,
            _that.targetValue,
            _that.unit,
            _that.chainNextId,
            _that.isActive,
            _that.createdAt,
            _that.currentStreak,
            _that.longestStreak,
            _that.completedToday,
            _that.todayProgress,
            _that.completedDates);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String userId,
            String name,
            String iconEmoji,
            String category,
            String frequency,
            int targetValue,
            String? unit,
            String? chainNextId,
            bool isActive,
            DateTime createdAt,
            int currentStreak,
            int longestStreak,
            bool completedToday,
            double todayProgress,
            List<DateTime> completedDates)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HabitModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.name,
            _that.iconEmoji,
            _that.category,
            _that.frequency,
            _that.targetValue,
            _that.unit,
            _that.chainNextId,
            _that.isActive,
            _that.createdAt,
            _that.currentStreak,
            _that.longestStreak,
            _that.completedToday,
            _that.todayProgress,
            _that.completedDates);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HabitModel implements HabitModel {
  const _HabitModel(
      {required this.id,
      required this.userId,
      required this.name,
      this.iconEmoji = '⭐',
      this.category = 'general',
      this.frequency = 'daily',
      this.targetValue = 1,
      this.unit,
      this.chainNextId,
      this.isActive = true,
      required this.createdAt,
      this.currentStreak = 0,
      this.longestStreak = 0,
      this.completedToday = false,
      this.todayProgress = 0.0,
      final List<DateTime> completedDates = const []})
      : _completedDates = completedDates;
  factory _HabitModel.fromJson(Map<String, dynamic> json) =>
      _$HabitModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String name;
  @override
  @JsonKey()
  final String iconEmoji;
  @override
  @JsonKey()
  final String category;
  @override
  @JsonKey()
  final String frequency;
  @override
  @JsonKey()
  final int targetValue;
  @override
  final String? unit;
  @override
  final String? chainNextId;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;
// computed fields for UI — not persisted directly
  @override
  @JsonKey()
  final int currentStreak;
  @override
  @JsonKey()
  final int longestStreak;
  @override
  @JsonKey()
  final bool completedToday;
  @override
  @JsonKey()
  final double todayProgress;
  final List<DateTime> _completedDates;
  @override
  @JsonKey()
  List<DateTime> get completedDates {
    if (_completedDates is EqualUnmodifiableListView) return _completedDates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedDates);
  }

  /// Create a copy of HabitModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HabitModelCopyWith<_HabitModel> get copyWith =>
      __$HabitModelCopyWithImpl<_HabitModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HabitModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HabitModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.iconEmoji, iconEmoji) ||
                other.iconEmoji == iconEmoji) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.chainNextId, chainNextId) ||
                other.chainNextId == chainNextId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.completedToday, completedToday) ||
                other.completedToday == completedToday) &&
            (identical(other.todayProgress, todayProgress) ||
                other.todayProgress == todayProgress) &&
            const DeepCollectionEquality()
                .equals(other._completedDates, _completedDates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      name,
      iconEmoji,
      category,
      frequency,
      targetValue,
      unit,
      chainNextId,
      isActive,
      createdAt,
      currentStreak,
      longestStreak,
      completedToday,
      todayProgress,
      const DeepCollectionEquality().hash(_completedDates));

  @override
  String toString() {
    return 'HabitModel(id: $id, userId: $userId, name: $name, iconEmoji: $iconEmoji, category: $category, frequency: $frequency, targetValue: $targetValue, unit: $unit, chainNextId: $chainNextId, isActive: $isActive, createdAt: $createdAt, currentStreak: $currentStreak, longestStreak: $longestStreak, completedToday: $completedToday, todayProgress: $todayProgress, completedDates: $completedDates)';
  }
}

/// @nodoc
abstract mixin class _$HabitModelCopyWith<$Res>
    implements $HabitModelCopyWith<$Res> {
  factory _$HabitModelCopyWith(
          _HabitModel value, $Res Function(_HabitModel) _then) =
      __$HabitModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      String iconEmoji,
      String category,
      String frequency,
      int targetValue,
      String? unit,
      String? chainNextId,
      bool isActive,
      DateTime createdAt,
      int currentStreak,
      int longestStreak,
      bool completedToday,
      double todayProgress,
      List<DateTime> completedDates});
}

/// @nodoc
class __$HabitModelCopyWithImpl<$Res> implements _$HabitModelCopyWith<$Res> {
  __$HabitModelCopyWithImpl(this._self, this._then);

  final _HabitModel _self;
  final $Res Function(_HabitModel) _then;

  /// Create a copy of HabitModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? iconEmoji = null,
    Object? category = null,
    Object? frequency = null,
    Object? targetValue = null,
    Object? unit = freezed,
    Object? chainNextId = freezed,
    Object? isActive = null,
    Object? createdAt = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? completedToday = null,
    Object? todayProgress = null,
    Object? completedDates = null,
  }) {
    return _then(_HabitModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      iconEmoji: null == iconEmoji
          ? _self.iconEmoji
          : iconEmoji // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      targetValue: null == targetValue
          ? _self.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as int,
      unit: freezed == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      chainNextId: freezed == chainNextId
          ? _self.chainNextId
          : chainNextId // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentStreak: null == currentStreak
          ? _self.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _self.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      completedToday: null == completedToday
          ? _self.completedToday
          : completedToday // ignore: cast_nullable_to_non_nullable
              as bool,
      todayProgress: null == todayProgress
          ? _self.todayProgress
          : todayProgress // ignore: cast_nullable_to_non_nullable
              as double,
      completedDates: null == completedDates
          ? _self._completedDates
          : completedDates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
    ));
  }
}

/// @nodoc
mixin _$HabitLogModel {
  String get id;
  String get habitId;
  DateTime get logDate;
  double get value;
  int? get moodAfter;
  String?
      get notes; // userId required by the DB schema; optional on model for clean API
  String? get userId;

  /// Create a copy of HabitLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HabitLogModelCopyWith<HabitLogModel> get copyWith =>
      _$HabitLogModelCopyWithImpl<HabitLogModel>(
          this as HabitLogModel, _$identity);

  /// Serializes this HabitLogModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HabitLogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.habitId, habitId) || other.habitId == habitId) &&
            (identical(other.logDate, logDate) || other.logDate == logDate) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.moodAfter, moodAfter) ||
                other.moodAfter == moodAfter) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, habitId, logDate, value, moodAfter, notes, userId);

  @override
  String toString() {
    return 'HabitLogModel(id: $id, habitId: $habitId, logDate: $logDate, value: $value, moodAfter: $moodAfter, notes: $notes, userId: $userId)';
  }
}

/// @nodoc
abstract mixin class $HabitLogModelCopyWith<$Res> {
  factory $HabitLogModelCopyWith(
          HabitLogModel value, $Res Function(HabitLogModel) _then) =
      _$HabitLogModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String habitId,
      DateTime logDate,
      double value,
      int? moodAfter,
      String? notes,
      String? userId});
}

/// @nodoc
class _$HabitLogModelCopyWithImpl<$Res>
    implements $HabitLogModelCopyWith<$Res> {
  _$HabitLogModelCopyWithImpl(this._self, this._then);

  final HabitLogModel _self;
  final $Res Function(HabitLogModel) _then;

  /// Create a copy of HabitLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? habitId = null,
    Object? logDate = null,
    Object? value = null,
    Object? moodAfter = freezed,
    Object? notes = freezed,
    Object? userId = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      habitId: null == habitId
          ? _self.habitId
          : habitId // ignore: cast_nullable_to_non_nullable
              as String,
      logDate: null == logDate
          ? _self.logDate
          : logDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      moodAfter: freezed == moodAfter
          ? _self.moodAfter
          : moodAfter // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [HabitLogModel].
extension HabitLogModelPatterns on HabitLogModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_HabitLogModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HabitLogModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_HabitLogModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HabitLogModel():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_HabitLogModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HabitLogModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String id, String habitId, DateTime logDate, double value,
            int? moodAfter, String? notes, String? userId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HabitLogModel() when $default != null:
        return $default(_that.id, _that.habitId, _that.logDate, _that.value,
            _that.moodAfter, _that.notes, _that.userId);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String id, String habitId, DateTime logDate, double value,
            int? moodAfter, String? notes, String? userId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HabitLogModel():
        return $default(_that.id, _that.habitId, _that.logDate, _that.value,
            _that.moodAfter, _that.notes, _that.userId);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String id, String habitId, DateTime logDate, double value,
            int? moodAfter, String? notes, String? userId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HabitLogModel() when $default != null:
        return $default(_that.id, _that.habitId, _that.logDate, _that.value,
            _that.moodAfter, _that.notes, _that.userId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HabitLogModel implements HabitLogModel {
  const _HabitLogModel(
      {required this.id,
      required this.habitId,
      required this.logDate,
      this.value = 1.0,
      this.moodAfter,
      this.notes,
      this.userId});
  factory _HabitLogModel.fromJson(Map<String, dynamic> json) =>
      _$HabitLogModelFromJson(json);

  @override
  final String id;
  @override
  final String habitId;
  @override
  final DateTime logDate;
  @override
  @JsonKey()
  final double value;
  @override
  final int? moodAfter;
  @override
  final String? notes;
// userId required by the DB schema; optional on model for clean API
  @override
  final String? userId;

  /// Create a copy of HabitLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HabitLogModelCopyWith<_HabitLogModel> get copyWith =>
      __$HabitLogModelCopyWithImpl<_HabitLogModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HabitLogModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HabitLogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.habitId, habitId) || other.habitId == habitId) &&
            (identical(other.logDate, logDate) || other.logDate == logDate) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.moodAfter, moodAfter) ||
                other.moodAfter == moodAfter) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, habitId, logDate, value, moodAfter, notes, userId);

  @override
  String toString() {
    return 'HabitLogModel(id: $id, habitId: $habitId, logDate: $logDate, value: $value, moodAfter: $moodAfter, notes: $notes, userId: $userId)';
  }
}

/// @nodoc
abstract mixin class _$HabitLogModelCopyWith<$Res>
    implements $HabitLogModelCopyWith<$Res> {
  factory _$HabitLogModelCopyWith(
          _HabitLogModel value, $Res Function(_HabitLogModel) _then) =
      __$HabitLogModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String habitId,
      DateTime logDate,
      double value,
      int? moodAfter,
      String? notes,
      String? userId});
}

/// @nodoc
class __$HabitLogModelCopyWithImpl<$Res>
    implements _$HabitLogModelCopyWith<$Res> {
  __$HabitLogModelCopyWithImpl(this._self, this._then);

  final _HabitLogModel _self;
  final $Res Function(_HabitLogModel) _then;

  /// Create a copy of HabitLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? habitId = null,
    Object? logDate = null,
    Object? value = null,
    Object? moodAfter = freezed,
    Object? notes = freezed,
    Object? userId = freezed,
  }) {
    return _then(_HabitLogModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      habitId: null == habitId
          ? _self.habitId
          : habitId // ignore: cast_nullable_to_non_nullable
              as String,
      logDate: null == logDate
          ? _self.logDate
          : logDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      moodAfter: freezed == moodAfter
          ? _self.moodAfter
          : moodAfter // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
