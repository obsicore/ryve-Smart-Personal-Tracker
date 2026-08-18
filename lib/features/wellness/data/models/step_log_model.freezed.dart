// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'step_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StepLogModel {
  String get id;
  String get userId;
  DateTime get logDate;
  int get stepCount;
  double? get distanceM;
  int? get calories;
  String get source;
  DateTime get updatedAt;

  /// Create a copy of StepLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StepLogModelCopyWith<StepLogModel> get copyWith =>
      _$StepLogModelCopyWithImpl<StepLogModel>(
          this as StepLogModel, _$identity);

  /// Serializes this StepLogModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StepLogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.logDate, logDate) || other.logDate == logDate) &&
            (identical(other.stepCount, stepCount) ||
                other.stepCount == stepCount) &&
            (identical(other.distanceM, distanceM) ||
                other.distanceM == distanceM) &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, logDate, stepCount,
      distanceM, calories, source, updatedAt);

  @override
  String toString() {
    return 'StepLogModel(id: $id, userId: $userId, logDate: $logDate, stepCount: $stepCount, distanceM: $distanceM, calories: $calories, source: $source, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $StepLogModelCopyWith<$Res> {
  factory $StepLogModelCopyWith(
          StepLogModel value, $Res Function(StepLogModel) _then) =
      _$StepLogModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime logDate,
      int stepCount,
      double? distanceM,
      int? calories,
      String source,
      DateTime updatedAt});
}

/// @nodoc
class _$StepLogModelCopyWithImpl<$Res> implements $StepLogModelCopyWith<$Res> {
  _$StepLogModelCopyWithImpl(this._self, this._then);

  final StepLogModel _self;
  final $Res Function(StepLogModel) _then;

  /// Create a copy of StepLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? logDate = null,
    Object? stepCount = null,
    Object? distanceM = freezed,
    Object? calories = freezed,
    Object? source = null,
    Object? updatedAt = null,
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
      stepCount: null == stepCount
          ? _self.stepCount
          : stepCount // ignore: cast_nullable_to_non_nullable
              as int,
      distanceM: freezed == distanceM
          ? _self.distanceM
          : distanceM // ignore: cast_nullable_to_non_nullable
              as double?,
      calories: freezed == calories
          ? _self.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int?,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [StepLogModel].
extension StepLogModelPatterns on StepLogModel {
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
    TResult Function(_StepLogModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StepLogModel() when $default != null:
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
    TResult Function(_StepLogModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StepLogModel():
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
    TResult? Function(_StepLogModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StepLogModel() when $default != null:
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
            int stepCount,
            double? distanceM,
            int? calories,
            String source,
            DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StepLogModel() when $default != null:
        return $default(_that.id, _that.userId, _that.logDate, _that.stepCount,
            _that.distanceM, _that.calories, _that.source, _that.updatedAt);
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
    TResult Function(String id, String userId, DateTime logDate, int stepCount,
            double? distanceM, int? calories, String source, DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StepLogModel():
        return $default(_that.id, _that.userId, _that.logDate, _that.stepCount,
            _that.distanceM, _that.calories, _that.source, _that.updatedAt);
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
            int stepCount,
            double? distanceM,
            int? calories,
            String source,
            DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StepLogModel() when $default != null:
        return $default(_that.id, _that.userId, _that.logDate, _that.stepCount,
            _that.distanceM, _that.calories, _that.source, _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StepLogModel implements StepLogModel {
  const _StepLogModel(
      {required this.id,
      required this.userId,
      required this.logDate,
      required this.stepCount,
      this.distanceM,
      this.calories,
      this.source = 'manual',
      required this.updatedAt});
  factory _StepLogModel.fromJson(Map<String, dynamic> json) =>
      _$StepLogModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime logDate;
  @override
  final int stepCount;
  @override
  final double? distanceM;
  @override
  final int? calories;
  @override
  @JsonKey()
  final String source;
  @override
  final DateTime updatedAt;

  /// Create a copy of StepLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StepLogModelCopyWith<_StepLogModel> get copyWith =>
      __$StepLogModelCopyWithImpl<_StepLogModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StepLogModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StepLogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.logDate, logDate) || other.logDate == logDate) &&
            (identical(other.stepCount, stepCount) ||
                other.stepCount == stepCount) &&
            (identical(other.distanceM, distanceM) ||
                other.distanceM == distanceM) &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, logDate, stepCount,
      distanceM, calories, source, updatedAt);

  @override
  String toString() {
    return 'StepLogModel(id: $id, userId: $userId, logDate: $logDate, stepCount: $stepCount, distanceM: $distanceM, calories: $calories, source: $source, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$StepLogModelCopyWith<$Res>
    implements $StepLogModelCopyWith<$Res> {
  factory _$StepLogModelCopyWith(
          _StepLogModel value, $Res Function(_StepLogModel) _then) =
      __$StepLogModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime logDate,
      int stepCount,
      double? distanceM,
      int? calories,
      String source,
      DateTime updatedAt});
}

/// @nodoc
class __$StepLogModelCopyWithImpl<$Res>
    implements _$StepLogModelCopyWith<$Res> {
  __$StepLogModelCopyWithImpl(this._self, this._then);

  final _StepLogModel _self;
  final $Res Function(_StepLogModel) _then;

  /// Create a copy of StepLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? logDate = null,
    Object? stepCount = null,
    Object? distanceM = freezed,
    Object? calories = freezed,
    Object? source = null,
    Object? updatedAt = null,
  }) {
    return _then(_StepLogModel(
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
      stepCount: null == stepCount
          ? _self.stepCount
          : stepCount // ignore: cast_nullable_to_non_nullable
              as int,
      distanceM: freezed == distanceM
          ? _self.distanceM
          : distanceM // ignore: cast_nullable_to_non_nullable
              as double?,
      calories: freezed == calories
          ? _self.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int?,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
