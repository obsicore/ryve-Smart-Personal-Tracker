// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'milestone_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MilestoneModel {
  String get id;
  String get goalId;
  String get title;
  double get targetValue;
  int get sortOrder;
  bool get isComplete;
  DateTime? get completedAt;
  DateTime get createdAt;

  /// Create a copy of MilestoneModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MilestoneModelCopyWith<MilestoneModel> get copyWith =>
      _$MilestoneModelCopyWithImpl<MilestoneModel>(
          this as MilestoneModel, _$identity);

  /// Serializes this MilestoneModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MilestoneModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.goalId, goalId) || other.goalId == goalId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isComplete, isComplete) ||
                other.isComplete == isComplete) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, goalId, title, targetValue,
      sortOrder, isComplete, completedAt, createdAt);

  @override
  String toString() {
    return 'MilestoneModel(id: $id, goalId: $goalId, title: $title, targetValue: $targetValue, sortOrder: $sortOrder, isComplete: $isComplete, completedAt: $completedAt, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $MilestoneModelCopyWith<$Res> {
  factory $MilestoneModelCopyWith(
          MilestoneModel value, $Res Function(MilestoneModel) _then) =
      _$MilestoneModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String goalId,
      String title,
      double targetValue,
      int sortOrder,
      bool isComplete,
      DateTime? completedAt,
      DateTime createdAt});
}

/// @nodoc
class _$MilestoneModelCopyWithImpl<$Res>
    implements $MilestoneModelCopyWith<$Res> {
  _$MilestoneModelCopyWithImpl(this._self, this._then);

  final MilestoneModel _self;
  final $Res Function(MilestoneModel) _then;

  /// Create a copy of MilestoneModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? goalId = null,
    Object? title = null,
    Object? targetValue = null,
    Object? sortOrder = null,
    Object? isComplete = null,
    Object? completedAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      goalId: null == goalId
          ? _self.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      targetValue: null == targetValue
          ? _self.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as double,
      sortOrder: null == sortOrder
          ? _self.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      isComplete: null == isComplete
          ? _self.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [MilestoneModel].
extension MilestoneModelPatterns on MilestoneModel {
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
    TResult Function(_MilestoneModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MilestoneModel() when $default != null:
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
    TResult Function(_MilestoneModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MilestoneModel():
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
    TResult? Function(_MilestoneModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MilestoneModel() when $default != null:
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
            String goalId,
            String title,
            double targetValue,
            int sortOrder,
            bool isComplete,
            DateTime? completedAt,
            DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MilestoneModel() when $default != null:
        return $default(
            _that.id,
            _that.goalId,
            _that.title,
            _that.targetValue,
            _that.sortOrder,
            _that.isComplete,
            _that.completedAt,
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
            String goalId,
            String title,
            double targetValue,
            int sortOrder,
            bool isComplete,
            DateTime? completedAt,
            DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MilestoneModel():
        return $default(
            _that.id,
            _that.goalId,
            _that.title,
            _that.targetValue,
            _that.sortOrder,
            _that.isComplete,
            _that.completedAt,
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
            String goalId,
            String title,
            double targetValue,
            int sortOrder,
            bool isComplete,
            DateTime? completedAt,
            DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MilestoneModel() when $default != null:
        return $default(
            _that.id,
            _that.goalId,
            _that.title,
            _that.targetValue,
            _that.sortOrder,
            _that.isComplete,
            _that.completedAt,
            _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MilestoneModel implements MilestoneModel {
  const _MilestoneModel(
      {required this.id,
      required this.goalId,
      required this.title,
      required this.targetValue,
      this.sortOrder = 0,
      this.isComplete = false,
      this.completedAt,
      required this.createdAt});
  factory _MilestoneModel.fromJson(Map<String, dynamic> json) =>
      _$MilestoneModelFromJson(json);

  @override
  final String id;
  @override
  final String goalId;
  @override
  final String title;
  @override
  final double targetValue;
  @override
  @JsonKey()
  final int sortOrder;
  @override
  @JsonKey()
  final bool isComplete;
  @override
  final DateTime? completedAt;
  @override
  final DateTime createdAt;

  /// Create a copy of MilestoneModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MilestoneModelCopyWith<_MilestoneModel> get copyWith =>
      __$MilestoneModelCopyWithImpl<_MilestoneModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MilestoneModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MilestoneModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.goalId, goalId) || other.goalId == goalId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isComplete, isComplete) ||
                other.isComplete == isComplete) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, goalId, title, targetValue,
      sortOrder, isComplete, completedAt, createdAt);

  @override
  String toString() {
    return 'MilestoneModel(id: $id, goalId: $goalId, title: $title, targetValue: $targetValue, sortOrder: $sortOrder, isComplete: $isComplete, completedAt: $completedAt, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$MilestoneModelCopyWith<$Res>
    implements $MilestoneModelCopyWith<$Res> {
  factory _$MilestoneModelCopyWith(
          _MilestoneModel value, $Res Function(_MilestoneModel) _then) =
      __$MilestoneModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String goalId,
      String title,
      double targetValue,
      int sortOrder,
      bool isComplete,
      DateTime? completedAt,
      DateTime createdAt});
}

/// @nodoc
class __$MilestoneModelCopyWithImpl<$Res>
    implements _$MilestoneModelCopyWith<$Res> {
  __$MilestoneModelCopyWithImpl(this._self, this._then);

  final _MilestoneModel _self;
  final $Res Function(_MilestoneModel) _then;

  /// Create a copy of MilestoneModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? goalId = null,
    Object? title = null,
    Object? targetValue = null,
    Object? sortOrder = null,
    Object? isComplete = null,
    Object? completedAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_MilestoneModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      goalId: null == goalId
          ? _self.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      targetValue: null == targetValue
          ? _self.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as double,
      sortOrder: null == sortOrder
          ? _self.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      isComplete: null == isComplete
          ? _self.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
