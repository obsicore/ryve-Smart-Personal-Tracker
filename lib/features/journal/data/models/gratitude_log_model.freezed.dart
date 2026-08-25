// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gratitude_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GratitudeLogModel {
  String get id;
  String get userId;
  DateTime get logDate;
  String get item1;
  String? get item2;
  String? get item3;
  DateTime get createdAt;
  int get syncStatus;

  /// Create a copy of GratitudeLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GratitudeLogModelCopyWith<GratitudeLogModel> get copyWith =>
      _$GratitudeLogModelCopyWithImpl<GratitudeLogModel>(
          this as GratitudeLogModel, _$identity);

  /// Serializes this GratitudeLogModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GratitudeLogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.logDate, logDate) || other.logDate == logDate) &&
            (identical(other.item1, item1) || other.item1 == item1) &&
            (identical(other.item2, item2) || other.item2 == item2) &&
            (identical(other.item3, item3) || other.item3 == item3) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, logDate, item1,
      item2, item3, createdAt, syncStatus);

  @override
  String toString() {
    return 'GratitudeLogModel(id: $id, userId: $userId, logDate: $logDate, item1: $item1, item2: $item2, item3: $item3, createdAt: $createdAt, syncStatus: $syncStatus)';
  }
}

/// @nodoc
abstract mixin class $GratitudeLogModelCopyWith<$Res> {
  factory $GratitudeLogModelCopyWith(
          GratitudeLogModel value, $Res Function(GratitudeLogModel) _then) =
      _$GratitudeLogModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime logDate,
      String item1,
      String? item2,
      String? item3,
      DateTime createdAt,
      int syncStatus});
}

/// @nodoc
class _$GratitudeLogModelCopyWithImpl<$Res>
    implements $GratitudeLogModelCopyWith<$Res> {
  _$GratitudeLogModelCopyWithImpl(this._self, this._then);

  final GratitudeLogModel _self;
  final $Res Function(GratitudeLogModel) _then;

  /// Create a copy of GratitudeLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? logDate = null,
    Object? item1 = null,
    Object? item2 = freezed,
    Object? item3 = freezed,
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
      item1: null == item1
          ? _self.item1
          : item1 // ignore: cast_nullable_to_non_nullable
              as String,
      item2: freezed == item2
          ? _self.item2
          : item2 // ignore: cast_nullable_to_non_nullable
              as String?,
      item3: freezed == item3
          ? _self.item3
          : item3 // ignore: cast_nullable_to_non_nullable
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

/// Adds pattern-matching-related methods to [GratitudeLogModel].
extension GratitudeLogModelPatterns on GratitudeLogModel {
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
    TResult Function(_GratitudeLogModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GratitudeLogModel() when $default != null:
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
    TResult Function(_GratitudeLogModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GratitudeLogModel():
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
    TResult? Function(_GratitudeLogModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GratitudeLogModel() when $default != null:
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
    TResult Function(String id, String userId, DateTime logDate, String item1,
            String? item2, String? item3, DateTime createdAt, int syncStatus)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GratitudeLogModel() when $default != null:
        return $default(_that.id, _that.userId, _that.logDate, _that.item1,
            _that.item2, _that.item3, _that.createdAt, _that.syncStatus);
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
    TResult Function(String id, String userId, DateTime logDate, String item1,
            String? item2, String? item3, DateTime createdAt, int syncStatus)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GratitudeLogModel():
        return $default(_that.id, _that.userId, _that.logDate, _that.item1,
            _that.item2, _that.item3, _that.createdAt, _that.syncStatus);
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
    TResult? Function(String id, String userId, DateTime logDate, String item1,
            String? item2, String? item3, DateTime createdAt, int syncStatus)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GratitudeLogModel() when $default != null:
        return $default(_that.id, _that.userId, _that.logDate, _that.item1,
            _that.item2, _that.item3, _that.createdAt, _that.syncStatus);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GratitudeLogModel implements GratitudeLogModel {
  const _GratitudeLogModel(
      {required this.id,
      required this.userId,
      required this.logDate,
      required this.item1,
      this.item2,
      this.item3,
      required this.createdAt,
      this.syncStatus = 0});
  factory _GratitudeLogModel.fromJson(Map<String, dynamic> json) =>
      _$GratitudeLogModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime logDate;
  @override
  final String item1;
  @override
  final String? item2;
  @override
  final String? item3;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final int syncStatus;

  /// Create a copy of GratitudeLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GratitudeLogModelCopyWith<_GratitudeLogModel> get copyWith =>
      __$GratitudeLogModelCopyWithImpl<_GratitudeLogModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GratitudeLogModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GratitudeLogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.logDate, logDate) || other.logDate == logDate) &&
            (identical(other.item1, item1) || other.item1 == item1) &&
            (identical(other.item2, item2) || other.item2 == item2) &&
            (identical(other.item3, item3) || other.item3 == item3) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, logDate, item1,
      item2, item3, createdAt, syncStatus);

  @override
  String toString() {
    return 'GratitudeLogModel(id: $id, userId: $userId, logDate: $logDate, item1: $item1, item2: $item2, item3: $item3, createdAt: $createdAt, syncStatus: $syncStatus)';
  }
}

/// @nodoc
abstract mixin class _$GratitudeLogModelCopyWith<$Res>
    implements $GratitudeLogModelCopyWith<$Res> {
  factory _$GratitudeLogModelCopyWith(
          _GratitudeLogModel value, $Res Function(_GratitudeLogModel) _then) =
      __$GratitudeLogModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime logDate,
      String item1,
      String? item2,
      String? item3,
      DateTime createdAt,
      int syncStatus});
}

/// @nodoc
class __$GratitudeLogModelCopyWithImpl<$Res>
    implements _$GratitudeLogModelCopyWith<$Res> {
  __$GratitudeLogModelCopyWithImpl(this._self, this._then);

  final _GratitudeLogModel _self;
  final $Res Function(_GratitudeLogModel) _then;

  /// Create a copy of GratitudeLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? logDate = null,
    Object? item1 = null,
    Object? item2 = freezed,
    Object? item3 = freezed,
    Object? createdAt = null,
    Object? syncStatus = null,
  }) {
    return _then(_GratitudeLogModel(
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
      item1: null == item1
          ? _self.item1
          : item1 // ignore: cast_nullable_to_non_nullable
              as String,
      item2: freezed == item2
          ? _self.item2
          : item2 // ignore: cast_nullable_to_non_nullable
              as String?,
      item3: freezed == item3
          ? _self.item3
          : item3 // ignore: cast_nullable_to_non_nullable
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
