// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'focus_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FocusSessionModel {
  String get id;
  String get userId;
  int get durationMinutes;
  FocusSessionType get sessionType;
  bool get wasCompleted;
  String? get linkedTaskId;
  DateTime get startedAt;
  DateTime get endedAt;
  int get syncStatus;

  /// Create a copy of FocusSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FocusSessionModelCopyWith<FocusSessionModel> get copyWith =>
      _$FocusSessionModelCopyWithImpl<FocusSessionModel>(
          this as FocusSessionModel, _$identity);

  /// Serializes this FocusSessionModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FocusSessionModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.sessionType, sessionType) ||
                other.sessionType == sessionType) &&
            (identical(other.wasCompleted, wasCompleted) ||
                other.wasCompleted == wasCompleted) &&
            (identical(other.linkedTaskId, linkedTaskId) ||
                other.linkedTaskId == linkedTaskId) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, durationMinutes,
      sessionType, wasCompleted, linkedTaskId, startedAt, endedAt, syncStatus);

  @override
  String toString() {
    return 'FocusSessionModel(id: $id, userId: $userId, durationMinutes: $durationMinutes, sessionType: $sessionType, wasCompleted: $wasCompleted, linkedTaskId: $linkedTaskId, startedAt: $startedAt, endedAt: $endedAt, syncStatus: $syncStatus)';
  }
}

/// @nodoc
abstract mixin class $FocusSessionModelCopyWith<$Res> {
  factory $FocusSessionModelCopyWith(
          FocusSessionModel value, $Res Function(FocusSessionModel) _then) =
      _$FocusSessionModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      int durationMinutes,
      FocusSessionType sessionType,
      bool wasCompleted,
      String? linkedTaskId,
      DateTime startedAt,
      DateTime endedAt,
      int syncStatus});
}

/// @nodoc
class _$FocusSessionModelCopyWithImpl<$Res>
    implements $FocusSessionModelCopyWith<$Res> {
  _$FocusSessionModelCopyWithImpl(this._self, this._then);

  final FocusSessionModel _self;
  final $Res Function(FocusSessionModel) _then;

  /// Create a copy of FocusSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? durationMinutes = null,
    Object? sessionType = null,
    Object? wasCompleted = null,
    Object? linkedTaskId = freezed,
    Object? startedAt = null,
    Object? endedAt = null,
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
      durationMinutes: null == durationMinutes
          ? _self.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      sessionType: null == sessionType
          ? _self.sessionType
          : sessionType // ignore: cast_nullable_to_non_nullable
              as FocusSessionType,
      wasCompleted: null == wasCompleted
          ? _self.wasCompleted
          : wasCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      linkedTaskId: freezed == linkedTaskId
          ? _self.linkedTaskId
          : linkedTaskId // ignore: cast_nullable_to_non_nullable
              as String?,
      startedAt: null == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endedAt: null == endedAt
          ? _self.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncStatus: null == syncStatus
          ? _self.syncStatus
          : syncStatus // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [FocusSessionModel].
extension FocusSessionModelPatterns on FocusSessionModel {
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
    TResult Function(_FocusSessionModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FocusSessionModel() when $default != null:
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
    TResult Function(_FocusSessionModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FocusSessionModel():
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
    TResult? Function(_FocusSessionModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FocusSessionModel() when $default != null:
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
            int durationMinutes,
            FocusSessionType sessionType,
            bool wasCompleted,
            String? linkedTaskId,
            DateTime startedAt,
            DateTime endedAt,
            int syncStatus)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FocusSessionModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.durationMinutes,
            _that.sessionType,
            _that.wasCompleted,
            _that.linkedTaskId,
            _that.startedAt,
            _that.endedAt,
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
            int durationMinutes,
            FocusSessionType sessionType,
            bool wasCompleted,
            String? linkedTaskId,
            DateTime startedAt,
            DateTime endedAt,
            int syncStatus)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FocusSessionModel():
        return $default(
            _that.id,
            _that.userId,
            _that.durationMinutes,
            _that.sessionType,
            _that.wasCompleted,
            _that.linkedTaskId,
            _that.startedAt,
            _that.endedAt,
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
            int durationMinutes,
            FocusSessionType sessionType,
            bool wasCompleted,
            String? linkedTaskId,
            DateTime startedAt,
            DateTime endedAt,
            int syncStatus)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FocusSessionModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.durationMinutes,
            _that.sessionType,
            _that.wasCompleted,
            _that.linkedTaskId,
            _that.startedAt,
            _that.endedAt,
            _that.syncStatus);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FocusSessionModel implements FocusSessionModel {
  const _FocusSessionModel(
      {required this.id,
      required this.userId,
      required this.durationMinutes,
      this.sessionType = FocusSessionType.work,
      this.wasCompleted = true,
      this.linkedTaskId,
      required this.startedAt,
      required this.endedAt,
      this.syncStatus = 0});
  factory _FocusSessionModel.fromJson(Map<String, dynamic> json) =>
      _$FocusSessionModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final int durationMinutes;
  @override
  @JsonKey()
  final FocusSessionType sessionType;
  @override
  @JsonKey()
  final bool wasCompleted;
  @override
  final String? linkedTaskId;
  @override
  final DateTime startedAt;
  @override
  final DateTime endedAt;
  @override
  @JsonKey()
  final int syncStatus;

  /// Create a copy of FocusSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FocusSessionModelCopyWith<_FocusSessionModel> get copyWith =>
      __$FocusSessionModelCopyWithImpl<_FocusSessionModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FocusSessionModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FocusSessionModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.sessionType, sessionType) ||
                other.sessionType == sessionType) &&
            (identical(other.wasCompleted, wasCompleted) ||
                other.wasCompleted == wasCompleted) &&
            (identical(other.linkedTaskId, linkedTaskId) ||
                other.linkedTaskId == linkedTaskId) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, durationMinutes,
      sessionType, wasCompleted, linkedTaskId, startedAt, endedAt, syncStatus);

  @override
  String toString() {
    return 'FocusSessionModel(id: $id, userId: $userId, durationMinutes: $durationMinutes, sessionType: $sessionType, wasCompleted: $wasCompleted, linkedTaskId: $linkedTaskId, startedAt: $startedAt, endedAt: $endedAt, syncStatus: $syncStatus)';
  }
}

