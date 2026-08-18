// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sleep_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SleepLogModel {
  String get id;
  String get userId;
  DateTime get bedtime;
  DateTime get wakeTime;
  int get qualityRating;
  int? get sleepLatencyMinutes;
  bool get hadNightmares;
  String? get notes;
  int get syncStatus;
  DateTime get createdAt;

  /// Create a copy of SleepLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SleepLogModelCopyWith<SleepLogModel> get copyWith =>
      _$SleepLogModelCopyWithImpl<SleepLogModel>(
          this as SleepLogModel, _$identity);

  /// Serializes this SleepLogModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SleepLogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.bedtime, bedtime) || other.bedtime == bedtime) &&
            (identical(other.wakeTime, wakeTime) ||
                other.wakeTime == wakeTime) &&
            (identical(other.qualityRating, qualityRating) ||
                other.qualityRating == qualityRating) &&
            (identical(other.sleepLatencyMinutes, sleepLatencyMinutes) ||
                other.sleepLatencyMinutes == sleepLatencyMinutes) &&
            (identical(other.hadNightmares, hadNightmares) ||
                other.hadNightmares == hadNightmares) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      bedtime,
      wakeTime,
      qualityRating,
      sleepLatencyMinutes,
      hadNightmares,
      notes,
      syncStatus,
      createdAt);

  @override
  String toString() {
    return 'SleepLogModel(id: $id, userId: $userId, bedtime: $bedtime, wakeTime: $wakeTime, qualityRating: $qualityRating, sleepLatencyMinutes: $sleepLatencyMinutes, hadNightmares: $hadNightmares, notes: $notes, syncStatus: $syncStatus, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $SleepLogModelCopyWith<$Res> {
  factory $SleepLogModelCopyWith(
          SleepLogModel value, $Res Function(SleepLogModel) _then) =
      _$SleepLogModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime bedtime,
      DateTime wakeTime,
      int qualityRating,
      int? sleepLatencyMinutes,
      bool hadNightmares,
      String? notes,
      int syncStatus,
      DateTime createdAt});
}

