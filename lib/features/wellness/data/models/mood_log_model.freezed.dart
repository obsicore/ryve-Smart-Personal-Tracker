// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mood_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MoodLogModel {
  String get id;
  String get userId;
  DateTime get logDate;
  DateTime get logTime;
  int get moodScore;
  int? get energyScore;
  List<String> get moodTags;
  List<String> get factors;
  String? get note;
  DateTime get createdAt;
  DateTime get updatedAt;
  int get syncStatus;

  /// Create a copy of MoodLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MoodLogModelCopyWith<MoodLogModel> get copyWith =>
      _$MoodLogModelCopyWithImpl<MoodLogModel>(
          this as MoodLogModel, _$identity);

  /// Serializes this MoodLogModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MoodLogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.logDate, logDate) || other.logDate == logDate) &&
            (identical(other.logTime, logTime) || other.logTime == logTime) &&
            (identical(other.moodScore, moodScore) ||
                other.moodScore == moodScore) &&
            (identical(other.energyScore, energyScore) ||
                other.energyScore == energyScore) &&
            const DeepCollectionEquality().equals(other.moodTags, moodTags) &&
            const DeepCollectionEquality().equals(other.factors, factors) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      logDate,
      logTime,
      moodScore,
      energyScore,
      const DeepCollectionEquality().hash(moodTags),
      const DeepCollectionEquality().hash(factors),
      note,
      createdAt,
      updatedAt,
      syncStatus);

  @override
  String toString() {
    return 'MoodLogModel(id: $id, userId: $userId, logDate: $logDate, logTime: $logTime, moodScore: $moodScore, energyScore: $energyScore, moodTags: $moodTags, factors: $factors, note: $note, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus)';
  }
}

/// @nodoc
abstract mixin class $MoodLogModelCopyWith<$Res> {
  factory $MoodLogModelCopyWith(
          MoodLogModel value, $Res Function(MoodLogModel) _then) =
      _$MoodLogModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime logDate,
      DateTime logTime,
      int moodScore,
      int? energyScore,
      List<String> moodTags,
      List<String> factors,
      String? note,
      DateTime createdAt,
      DateTime updatedAt,
      int syncStatus});
}

/// @nodoc
class _$MoodLogModelCopyWithImpl<$Res> implements $MoodLogModelCopyWith<$Res> {
  _$MoodLogModelCopyWithImpl(this._self, this._then);

  final MoodLogModel _self;
  final $Res Function(MoodLogModel) _then;