/// @nodoc
abstract mixin class _$FocusSessionModelCopyWith<$Res>
    implements $FocusSessionModelCopyWith<$Res> {
  factory _$FocusSessionModelCopyWith(
          _FocusSessionModel value, $Res Function(_FocusSessionModel) _then) =
      __$FocusSessionModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      int durationMinutes,
      FocusSessionType sessionType,
      bool wasCompleted,
      String? linkedTaskId,
      DateTime startedAt,
      DateTime endedAt,
      int syncStatus});
}

/// @nodoc
class __$FocusSessionModelCopyWithImpl<$Res>
    implements _$FocusSessionModelCopyWith<$Res> {
  __$FocusSessionModelCopyWithImpl(this._self, this._then);

  final _FocusSessionModel _self;
  final $Res Function(_FocusSessionModel) _then;

  /// Create a copy of FocusSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? durationMinutes = null,
    Object? sessionType = null,
    Object? wasCompleted = null,
    Object? linkedTaskId = freezed,
    Object? startedAt = null,
    Object? endedAt = null,
    Object? syncStatus = null,
  }) {
    return _then(_FocusSessionModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      durationMinutes: null == durationMinutes
          ? _self.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      sessionType: null == sessionType
          ? _self.sessionType
          : sessionType // ignore: cast_nullable_to_non_nullable
              as FocusSessionType,
      wasCompleted: null == wasCompleted
          ? _self.wasCompleted
          : wasCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      linkedTaskId: freezed == linkedTaskId
          ? _self.linkedTaskId
          : linkedTaskId // ignore: cast_nullable_to_non_nullable
              as String?,
      startedAt: null == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endedAt: null == endedAt
          ? _self.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncStatus: null == syncStatus
          ? _self.syncStatus
          : syncStatus // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$FocusSettingsModel {
  String get userId;
  int get workMinutes;
  int get shortBreakMinutes;
  int get longBreakMinutes;
  int get sessionsBeforeLongBreak;
  bool get autoStartBreaks;
  bool get soundEnabled;

  /// Create a copy of FocusSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FocusSettingsModelCopyWith<FocusSettingsModel> get copyWith =>
      _$FocusSettingsModelCopyWithImpl<FocusSettingsModel>(
          this as FocusSettingsModel, _$identity);

  /// Serializes this FocusSettingsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FocusSettingsModel &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.workMinutes, workMinutes) ||
                other.workMinutes == workMinutes) &&
            (identical(other.shortBreakMinutes, shortBreakMinutes) ||
                other.shortBreakMinutes == shortBreakMinutes) &&
            (identical(other.longBreakMinutes, longBreakMinutes) ||
                other.longBreakMinutes == longBreakMinutes) &&
            (identical(
                    other.sessionsBeforeLongBreak, sessionsBeforeLongBreak) ||
                other.sessionsBeforeLongBreak == sessionsBeforeLongBreak) &&
            (identical(other.autoStartBreaks, autoStartBreaks) ||
                other.autoStartBreaks == autoStartBreaks) &&
            (identical(other.soundEnabled, soundEnabled) ||
                other.soundEnabled == soundEnabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      workMinutes,
      shortBreakMinutes,
      longBreakMinutes,
      sessionsBeforeLongBreak,
      autoStartBreaks,
      soundEnabled);

  @override
  String toString() {
    return 'FocusSettingsModel(userId: $userId, workMinutes: $workMinutes, shortBreakMinutes: $shortBreakMinutes, longBreakMinutes: $longBreakMinutes, sessionsBeforeLongBreak: $sessionsBeforeLongBreak, autoStartBreaks: $autoStartBreaks, soundEnabled: $soundEnabled)';
  }
}

