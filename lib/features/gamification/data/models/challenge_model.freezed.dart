// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChallengeModel {
  String get id;
  String get title;
  String get description;
  String get challengeType;
  int get targetValue;
  DateTime get startDate;
  DateTime get endDate;
  int get xpReward;
  String? get badgeId;
  bool get isActive;
  DateTime get createdAt;
  String? get userChallengeId;
  String get status;
  int get currentValue;
  DateTime? get completedAt;

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChallengeModelCopyWith<ChallengeModel> get copyWith =>
      _$ChallengeModelCopyWithImpl<ChallengeModel>(
          this as ChallengeModel, _$identity);

  /// Serializes this ChallengeModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChallengeModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.challengeType, challengeType) ||
                other.challengeType == challengeType) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.xpReward, xpReward) ||
                other.xpReward == xpReward) &&
            (identical(other.badgeId, badgeId) || other.badgeId == badgeId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.userChallengeId, userChallengeId) ||
                other.userChallengeId == userChallengeId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentValue, currentValue) ||
                other.currentValue == currentValue) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      challengeType,
      targetValue,
      startDate,
      endDate,
      xpReward,
      badgeId,
      isActive,
      createdAt,
      userChallengeId,
      status,
      currentValue,
      completedAt);

  @override
  String toString() {
    return 'ChallengeModel(id: $id, title: $title, description: $description, challengeType: $challengeType, targetValue: $targetValue, startDate: $startDate, endDate: $endDate, xpReward: $xpReward, badgeId: $badgeId, isActive: $isActive, createdAt: $createdAt, userChallengeId: $userChallengeId, status: $status, currentValue: $currentValue, completedAt: $completedAt)';
  }
}

/// @nodoc
abstract mixin class $ChallengeModelCopyWith<$Res> {
  factory $ChallengeModelCopyWith(
          ChallengeModel value, $Res Function(ChallengeModel) _then) =
      _$ChallengeModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String challengeType,
      int targetValue,
      DateTime startDate,
      DateTime endDate,
      int xpReward,
      String? badgeId,
      bool isActive,
      DateTime createdAt,
      String? userChallengeId,
      String status,
      int currentValue,
      DateTime? completedAt});
}

/// @nodoc
class _$ChallengeModelCopyWithImpl<$Res>
    implements $ChallengeModelCopyWith<$Res> {
  _$ChallengeModelCopyWithImpl(this._self, this._then);

  final ChallengeModel _self;
  final $Res Function(ChallengeModel) _then;

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? challengeType = null,
    Object? targetValue = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? xpReward = null,
    Object? badgeId = freezed,
    Object? isActive = null,
    Object? createdAt = null,
    Object? userChallengeId = freezed,
    Object? status = null,
    Object? currentValue = null,
    Object? completedAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      challengeType: null == challengeType
          ? _self.challengeType
          : challengeType // ignore: cast_nullable_to_non_nullable
              as String,
      targetValue: null == targetValue
          ? _self.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      xpReward: null == xpReward
          ? _self.xpReward
          : xpReward // ignore: cast_nullable_to_non_nullable
              as int,
      badgeId: freezed == badgeId
          ? _self.badgeId
          : badgeId // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userChallengeId: freezed == userChallengeId
          ? _self.userChallengeId
          : userChallengeId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      currentValue: null == currentValue
          ? _self.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as int,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ChallengeModel].