  /// Create a copy of MoodLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? logDate = null,
    Object? logTime = null,
    Object? moodScore = null,
    Object? energyScore = freezed,
    Object? moodTags = null,
    Object? factors = null,
    Object? note = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncStatus = null,
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
      logDate: null == logDate
          ? _self.logDate
          : logDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      logTime: null == logTime
          ? _self.logTime
          : logTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      moodScore: null == moodScore
          ? _self.moodScore
          : moodScore // ignore: cast_nullable_to_non_nullable
              as int,
      energyScore: freezed == energyScore
          ? _self.energyScore
          : energyScore // ignore: cast_nullable_to_non_nullable
              as int?,
      moodTags: null == moodTags
          ? _self.moodTags
          : moodTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      factors: null == factors
          ? _self.factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncStatus: null == syncStatus
          ? _self.syncStatus
          : syncStatus // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [MoodLogModel].
extension MoodLogModelPatterns on MoodLogModel {
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
    TResult Function(_MoodLogModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MoodLogModel() when $default != null:
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
    TResult Function(_MoodLogModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MoodLogModel():
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
    TResult? Function(_MoodLogModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MoodLogModel() when $default != null:
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
            DateTime logDate,
            DateTime logTime,
            int moodScore,
            int? energyScore,
            List<String> moodTags,
            List<String> factors,
            String? note,
            DateTime createdAt,
            DateTime updatedAt,
            int syncStatus)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MoodLogModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.logDate,
            _that.logTime,
            _that.moodScore,
            _that.energyScore,
            _that.moodTags,
            _that.factors,
            _that.note,
            _that.createdAt,
            _that.updatedAt,
            _that.syncStatus);
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
            DateTime logDate,
            DateTime logTime,
            int moodScore,
            int? energyScore,
            List<String> moodTags,
            List<String> factors,
            String? note,
            DateTime createdAt,
            DateTime updatedAt,
            int syncStatus)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MoodLogModel():
        return $default(
            _that.id,
            _that.userId,
            _that.logDate,
            _that.logTime,
            _that.moodScore,
            _that.energyScore,
            _that.moodTags,
            _that.factors,
            _that.note,
            _that.createdAt,
            _that.updatedAt,
            _that.syncStatus);
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
            DateTime logDate,
            DateTime logTime,
            int moodScore,
            int? energyScore,
            List<String> moodTags,
            List<String> factors,
            String? note,
            DateTime createdAt,
            DateTime updatedAt,
            int syncStatus)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MoodLogModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.logDate,
            _that.logTime,
            _that.moodScore,
            _that.energyScore,
            _that.moodTags,
            _that.factors,
            _that.note,
            _that.createdAt,
            _that.updatedAt,
            _that.syncStatus);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MoodLogModel implements MoodLogModel {
  const _MoodLogModel(
      {required this.id,
      required this.userId,
      required this.logDate,
      required this.logTime,
      required this.moodScore,
      this.energyScore,
      final List<String> moodTags = const [],
      final List<String> factors = const [],
      this.note,
      required this.createdAt,
      required this.updatedAt,
      this.syncStatus = 0})
      : _moodTags = moodTags,
        _factors = factors;
  factory _MoodLogModel.fromJson(Map<String, dynamic> json) =>
      _$MoodLogModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime logDate;
  @override
  final DateTime logTime;
  @override
  final int moodScore;
  @override
  final int? energyScore;
  final List<String> _moodTags;
  @override
  @JsonKey()
  List<String> get moodTags {
    if (_moodTags is EqualUnmodifiableListView) return _moodTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_moodTags);
  }

  final List<String> _factors;
  @override
  @JsonKey()
  List<String> get factors {
    if (_factors is EqualUnmodifiableListView) return _factors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_factors);
  }

  @override
  final String? note;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final int syncStatus;

  /// Create a copy of MoodLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MoodLogModelCopyWith<_MoodLogModel> get copyWith =>
      __$MoodLogModelCopyWithImpl<_MoodLogModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MoodLogModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MoodLogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.logDate, logDate) || other.logDate == logDate) &&
            (identical(other.logTime, logTime) || other.logTime == logTime) &&
            (identical(other.moodScore, moodScore) ||
                other.moodScore == moodScore) &&
            (identical(other.energyScore, energyScore) ||
                other.energyScore == energyScore) &&
            const DeepCollectionEquality().equals(other._moodTags, _moodTags) &&
            const DeepCollectionEquality().equals(other._factors, _factors) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      logDate,
      logTime,
      moodScore,
      energyScore,
      const DeepCollectionEquality().hash(_moodTags),
      const DeepCollectionEquality().hash(_factors),
      note,
      createdAt,
      updatedAt,
      syncStatus);

  @override
  String toString() {
    return 'MoodLogModel(id: $id, userId: $userId, logDate: $logDate, logTime: $logTime, moodScore: $moodScore, energyScore: $energyScore, moodTags: $moodTags, factors: $factors, note: $note, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus)';
  }
}

/// @nodoc
abstract mixin class _$MoodLogModelCopyWith<$Res>
    implements $MoodLogModelCopyWith<$Res> {
  factory _$MoodLogModelCopyWith(
          _MoodLogModel value, $Res Function(_MoodLogModel) _then) =
      __$MoodLogModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime logDate,
      DateTime logTime,
      int moodScore,
      int? energyScore,
      List<String> moodTags,
      List<String> factors,
      String? note,
      DateTime createdAt,
      DateTime updatedAt,
      int syncStatus});
}

/// @nodoc
class __$MoodLogModelCopyWithImpl<$Res>
    implements _$MoodLogModelCopyWith<$Res> {
  __$MoodLogModelCopyWithImpl(this._self, this._then);

  final _MoodLogModel _self;
  final $Res Function(_MoodLogModel) _then;

  /// Create a copy of MoodLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? logDate = null,
    Object? logTime = null,
    Object? moodScore = null,
    Object? energyScore = freezed,
    Object? moodTags = null,
    Object? factors = null,
    Object? note = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncStatus = null,
  }) {
    return _then(_MoodLogModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      logDate: null == logDate
          ? _self.logDate
          : logDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      logTime: null == logTime
          ? _self.logTime
          : logTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      moodScore: null == moodScore
          ? _self.moodScore
          : moodScore // ignore: cast_nullable_to_non_nullable
              as int,
      energyScore: freezed == energyScore
          ? _self.energyScore
          : energyScore // ignore: cast_nullable_to_non_nullable
              as int?,
      moodTags: null == moodTags
          ? _self._moodTags
          : moodTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      factors: null == factors
          ? _self._factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncStatus: null == syncStatus
          ? _self.syncStatus
          : syncStatus // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
