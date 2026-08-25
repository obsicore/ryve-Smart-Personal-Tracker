// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_challenge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommunityChallengeModel {
  String get id;
  String get title;
  String get description;
  String get challengeType;
  int get targetValue;
  DateTime get startDate;
  DateTime get endDate;
  bool get isActive;
  int get participantCount;
  bool get hasJoined;
  int get myProgress;

  /// Create a copy of CommunityChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommunityChallengeModelCopyWith<CommunityChallengeModel> get copyWith =>
      _$CommunityChallengeModelCopyWithImpl<CommunityChallengeModel>(
          this as CommunityChallengeModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CommunityChallengeModel &&
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
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.participantCount, participantCount) ||
                other.participantCount == participantCount) &&
            (identical(other.hasJoined, hasJoined) ||
                other.hasJoined == hasJoined) &&
            (identical(other.myProgress, myProgress) ||
                other.myProgress == myProgress));
  }

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
      isActive,
      participantCount,
      hasJoined,
      myProgress);

  @override
  String toString() {
    return 'CommunityChallengeModel(id: $id, title: $title, description: $description, challengeType: $challengeType, targetValue: $targetValue, startDate: $startDate, endDate: $endDate, isActive: $isActive, participantCount: $participantCount, hasJoined: $hasJoined, myProgress: $myProgress)';
  }
}

/// @nodoc
abstract mixin class $CommunityChallengeModelCopyWith<$Res> {
  factory $CommunityChallengeModelCopyWith(CommunityChallengeModel value,
          $Res Function(CommunityChallengeModel) _then) =
      _$CommunityChallengeModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String challengeType,
      int targetValue,
      DateTime startDate,
      DateTime endDate,
      bool isActive,
      int participantCount,
      bool hasJoined,
      int myProgress});
}

/// @nodoc
class _$CommunityChallengeModelCopyWithImpl<$Res>
    implements $CommunityChallengeModelCopyWith<$Res> {
  _$CommunityChallengeModelCopyWithImpl(this._self, this._then);

  final CommunityChallengeModel _self;
  final $Res Function(CommunityChallengeModel) _then;

  /// Create a copy of CommunityChallengeModel
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
    Object? isActive = null,
    Object? participantCount = null,
    Object? hasJoined = null,
    Object? myProgress = null,
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
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      participantCount: null == participantCount
          ? _self.participantCount
          : participantCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasJoined: null == hasJoined
          ? _self.hasJoined
          : hasJoined // ignore: cast_nullable_to_non_nullable
              as bool,
      myProgress: null == myProgress
          ? _self.myProgress
          : myProgress // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [CommunityChallengeModel].
extension CommunityChallengeModelPatterns on CommunityChallengeModel {
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
    TResult Function(_CommunityChallengeModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CommunityChallengeModel() when $default != null:
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
    TResult Function(_CommunityChallengeModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CommunityChallengeModel():
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
    TResult? Function(_CommunityChallengeModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CommunityChallengeModel() when $default != null:
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
            bool isActive,
            int participantCount,
            bool hasJoined,
            int myProgress)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CommunityChallengeModel() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.description,
            _that.challengeType,
            _that.targetValue,
            _that.startDate,
            _that.endDate,
            _that.isActive,
            _that.participantCount,
            _that.hasJoined,
            _that.myProgress);
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
            bool isActive,
            int participantCount,
            bool hasJoined,
            int myProgress)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CommunityChallengeModel():
        return $default(
            _that.id,
            _that.title,
            _that.description,
            _that.challengeType,
            _that.targetValue,
            _that.startDate,
            _that.endDate,
            _that.isActive,
            _that.participantCount,
            _that.hasJoined,
            _that.myProgress);
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
            bool isActive,
            int participantCount,
            bool hasJoined,
            int myProgress)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CommunityChallengeModel() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.description,
            _that.challengeType,
            _that.targetValue,
            _that.startDate,
            _that.endDate,
            _that.isActive,
            _that.participantCount,
            _that.hasJoined,
            _that.myProgress);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CommunityChallengeModel implements CommunityChallengeModel {
  const _CommunityChallengeModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.challengeType,
      required this.targetValue,
      required this.startDate,
      required this.endDate,
      required this.isActive,
      required this.participantCount,
      this.hasJoined = false,
      this.myProgress = 0});

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
  final bool isActive;
  @override
  final int participantCount;
  @override
  @JsonKey()
  final bool hasJoined;
  @override
  @JsonKey()
  final int myProgress;

  /// Create a copy of CommunityChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CommunityChallengeModelCopyWith<_CommunityChallengeModel> get copyWith =>
      __$CommunityChallengeModelCopyWithImpl<_CommunityChallengeModel>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CommunityChallengeModel &&
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
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.participantCount, participantCount) ||
                other.participantCount == participantCount) &&
            (identical(other.hasJoined, hasJoined) ||
                other.hasJoined == hasJoined) &&
            (identical(other.myProgress, myProgress) ||
                other.myProgress == myProgress));
  }

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
      isActive,
      participantCount,
      hasJoined,
      myProgress);

  @override
  String toString() {
    return 'CommunityChallengeModel(id: $id, title: $title, description: $description, challengeType: $challengeType, targetValue: $targetValue, startDate: $startDate, endDate: $endDate, isActive: $isActive, participantCount: $participantCount, hasJoined: $hasJoined, myProgress: $myProgress)';
  }
}

/// @nodoc
abstract mixin class _$CommunityChallengeModelCopyWith<$Res>
    implements $CommunityChallengeModelCopyWith<$Res> {
  factory _$CommunityChallengeModelCopyWith(_CommunityChallengeModel value,
          $Res Function(_CommunityChallengeModel) _then) =
      __$CommunityChallengeModelCopyWithImpl;
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
      bool isActive,
      int participantCount,
      bool hasJoined,
      int myProgress});
}