/// @nodoc
abstract mixin class $FocusSettingsModelCopyWith<$Res> {
  factory $FocusSettingsModelCopyWith(
          FocusSettingsModel value, $Res Function(FocusSettingsModel) _then) =
      _$FocusSettingsModelCopyWithImpl;
  @useResult
  $Res call(
      {String userId,
      int workMinutes,
      int shortBreakMinutes,
      int longBreakMinutes,
      int sessionsBeforeLongBreak,
      bool autoStartBreaks,
      bool soundEnabled});
}

/// @nodoc
class _$FocusSettingsModelCopyWithImpl<$Res>
    implements $FocusSettingsModelCopyWith<$Res> {
  _$FocusSettingsModelCopyWithImpl(this._self, this._then);

  final FocusSettingsModel _self;
  final $Res Function(FocusSettingsModel) _then;

  /// Create a copy of FocusSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? workMinutes = null,
    Object? shortBreakMinutes = null,
    Object? longBreakMinutes = null,
    Object? sessionsBeforeLongBreak = null,
    Object? autoStartBreaks = null,
    Object? soundEnabled = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      workMinutes: null == workMinutes
          ? _self.workMinutes
          : workMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      shortBreakMinutes: null == shortBreakMinutes
          ? _self.shortBreakMinutes
          : shortBreakMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      longBreakMinutes: null == longBreakMinutes
          ? _self.longBreakMinutes
          : longBreakMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      sessionsBeforeLongBreak: null == sessionsBeforeLongBreak
          ? _self.sessionsBeforeLongBreak
          : sessionsBeforeLongBreak // ignore: cast_nullable_to_non_nullable
              as int,
      autoStartBreaks: null == autoStartBreaks
          ? _self.autoStartBreaks
          : autoStartBreaks // ignore: cast_nullable_to_non_nullable
              as bool,
      soundEnabled: null == soundEnabled
          ? _self.soundEnabled
          : soundEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [FocusSettingsModel].
extension FocusSettingsModelPatterns on FocusSettingsModel {
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
    TResult Function(_FocusSettingsModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FocusSettingsModel() when $default != null:
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
    TResult Function(_FocusSettingsModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FocusSettingsModel():
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
    TResult? Function(_FocusSettingsModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FocusSettingsModel() when $default != null:
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
            String userId,
            int workMinutes,
            int shortBreakMinutes,
            int longBreakMinutes,
            int sessionsBeforeLongBreak,
            bool autoStartBreaks,
            bool soundEnabled)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FocusSettingsModel() when $default != null:
        return $default(
            _that.userId,
            _that.workMinutes,
            _that.shortBreakMinutes,
            _that.longBreakMinutes,
            _that.sessionsBeforeLongBreak,
            _that.autoStartBreaks,
            _that.soundEnabled);
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
            String userId,
            int workMinutes,
            int shortBreakMinutes,
            int longBreakMinutes,
            int sessionsBeforeLongBreak,
            bool autoStartBreaks,
            bool soundEnabled)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FocusSettingsModel():
        return $default(
            _that.userId,
            _that.workMinutes,
            _that.shortBreakMinutes,
            _that.longBreakMinutes,
            _that.sessionsBeforeLongBreak,
            _that.autoStartBreaks,
            _that.soundEnabled);
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
            String userId,
            int workMinutes,
            int shortBreakMinutes,
            int longBreakMinutes,
            int sessionsBeforeLongBreak,
            bool autoStartBreaks,
            bool soundEnabled)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FocusSettingsModel() when $default != null:
        return $default(
            _that.userId,
            _that.workMinutes,
            _that.shortBreakMinutes,
            _that.longBreakMinutes,
            _that.sessionsBeforeLongBreak,
            _that.autoStartBreaks,
            _that.soundEnabled);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FocusSettingsModel implements FocusSettingsModel {
  const _FocusSettingsModel(
      {required this.userId,
      this.workMinutes = 25,
      this.shortBreakMinutes = 5,
      this.longBreakMinutes = 15,
      this.sessionsBeforeLongBreak = 4,
      this.autoStartBreaks = false,
      this.soundEnabled = true});
  factory _FocusSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$FocusSettingsModelFromJson(json);

  @override
  final String userId;
  @override
  @JsonKey()
  final int workMinutes;
  @override
  @JsonKey()
  final int shortBreakMinutes;
  @override
  @JsonKey()
  final int longBreakMinutes;
  @override
  @JsonKey()
  final int sessionsBeforeLongBreak;
  @override
  @JsonKey()
  final bool autoStartBreaks;
  @override
  @JsonKey()
  final bool soundEnabled;

  /// Create a copy of FocusSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FocusSettingsModelCopyWith<_FocusSettingsModel> get copyWith =>
      __$FocusSettingsModelCopyWithImpl<_FocusSettingsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FocusSettingsModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FocusSettingsModel &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.workMinutes, workMinutes) ||
                other.workMinutes == workMinutes) &&
            (identical(other.shortBreakMinutes, shortBreakMinutes) ||
                other.shortBreakMinutes == shortBreakMinutes) &&
            (identical(other.longBreakMinutes, longBreakMinutes) ||
                other.longBreakMinutes == longBreakMinutes) &&
            (identical(
                    other.sessionsBeforeLongBreak, sessionsBeforeLongBreak) ||
                other.sessionsBeforeLongBreak == sessionsBeforeLongBreak) &&
            (identical(other.autoStartBreaks, autoStartBreaks) ||
                other.autoStartBreaks == autoStartBreaks) &&
            (identical(other.soundEnabled, soundEnabled) ||
                other.soundEnabled == soundEnabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      workMinutes,
      shortBreakMinutes,
      longBreakMinutes,
      sessionsBeforeLongBreak,
      autoStartBreaks,
      soundEnabled);

  @override
  String toString() {
    return 'FocusSettingsModel(userId: $userId, workMinutes: $workMinutes, shortBreakMinutes: $shortBreakMinutes, longBreakMinutes: $longBreakMinutes, sessionsBeforeLongBreak: $sessionsBeforeLongBreak, autoStartBreaks: $autoStartBreaks, soundEnabled: $soundEnabled)';
  }
}