extension ChallengeModelPatterns on ChallengeModel {
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
    TResult Function(_ChallengeModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChallengeModel() when $default != null:
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
    TResult Function(_ChallengeModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChallengeModel():
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
    TResult? Function(_ChallengeModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChallengeModel() when $default != null:
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
            String title,
            String description,
            String challengeType,
            int targetValue,
            DateTime startDate,
            DateTime endDate,
            int xpReward,
            String? badgeId,
            bool isActive,
            DateTime createdAt,
            String? userChallengeId,
            String status,
            int currentValue,
            DateTime? completedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChallengeModel() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.description,
            _that.challengeType,
            _that.targetValue,
            _that.startDate,
            _that.endDate,
            _that.xpReward,
            _that.badgeId,
            _that.isActive,
            _that.createdAt,
            _that.userChallengeId,
            _that.status,
            _that.currentValue,
            _that.completedAt);
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
            String title,
            String description,
            String challengeType,
            int targetValue,
            DateTime startDate,
            DateTime endDate,
            int xpReward,
            String? badgeId,
            bool isActive,
            DateTime createdAt,
            String? userChallengeId,
            String status,
            int currentValue,
            DateTime? completedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChallengeModel():
        return $default(
            _that.id,
            _that.title,
            _that.description,
            _that.challengeType,
            _that.targetValue,
            _that.startDate,
            _that.endDate,
            _that.xpReward,
            _that.badgeId,
            _that.isActive,
            _that.createdAt,
            _that.userChallengeId,
            _that.status,
            _that.currentValue,
            _that.completedAt);
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
            String title,
            String description,
            String challengeType,
            int targetValue,
            DateTime startDate,
            DateTime endDate,
            int xpReward,
            String? badgeId,
            bool isActive,
            DateTime createdAt,
            String? userChallengeId,
            String status,
            int currentValue,
            DateTime? completedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChallengeModel() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.description,
            _that.challengeType,
            _that.targetValue,
            _that.startDate,
            _that.endDate,
            _that.xpReward,
            _that.badgeId,
            _that.isActive,
            _that.createdAt,
            _that.userChallengeId,
            _that.status,
            _that.currentValue,
            _that.completedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ChallengeModel implements ChallengeModel {
  const _ChallengeModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.challengeType,
      required this.targetValue,
      required this.startDate,
      required this.endDate,
      this.xpReward = 0,
      this.badgeId,
      this.isActive = true,
      required this.createdAt,
      this.userChallengeId,
      this.status = 'available',
      this.currentValue = 0,
      this.completedAt});
  factory _ChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeModelFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String challengeType;
  @override
  final int targetValue;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  @JsonKey()
  final int xpReward;
  @override
  final String? badgeId;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final String? userChallengeId;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final int currentValue;
  @override
  final DateTime? completedAt;

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChallengeModelCopyWith<_ChallengeModel> get copyWith =>
      __$ChallengeModelCopyWithImpl<_ChallengeModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChallengeModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChallengeModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.challengeType, challengeType) ||
                other.challengeType == challengeType) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.xpReward, xpReward) ||
                other.xpReward == xpReward) &&
            (identical(other.badgeId, badgeId) || other.badgeId == badgeId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.userChallengeId, userChallengeId) ||
                other.userChallengeId == userChallengeId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentValue, currentValue) ||
                other.currentValue == currentValue) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      challengeType,
      targetValue,
      startDate,
      endDate,
      xpReward,
      badgeId,
      isActive,
      createdAt,
      userChallengeId,
      status,
      currentValue,
      completedAt);

  @override
  String toString() {
    return 'ChallengeModel(id: $id, title: $title, description: $description, challengeType: $challengeType, targetValue: $targetValue, startDate: $startDate, endDate: $endDate, xpReward: $xpReward, badgeId: $badgeId, isActive: $isActive, createdAt: $createdAt, userChallengeId: $userChallengeId, status: $status, currentValue: $currentValue, completedAt: $completedAt)';
  }
}

/// @nodoc
abstract mixin class _$ChallengeModelCopyWith<$Res>
    implements $ChallengeModelCopyWith<$Res> {
  factory _$ChallengeModelCopyWith(
          _ChallengeModel value, $Res Function(_ChallengeModel) _then) =
      __$ChallengeModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String challengeType,
      int targetValue,
      DateTime startDate,
      DateTime endDate,
      int xpReward,
      String? badgeId,
      bool isActive,
      DateTime createdAt,
      String? userChallengeId,
      String status,
      int currentValue,
      DateTime? completedAt});
}

/// @nodoc
class __$ChallengeModelCopyWithImpl<$Res>
    implements _$ChallengeModelCopyWith<$Res> {
  __$ChallengeModelCopyWithImpl(this._self, this._then);

  final _ChallengeModel _self;
  final $Res Function(_ChallengeModel) _then;

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? challengeType = null,
    Object? targetValue = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? xpReward = null,
    Object? badgeId = freezed,
    Object? isActive = null,
    Object? createdAt = null,
    Object? userChallengeId = freezed,
    Object? status = null,
    Object? currentValue = null,
    Object? completedAt = freezed,
  }) {
    return _then(_ChallengeModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      challengeType: null == challengeType
          ? _self.challengeType
          : challengeType // ignore: cast_nullable_to_non_nullable
              as String,
      targetValue: null == targetValue
          ? _self.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      xpReward: null == xpReward
          ? _self.xpReward
          : xpReward // ignore: cast_nullable_to_non_nullable
              as int,
      badgeId: freezed == badgeId
          ? _self.badgeId
          : badgeId // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userChallengeId: freezed == userChallengeId
          ? _self.userChallengeId
          : userChallengeId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      currentValue: null == currentValue
          ? _self.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as int,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