/// @nodoc
class _$SleepLogModelCopyWithImpl<$Res>
    implements $SleepLogModelCopyWith<$Res> {
  _$SleepLogModelCopyWithImpl(this._self, this._then);

  final SleepLogModel _self;
  final $Res Function(SleepLogModel) _then;

  /// Create a copy of SleepLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? bedtime = null,
    Object? wakeTime = null,
    Object? qualityRating = null,
    Object? sleepLatencyMinutes = freezed,
    Object? hadNightmares = null,
    Object? notes = freezed,
    Object? syncStatus = null,
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
      bedtime: null == bedtime
          ? _self.bedtime
          : bedtime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      wakeTime: null == wakeTime
          ? _self.wakeTime
          : wakeTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      qualityRating: null == qualityRating
          ? _self.qualityRating
          : qualityRating // ignore: cast_nullable_to_non_nullable
              as int,
      sleepLatencyMinutes: freezed == sleepLatencyMinutes
          ? _self.sleepLatencyMinutes
          : sleepLatencyMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      hadNightmares: null == hadNightmares
          ? _self.hadNightmares
          : hadNightmares // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      syncStatus: null == syncStatus
          ? _self.syncStatus
          : syncStatus // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [SleepLogModel].
extension SleepLogModelPatterns on SleepLogModel {
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
    TResult Function(_SleepLogModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SleepLogModel() when $default != null:
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
    TResult Function(_SleepLogModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SleepLogModel():
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
    TResult? Function(_SleepLogModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SleepLogModel() when $default != null:
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
            DateTime bedtime,
            DateTime wakeTime,
            int qualityRating,
            int? sleepLatencyMinutes,
            bool hadNightmares,
            String? notes,
            int syncStatus,
            DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SleepLogModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.bedtime,
            _that.wakeTime,
            _that.qualityRating,
            _that.sleepLatencyMinutes,
            _that.hadNightmares,
            _that.notes,
            _that.syncStatus,
            _that.createdAt);
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
            DateTime bedtime,
            DateTime wakeTime,
            int qualityRating,
            int? sleepLatencyMinutes,
            bool hadNightmares,
            String? notes,
            int syncStatus,
            DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SleepLogModel():
        return $default(
            _that.id,
            _that.userId,
            _that.bedtime,
            _that.wakeTime,
            _that.qualityRating,
            _that.sleepLatencyMinutes,
            _that.hadNightmares,
            _that.notes,
            _that.syncStatus,
            _that.createdAt);
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
            DateTime bedtime,
            DateTime wakeTime,
            int qualityRating,
            int? sleepLatencyMinutes,
            bool hadNightmares,
            String? notes,
            int syncStatus,
            DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SleepLogModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.bedtime,
            _that.wakeTime,
            _that.qualityRating,
            _that.sleepLatencyMinutes,
            _that.hadNightmares,
            _that.notes,
            _that.syncStatus,
            _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SleepLogModel implements SleepLogModel {
  const _SleepLogModel(
      {required this.id,
      required this.userId,
      required this.bedtime,
      required this.wakeTime,
      this.qualityRating = 3,
      this.sleepLatencyMinutes,
      this.hadNightmares = false,
      this.notes,
      this.syncStatus = 0,
      required this.createdAt});
  factory _SleepLogModel.fromJson(Map<String, dynamic> json) =>
      _$SleepLogModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime bedtime;
  @override
  final DateTime wakeTime;
  @override
  @JsonKey()
  final int qualityRating;
  @override
  final int? sleepLatencyMinutes;
  @override
  @JsonKey()
  final bool hadNightmares;
  @override
  final String? notes;
  @override
  @JsonKey()
  final int syncStatus;
  @override
  final DateTime createdAt;

  /// Create a copy of SleepLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SleepLogModelCopyWith<_SleepLogModel> get copyWith =>
      __$SleepLogModelCopyWithImpl<_SleepLogModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SleepLogModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SleepLogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.bedtime, bedtime) || other.bedtime == bedtime) &&
            (identical(other.wakeTime, wakeTime) ||
                other.wakeTime == wakeTime) &&
            (identical(other.qualityRating, qualityRating) ||
                other.qualityRating == qualityRating) &&
            (identical(other.sleepLatencyMinutes, sleepLatencyMinutes) ||
                other.sleepLatencyMinutes == sleepLatencyMinutes) &&
            (identical(other.hadNightmares, hadNightmares) ||
                other.hadNightmares == hadNightmares) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      bedtime,
      wakeTime,
      qualityRating,
      sleepLatencyMinutes,
      hadNightmares,
      notes,
      syncStatus,
      createdAt);

  @override
  String toString() {
    return 'SleepLogModel(id: $id, userId: $userId, bedtime: $bedtime, wakeTime: $wakeTime, qualityRating: $qualityRating, sleepLatencyMinutes: $sleepLatencyMinutes, hadNightmares: $hadNightmares, notes: $notes, syncStatus: $syncStatus, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$SleepLogModelCopyWith<$Res>
    implements $SleepLogModelCopyWith<$Res> {
  factory _$SleepLogModelCopyWith(
          _SleepLogModel value, $Res Function(_SleepLogModel) _then) =
      __$SleepLogModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime bedtime,
      DateTime wakeTime,
      int qualityRating,
      int? sleepLatencyMinutes,
      bool hadNightmares,
      String? notes,
      int syncStatus,
      DateTime createdAt});
}

/// @nodoc
class __$SleepLogModelCopyWithImpl<$Res>
    implements _$SleepLogModelCopyWith<$Res> {
  __$SleepLogModelCopyWithImpl(this._self, this._then);

  final _SleepLogModel _self;
  final $Res Function(_SleepLogModel) _then;

  /// Create a copy of SleepLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? bedtime = null,
    Object? wakeTime = null,
    Object? qualityRating = null,
    Object? sleepLatencyMinutes = freezed,
    Object? hadNightmares = null,
    Object? notes = freezed,
    Object? syncStatus = null,
    Object? createdAt = null,
  }) {
    return _then(_SleepLogModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      bedtime: null == bedtime
          ? _self.bedtime
          : bedtime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      wakeTime: null == wakeTime
          ? _self.wakeTime
          : wakeTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      qualityRating: null == qualityRating
          ? _self.qualityRating
          : qualityRating // ignore: cast_nullable_to_non_nullable
              as int,
      sleepLatencyMinutes: freezed == sleepLatencyMinutes
          ? _self.sleepLatencyMinutes
          : sleepLatencyMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      hadNightmares: null == hadNightmares
          ? _self.hadNightmares
          : hadNightmares // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      syncStatus: null == syncStatus
          ? _self.syncStatus
          : syncStatus // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
