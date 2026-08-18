// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'energy_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EnergyLogModel {
  String get id;
  String get userId;
  DateTime get logDate;
  DateTime get logTime;
  int get energyLevel;
  String? get note;
  DateTime get createdAt;

  /// Create a copy of EnergyLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EnergyLogModelCopyWith<EnergyLogModel> get copyWith =>
      _$EnergyLogModelCopyWithImpl<EnergyLogModel>(
          this as EnergyLogModel, _$identity);

  /// Serializes this EnergyLogModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EnergyLogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.logDate, logDate) || other.logDate == logDate) &&
            (identical(other.logTime, logTime) || other.logTime == logTime) &&
            (identical(other.energyLevel, energyLevel) ||
                other.energyLevel == energyLevel) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, logDate, logTime, energyLevel, note, createdAt);

  @override
  String toString() {
    return 'EnergyLogModel(id: $id, userId: $userId, logDate: $logDate, logTime: $logTime, energyLevel: $energyLevel, note: $note, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $EnergyLogModelCopyWith<$Res> {
  factory $EnergyLogModelCopyWith(
          EnergyLogModel value, $Res Function(EnergyLogModel) _then) =
      _$EnergyLogModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime logDate,
      DateTime logTime,
      int energyLevel,
      String? note,
      DateTime createdAt});
}

/// @nodoc
class _$EnergyLogModelCopyWithImpl<$Res>
    implements $EnergyLogModelCopyWith<$Res> {
  _$EnergyLogModelCopyWithImpl(this._self, this._then);

  final EnergyLogModel _self;
  final $Res Function(EnergyLogModel) _then;

  /// Create a copy of EnergyLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? logDate = null,
    Object? logTime = null,
    Object? energyLevel = null,
    Object? note = freezed,
    Object? createdAt = null,
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
      energyLevel: null == energyLevel
          ? _self.energyLevel
          : energyLevel // ignore: cast_nullable_to_non_nullable
              as int,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [EnergyLogModel].
extension EnergyLogModelPatterns on EnergyLogModel {
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
    TResult Function(_EnergyLogModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EnergyLogModel() when $default != null:
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
    TResult Function(_EnergyLogModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EnergyLogModel():
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
    TResult? Function(_EnergyLogModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EnergyLogModel() when $default != null:
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
            int energyLevel,
            String? note,
            DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EnergyLogModel() when $default != null:
        return $default(_that.id, _that.userId, _that.logDate, _that.logTime,
            _that.energyLevel, _that.note, _that.createdAt);
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
    TResult Function(String id, String userId, DateTime logDate,
            DateTime logTime, int energyLevel, String? note, DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EnergyLogModel():
        return $default(_that.id, _that.userId, _that.logDate, _that.logTime,
            _that.energyLevel, _that.note, _that.createdAt);
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
            int energyLevel,
            String? note,
            DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EnergyLogModel() when $default != null:
        return $default(_that.id, _that.userId, _that.logDate, _that.logTime,
            _that.energyLevel, _that.note, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EnergyLogModel implements EnergyLogModel {
  const _EnergyLogModel(
      {required this.id,
      required this.userId,
      required this.logDate,
      required this.logTime,
      required this.energyLevel,
      this.note,
      required this.createdAt});
  factory _EnergyLogModel.fromJson(Map<String, dynamic> json) =>
      _$EnergyLogModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime logDate;
  @override
  final DateTime logTime;
  @override
  final int energyLevel;
  @override
  final String? note;
  @override
  final DateTime createdAt;

  /// Create a copy of EnergyLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EnergyLogModelCopyWith<_EnergyLogModel> get copyWith =>
      __$EnergyLogModelCopyWithImpl<_EnergyLogModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EnergyLogModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EnergyLogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.logDate, logDate) || other.logDate == logDate) &&
            (identical(other.logTime, logTime) || other.logTime == logTime) &&
            (identical(other.energyLevel, energyLevel) ||
                other.energyLevel == energyLevel) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, logDate, logTime, energyLevel, note, createdAt);

  @override
  String toString() {
    return 'EnergyLogModel(id: $id, userId: $userId, logDate: $logDate, logTime: $logTime, energyLevel: $energyLevel, note: $note, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$EnergyLogModelCopyWith<$Res>
    implements $EnergyLogModelCopyWith<$Res> {
  factory _$EnergyLogModelCopyWith(
          _EnergyLogModel value, $Res Function(_EnergyLogModel) _then) =
      __$EnergyLogModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime logDate,
      DateTime logTime,
      int energyLevel,
      String? note,
      DateTime createdAt});
}

/// @nodoc
class __$EnergyLogModelCopyWithImpl<$Res>
    implements _$EnergyLogModelCopyWith<$Res> {
  __$EnergyLogModelCopyWithImpl(this._self, this._then);

  final _EnergyLogModel _self;
  final $Res Function(_EnergyLogModel) _then;

  /// Create a copy of EnergyLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? logDate = null,
    Object? logTime = null,
    Object? energyLevel = null,
    Object? note = freezed,
    Object? createdAt = null,
  }) {
    return _then(_EnergyLogModel(
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
      energyLevel: null == energyLevel
          ? _self.energyLevel
          : energyLevel // ignore: cast_nullable_to_non_nullable
              as int,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
