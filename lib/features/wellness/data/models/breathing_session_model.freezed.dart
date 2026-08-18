// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'breathing_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BreathingSessionModel {
  String get id;
  String get userId;
  String get technique;
  int get durationMin;
  int get cyclesCompleted;
  int? get moodBefore;
  int? get moodAfter;
  bool get completed;
  DateTime get startedAt;
  DateTime? get endedAt;
  DateTime get createdAt;

  /// Create a copy of BreathingSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BreathingSessionModelCopyWith<BreathingSessionModel> get copyWith =>
      _$BreathingSessionModelCopyWithImpl<BreathingSessionModel>(
          this as BreathingSessionModel, _$identity);

  /// Serializes this BreathingSessionModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BreathingSessionModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.technique, technique) ||
                other.technique == technique) &&
            (identical(other.durationMin, durationMin) ||
                other.durationMin == durationMin) &&
            (identical(other.cyclesCompleted, cyclesCompleted) ||
                other.cyclesCompleted == cyclesCompleted) &&
            (identical(other.moodBefore, moodBefore) ||
                other.moodBefore == moodBefore) &&
            (identical(other.moodAfter, moodAfter) ||
                other.moodAfter == moodAfter) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      technique,
      durationMin,
      cyclesCompleted,
      moodBefore,
      moodAfter,
      completed,
      startedAt,
      endedAt,
      createdAt);

  @override
  String toString() {
    return 'BreathingSessionModel(id: $id, userId: $userId, technique: $technique, durationMin: $durationMin, cyclesCompleted: $cyclesCompleted, moodBefore: $moodBefore, moodAfter: $moodAfter, completed: $completed, startedAt: $startedAt, endedAt: $endedAt, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $BreathingSessionModelCopyWith<$Res> {
  factory $BreathingSessionModelCopyWith(BreathingSessionModel value,
          $Res Function(BreathingSessionModel) _then) =
      _$BreathingSessionModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String technique,
      int durationMin,
      int cyclesCompleted,
      int? moodBefore,
      int? moodAfter,
      bool completed,
      DateTime startedAt,
      DateTime? endedAt,
      DateTime createdAt});
}

