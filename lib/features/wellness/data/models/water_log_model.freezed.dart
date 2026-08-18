// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'water_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WaterLogModel {
  String get id;
  String get userId;
  DateTime get logDate;
  DateTime get logTime;
  int get amountMl;
  String? get containerType;
  DateTime get createdAt;
  int get syncStatus;

  /// Create a copy of WaterLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WaterLogModelCopyWith<WaterLogModel> get copyWith =>
      _$WaterLogModelCopyWithImpl<WaterLogModel>(
          this as WaterLogModel, _$identity);

  /// Serializes this WaterLogModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WaterLogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.logDate, logDate) || other.logDate == logDate) &&
            (identical(other.logTime, logTime) || other.logTime == logTime) &&
            (identical(other.amountMl, amountMl) ||
                other.amountMl == amountMl) &&
            (identical(other.containerType, containerType) ||
                other.containerType == containerType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, logDate, logTime,
      amountMl, containerType, createdAt, syncStatus);

  @override
  String toString() {
    return 'WaterLogModel(id: $id, userId: $userId, logDate: $logDate, logTime: $logTime, amountMl: $amountMl, containerType: $containerType, createdAt: $createdAt, syncStatus: $syncStatus)';
  }
}

/// @nodoc
abstract mixin class $WaterLogModelCopyWith<$Res> {
  factory $WaterLogModelCopyWith(
          WaterLogModel value, $Res Function(WaterLogModel) _then) =
      _$WaterLogModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime logDate,
      DateTime logTime,
      int amountMl,
      String? containerType,
      DateTime createdAt,
      int syncStatus});
}

/// @nodoc
class _$WaterLogModelCopyWithImpl<$Res>
    implements $WaterLogModelCopyWith<$Res> {
  _$WaterLogModelCopyWithImpl(this._self, this._then);

  final WaterLogModel _self;
  final $Res Function(WaterLogModel) _then;

  /// Create a copy of WaterLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? logDate = null,
    Object? logTime = null,
    Object? amountMl = null,
    Object? containerType = freezed,
    Object? createdAt = null,
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
      amountMl: null == amountMl
          ? _self.amountMl
          : amountMl // ignore: cast_nullable_to_non_nullable
              as int,
      containerType: freezed == containerType
          ? _self.containerType
          : containerType // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncStatus: null == syncStatus
          ? _self.syncStatus
          : syncStatus // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [WaterLogModel].
extension WaterLogModelPatterns on WaterLogModel {
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
    TResult Function(_WaterLogModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WaterLogModel() when $default != null:
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
    TResult Function(_WaterLogModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WaterLogModel():
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
    TResult? Function(_WaterLogModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WaterLogModel() when $default != null:
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
            int amountMl,
            String? containerType,
            DateTime createdAt,
            int syncStatus)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WaterLogModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.logDate,
            _that.logTime,
            _that.amountMl,
            _that.containerType,
            _that.createdAt,
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
            int amountMl,
            String? containerType,
            DateTime createdAt,
            int syncStatus)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WaterLogModel():
        return $default(
            _that.id,
            _that.userId,
            _that.logDate,
            _that.logTime,
            _that.amountMl,
            _that.containerType,
            _that.createdAt,
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
            int amountMl,
            String? containerType,
            DateTime createdAt,
            int syncStatus)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WaterLogModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.logDate,
            _that.logTime,
            _that.amountMl,
            _that.containerType,
            _that.createdAt,
            _that.syncStatus);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WaterLogModel implements WaterLogModel {
  const _WaterLogModel(
      {required this.id,
      required this.userId,
      required this.logDate,
      required this.logTime,
      required this.amountMl,
      this.containerType,
      required this.createdAt,
      this.syncStatus = 0});
  factory _WaterLogModel.fromJson(Map<String, dynamic> json) =>
      _$WaterLogModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime logDate;
  @override
  final DateTime logTime;
  @override
  final int amountMl;
  @override
  final String? containerType;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final int syncStatus;

  /// Create a copy of WaterLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WaterLogModelCopyWith<_WaterLogModel> get copyWith =>
      __$WaterLogModelCopyWithImpl<_WaterLogModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WaterLogModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WaterLogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.logDate, logDate) || other.logDate == logDate) &&
            (identical(other.logTime, logTime) || other.logTime == logTime) &&
            (identical(other.amountMl, amountMl) ||
                other.amountMl == amountMl) &&
            (identical(other.containerType, containerType) ||
                other.containerType == containerType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, logDate, logTime,
      amountMl, containerType, createdAt, syncStatus);

  @override
  String toString() {
    return 'WaterLogModel(id: $id, userId: $userId, logDate: $logDate, logTime: $logTime, amountMl: $amountMl, containerType: $containerType, createdAt: $createdAt, syncStatus: $syncStatus)';
  }
}

/// @nodoc
abstract mixin class _$WaterLogModelCopyWith<$Res>
    implements $WaterLogModelCopyWith<$Res> {
  factory _$WaterLogModelCopyWith(
          _WaterLogModel value, $Res Function(_WaterLogModel) _then) =
      __$WaterLogModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime logDate,
      DateTime logTime,
      int amountMl,
      String? containerType,
      DateTime createdAt,
      int syncStatus});
}

/// @nodoc
class __$WaterLogModelCopyWithImpl<$Res>
    implements _$WaterLogModelCopyWith<$Res> {
  __$WaterLogModelCopyWithImpl(this._self, this._then);

  final _WaterLogModel _self;
  final $Res Function(_WaterLogModel) _then;

  /// Create a copy of WaterLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? logDate = null,
    Object? logTime = null,
    Object? amountMl = null,
    Object? containerType = freezed,
    Object? createdAt = null,
    Object? syncStatus = null,
  }) {
    return _then(_WaterLogModel(
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
      amountMl: null == amountMl
          ? _self.amountMl
          : amountMl // ignore: cast_nullable_to_non_nullable
              as int,
      containerType: freezed == containerType
          ? _self.containerType
          : containerType // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncStatus: null == syncStatus
          ? _self.syncStatus
          : syncStatus // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