/// @nodoc
class __$CommunityChallengeModelCopyWithImpl<$Res>
    implements _$CommunityChallengeModelCopyWith<$Res> {
  __$CommunityChallengeModelCopyWithImpl(this._self, this._then);

  final _CommunityChallengeModel _self;
  final $Res Function(_CommunityChallengeModel) _then;

  /// Create a copy of CommunityChallengeModel
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
    Object? isActive = null,
    Object? participantCount = null,
    Object? hasJoined = null,
    Object? myProgress = null,
  }) {
    return _then(_CommunityChallengeModel(
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
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      participantCount: null == participantCount
          ? _self.participantCount
          : participantCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasJoined: null == hasJoined
          ? _self.hasJoined
          : hasJoined // ignore: cast_nullable_to_non_nullable
              as bool,
      myProgress: null == myProgress
          ? _self.myProgress
          : myProgress // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$LeaderboardEntryModel {
  String get userId;
  String get displayName;
  int get currentValue;
  int get rank;

  /// Create a copy of LeaderboardEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LeaderboardEntryModelCopyWith<LeaderboardEntryModel> get copyWith =>
      _$LeaderboardEntryModelCopyWithImpl<LeaderboardEntryModel>(
          this as LeaderboardEntryModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LeaderboardEntryModel &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.currentValue, currentValue) ||
                other.currentValue == currentValue) &&
            (identical(other.rank, rank) || other.rank == rank));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, displayName, currentValue, rank);

  @override
  String toString() {
    return 'LeaderboardEntryModel(userId: $userId, displayName: $displayName, currentValue: $currentValue, rank: $rank)';
  }
}

/// @nodoc
abstract mixin class $LeaderboardEntryModelCopyWith<$Res> {
  factory $LeaderboardEntryModelCopyWith(LeaderboardEntryModel value,
          $Res Function(LeaderboardEntryModel) _then) =
      _$LeaderboardEntryModelCopyWithImpl;
  @useResult
  $Res call({String userId, String displayName, int currentValue, int rank});
}

/// @nodoc
class _$LeaderboardEntryModelCopyWithImpl<$Res>
    implements $LeaderboardEntryModelCopyWith<$Res> {
  _$LeaderboardEntryModelCopyWithImpl(this._self, this._then);

  final LeaderboardEntryModel _self;
  final $Res Function(LeaderboardEntryModel) _then;

  /// Create a copy of LeaderboardEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? currentValue = null,
    Object? rank = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      currentValue: null == currentValue
          ? _self.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as int,
      rank: null == rank
          ? _self.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [LeaderboardEntryModel].
extension LeaderboardEntryModelPatterns on LeaderboardEntryModel {
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
    TResult Function(_LeaderboardEntryModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaderboardEntryModel() when $default != null:
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
    TResult Function(_LeaderboardEntryModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaderboardEntryModel():
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
    TResult? Function(_LeaderboardEntryModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaderboardEntryModel() when $default != null:
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
            String userId, String displayName, int currentValue, int rank)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaderboardEntryModel() when $default != null:
        return $default(
            _that.userId, _that.displayName, _that.currentValue, _that.rank);
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
            String userId, String displayName, int currentValue, int rank)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaderboardEntryModel():
        return $default(
            _that.userId, _that.displayName, _that.currentValue, _that.rank);
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
            String userId, String displayName, int currentValue, int rank)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaderboardEntryModel() when $default != null:
        return $default(
            _that.userId, _that.displayName, _that.currentValue, _that.rank);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _LeaderboardEntryModel implements LeaderboardEntryModel {
  const _LeaderboardEntryModel(
      {required this.userId,
      required this.displayName,
      required this.currentValue,
      required this.rank});

  @override
  final String userId;
  @override
  final String displayName;
  @override
  final int currentValue;
  @override
  final int rank;

  /// Create a copy of LeaderboardEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LeaderboardEntryModelCopyWith<_LeaderboardEntryModel> get copyWith =>
      __$LeaderboardEntryModelCopyWithImpl<_LeaderboardEntryModel>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LeaderboardEntryModel &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.currentValue, currentValue) ||
                other.currentValue == currentValue) &&
            (identical(other.rank, rank) || other.rank == rank));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, displayName, currentValue, rank);

  @override
  String toString() {
    return 'LeaderboardEntryModel(userId: $userId, displayName: $displayName, currentValue: $currentValue, rank: $rank)';
  }
}

/// @nodoc
abstract mixin class _$LeaderboardEntryModelCopyWith<$Res>
    implements $LeaderboardEntryModelCopyWith<$Res> {
  factory _$LeaderboardEntryModelCopyWith(_LeaderboardEntryModel value,
          $Res Function(_LeaderboardEntryModel) _then) =
      __$LeaderboardEntryModelCopyWithImpl;
  @override
  @useResult
  $Res call({String userId, String displayName, int currentValue, int rank});
}

/// @nodoc
class __$LeaderboardEntryModelCopyWithImpl<$Res>
    implements _$LeaderboardEntryModelCopyWith<$Res> {
  __$LeaderboardEntryModelCopyWithImpl(this._self, this._then);

  final _LeaderboardEntryModel _self;
  final $Res Function(_LeaderboardEntryModel) _then;

  /// Create a copy of LeaderboardEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? currentValue = null,
    Object? rank = null,
  }) {
    return _then(_LeaderboardEntryModel(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      currentValue: null == currentValue
          ? _self.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as int,
      rank: null == rank
          ? _self.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