/// @nodoc
abstract mixin class _$FocusSettingsModelCopyWith<$Res>
    implements $FocusSettingsModelCopyWith<$Res> {
  factory _$FocusSettingsModelCopyWith(
          _FocusSettingsModel value, $Res Function(_FocusSettingsModel) _then) =
      __$FocusSettingsModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String userId,
      int workMinutes,
      int shortBreakMinutes,
      int longBreakMinutes,
      int sessionsBeforeLongBreak,
      bool autoStartBreaks,
      bool soundEnabled});
}

/// @nodoc
class __$FocusSettingsModelCopyWithImpl<$Res>
    implements _$FocusSettingsModelCopyWith<$Res> {
  __$FocusSettingsModelCopyWithImpl(this._self, this._then);

  final _FocusSettingsModel _self;
  final $Res Function(_FocusSettingsModel) _then;

  /// Create a copy of FocusSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? workMinutes = null,
    Object? shortBreakMinutes = null,
    Object? longBreakMinutes = null,
    Object? sessionsBeforeLongBreak = null,
    Object? autoStartBreaks = null,
    Object? soundEnabled = null,
  }) {
    return _then(_FocusSettingsModel(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      workMinutes: null == workMinutes
          ? _self.workMinutes
          : workMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      shortBreakMinutes: null == shortBreakMinutes
          ? _self.shortBreakMinutes
          : shortBreakMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      longBreakMinutes: null == longBreakMinutes
          ? _self.longBreakMinutes
          : longBreakMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      sessionsBeforeLongBreak: null == sessionsBeforeLongBreak
          ? _self.sessionsBeforeLongBreak
          : sessionsBeforeLongBreak // ignore: cast_nullable_to_non_nullable
              as int,
      autoStartBreaks: null == autoStartBreaks
          ? _self.autoStartBreaks
          : autoStartBreaks // ignore: cast_nullable_to_non_nullable
              as bool,
      soundEnabled: null == soundEnabled
          ? _self.soundEnabled
          : soundEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