/// @nodoc
class _$BreathingSessionModelCopyWithImpl<$Res>
    implements $BreathingSessionModelCopyWith<$Res> {
  _$BreathingSessionModelCopyWithImpl(this._self, this._then);

  final BreathingSessionModel _self;
  final $Res Function(BreathingSessionModel) _then;

  /// Create a copy of BreathingSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? technique = null,
    Object? durationMin = null,
    Object? cyclesCompleted = null,
    Object? moodBefore = freezed,
    Object? moodAfter = freezed,
    Object? completed = null,
    Object? startedAt = null,
    Object? endedAt = freezed,
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
      technique: null == technique
          ? _self.technique
          : technique // ignore: cast_nullable_to_non_nullable
              as String,
      durationMin: null == durationMin
          ? _self.durationMin
          : durationMin // ignore: cast_nullable_to_non_nullable
              as int,
      cyclesCompleted: null == cyclesCompleted
          ? _self.cyclesCompleted
          : cyclesCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      moodBefore: freezed == moodBefore
          ? _self.moodBefore
          : moodBefore // ignore: cast_nullable_to_non_nullable
              as int?,
      moodAfter: freezed == moodAfter
          ? _self.moodAfter
          : moodAfter // ignore: cast_nullable_to_non_nullable
              as int?,
      completed: null == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      startedAt: null == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endedAt: freezed == endedAt
          ? _self.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [BreathingSessionModel].
extension BreathingSessionModelPatterns on BreathingSessionModel {
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
    TResult Function(_BreathingSessionModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BreathingSessionModel() when $default != null:
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
    TResult Function(_BreathingSessionModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BreathingSessionModel():
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
    TResult? Function(_BreathingSessionModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BreathingSessionModel() when $default != null:
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
            String technique,
            int durationMin,
            int cyclesCompleted,
            int? moodBefore,
            int? moodAfter,
            bool completed,
            DateTime startedAt,
            DateTime? endedAt,
            DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BreathingSessionModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.technique,
            _that.durationMin,
            _that.cyclesCompleted,
            _that.moodBefore,
            _that.moodAfter,
            _that.completed,
            _that.startedAt,
            _that.endedAt,
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
            String technique,
            int durationMin,
            int cyclesCompleted,
            int? moodBefore,
            int? moodAfter,
            bool completed,
            DateTime startedAt,
            DateTime? endedAt,
            DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BreathingSessionModel():
        return $default(
            _that.id,
            _that.userId,
            _that.technique,
            _that.durationMin,
            _that.cyclesCompleted,
            _that.moodBefore,
            _that.moodAfter,
            _that.completed,
            _that.startedAt,
            _that.endedAt,
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
            String technique,
            int durationMin,
            int cyclesCompleted,
            int? moodBefore,
            int? moodAfter,
            bool completed,
            DateTime startedAt,
            DateTime? endedAt,
            DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BreathingSessionModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.technique,
            _that.durationMin,
            _that.cyclesCompleted,
            _that.moodBefore,
            _that.moodAfter,
            _that.completed,
            _that.startedAt,
            _that.endedAt,
            _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BreathingSessionModel implements BreathingSessionModel {
  const _BreathingSessionModel(
      {required this.id,
      required this.userId,
      required this.technique,
      required this.durationMin,
      this.cyclesCompleted = 0,
      this.moodBefore,
      this.moodAfter,
      this.completed = false,
      required this.startedAt,
      this.endedAt,
      required this.createdAt});
  factory _BreathingSessionModel.fromJson(Map<String, dynamic> json) =>
      _$BreathingSessionModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String technique;
  @override
  final int durationMin;
  @override
  @JsonKey()
  final int cyclesCompleted;
  @override
  final int? moodBefore;
  @override
  final int? moodAfter;
  @override
  @JsonKey()
  final bool completed;
  @override
  final DateTime startedAt;
  @override
  final DateTime? endedAt;
  @override
  final DateTime createdAt;

  /// Create a copy of BreathingSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BreathingSessionModelCopyWith<_BreathingSessionModel> get copyWith =>
      __$BreathingSessionModelCopyWithImpl<_BreathingSessionModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BreathingSessionModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BreathingSessionModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.technique, technique) ||
                other.technique == technique) &&
            (identical(other.durationMin, durationMin) ||
                other.durationMin == durationMin) &&
            (identical(other.cyclesCompleted, cyclesCompleted) ||
                other.cyclesCompleted == cyclesCompleted) &&
            (identical(other.moodBefore, moodBefore) ||
                other.moodBefore == moodBefore) &&
            (identical(other.moodAfter, moodAfter) ||
                other.moodAfter == moodAfter) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      technique,
      durationMin,
      cyclesCompleted,
      moodBefore,
      moodAfter,
      completed,
      startedAt,
      endedAt,
      createdAt);

  @override
  String toString() {
    return 'BreathingSessionModel(id: $id, userId: $userId, technique: $technique, durationMin: $durationMin, cyclesCompleted: $cyclesCompleted, moodBefore: $moodBefore, moodAfter: $moodAfter, completed: $completed, startedAt: $startedAt, endedAt: $endedAt, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$BreathingSessionModelCopyWith<$Res>
    implements $BreathingSessionModelCopyWith<$Res> {
  factory _$BreathingSessionModelCopyWith(_BreathingSessionModel value,
          $Res Function(_BreathingSessionModel) _then) =
      __$BreathingSessionModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String technique,
      int durationMin,
      int cyclesCompleted,
      int? moodBefore,
      int? moodAfter,
      bool completed,
      DateTime startedAt,
      DateTime? endedAt,
      DateTime createdAt});
}

/// @nodoc
class __$BreathingSessionModelCopyWithImpl<$Res>
    implements _$BreathingSessionModelCopyWith<$Res> {
  __$BreathingSessionModelCopyWithImpl(this._self, this._then);

  final _BreathingSessionModel _self;
  final $Res Function(_BreathingSessionModel) _then;

  /// Create a copy of BreathingSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? technique = null,
    Object? durationMin = null,
    Object? cyclesCompleted = null,
    Object? moodBefore = freezed,
    Object? moodAfter = freezed,
    Object? completed = null,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_BreathingSessionModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      technique: null == technique
          ? _self.technique
          : technique // ignore: cast_nullable_to_non_nullable
              as String,
      durationMin: null == durationMin
          ? _self.durationMin
          : durationMin // ignore: cast_nullable_to_non_nullable
              as int,
      cyclesCompleted: null == cyclesCompleted
          ? _self.cyclesCompleted
          : cyclesCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      moodBefore: freezed == moodBefore
          ? _self.moodBefore
          : moodBefore // ignore: cast_nullable_to_non_nullable
              as int?,
      moodAfter: freezed == moodAfter
          ? _self.moodAfter
          : moodAfter // ignore: cast_nullable_to_non_nullable
              as int?,
      completed: null == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      startedAt: null == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endedAt: freezed == endedAt
          ? _self.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
