// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarm_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AlarmModel {
  String get id;
  String get userId;
  String get label;
  String get time;
  String get daysOfWeek;
  bool get isEnabled;
  AlarmMissionType get missionType;
  int get snoozeCount;
  int get snoozeDurationMinutes;
  String get soundName;
  DateTime get createdAt;

  /// Create a copy of AlarmModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AlarmModelCopyWith<AlarmModel> get copyWith =>
      _$AlarmModelCopyWithImpl<AlarmModel>(this as AlarmModel, _$identity);

  /// Serializes this AlarmModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AlarmModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.daysOfWeek, daysOfWeek) ||
                other.daysOfWeek == daysOfWeek) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.missionType, missionType) ||
                other.missionType == missionType) &&
            (identical(other.snoozeCount, snoozeCount) ||
                other.snoozeCount == snoozeCount) &&
            (identical(other.snoozeDurationMinutes, snoozeDurationMinutes) ||
                other.snoozeDurationMinutes == snoozeDurationMinutes) &&
            (identical(other.soundName, soundName) ||
                other.soundName == soundName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      label,
      time,
      daysOfWeek,
      isEnabled,
      missionType,
      snoozeCount,
      snoozeDurationMinutes,
      soundName,
      createdAt);

  @override
  String toString() {
    return 'AlarmModel(id: $id, userId: $userId, label: $label, time: $time, daysOfWeek: $daysOfWeek, isEnabled: $isEnabled, missionType: $missionType, snoozeCount: $snoozeCount, snoozeDurationMinutes: $snoozeDurationMinutes, soundName: $soundName, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $AlarmModelCopyWith<$Res> {
  factory $AlarmModelCopyWith(
          AlarmModel value, $Res Function(AlarmModel) _then) =
      _$AlarmModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String label,
      String time,
      String daysOfWeek,
      bool isEnabled,
      AlarmMissionType missionType,
      int snoozeCount,
      int snoozeDurationMinutes,
      String soundName,
      DateTime createdAt});
}

/// @nodoc
class _$AlarmModelCopyWithImpl<$Res> implements $AlarmModelCopyWith<$Res> {
  _$AlarmModelCopyWithImpl(this._self, this._then);

  final AlarmModel _self;
  final $Res Function(AlarmModel) _then;

  /// Create a copy of AlarmModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? label = null,
    Object? time = null,
    Object? daysOfWeek = null,
    Object? isEnabled = null,
    Object? missionType = null,
    Object? snoozeCount = null,
    Object? snoozeDurationMinutes = null,
    Object? soundName = null,
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
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _self.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      daysOfWeek: null == daysOfWeek
          ? _self.daysOfWeek
          : daysOfWeek // ignore: cast_nullable_to_non_nullable
              as String,
      isEnabled: null == isEnabled
          ? _self.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      missionType: null == missionType
          ? _self.missionType
          : missionType // ignore: cast_nullable_to_non_nullable
              as AlarmMissionType,
      snoozeCount: null == snoozeCount
          ? _self.snoozeCount
          : snoozeCount // ignore: cast_nullable_to_non_nullable
              as int,
      snoozeDurationMinutes: null == snoozeDurationMinutes
          ? _self.snoozeDurationMinutes
          : snoozeDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      soundName: null == soundName
          ? _self.soundName
          : soundName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [AlarmModel].
extension AlarmModelPatterns on AlarmModel {
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
    TResult Function(_AlarmModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AlarmModel() when $default != null:
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
    TResult Function(_AlarmModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AlarmModel():
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
    TResult? Function(_AlarmModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AlarmModel() when $default != null:
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
            String label,
            String time,
            String daysOfWeek,
            bool isEnabled,
            AlarmMissionType missionType,
            int snoozeCount,
            int snoozeDurationMinutes,
            String soundName,
            DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AlarmModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.label,
            _that.time,
            _that.daysOfWeek,
            _that.isEnabled,
            _that.missionType,
            _that.snoozeCount,
            _that.snoozeDurationMinutes,
            _that.soundName,
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
            String label,
            String time,
            String daysOfWeek,
            bool isEnabled,
            AlarmMissionType missionType,
            int snoozeCount,
            int snoozeDurationMinutes,
            String soundName,
            DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AlarmModel():
        return $default(
            _that.id,
            _that.userId,
            _that.label,
            _that.time,
            _that.daysOfWeek,
            _that.isEnabled,
            _that.missionType,
            _that.snoozeCount,
            _that.snoozeDurationMinutes,
            _that.soundName,
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
            String label,
            String time,
            String daysOfWeek,
            bool isEnabled,
            AlarmMissionType missionType,
            int snoozeCount,
            int snoozeDurationMinutes,
            String soundName,
            DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AlarmModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.label,
            _that.time,
            _that.daysOfWeek,
            _that.isEnabled,
            _that.missionType,
            _that.snoozeCount,
            _that.snoozeDurationMinutes,
            _that.soundName,
            _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AlarmModel implements AlarmModel {
  const _AlarmModel(
      {required this.id,
      required this.userId,
      this.label = 'Wake Up',
      required this.time,
      this.daysOfWeek = '1,2,3,4,5,6,7',
      this.isEnabled = true,
      this.missionType = AlarmMissionType.none,
      this.snoozeCount = 3,
      this.snoozeDurationMinutes = 5,
      this.soundName = 'default',
      required this.createdAt});
  factory _AlarmModel.fromJson(Map<String, dynamic> json) =>
      _$AlarmModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  @JsonKey()
  final String label;
  @override
  final String time;
  @override
  @JsonKey()
  final String daysOfWeek;
  @override
  @JsonKey()
  final bool isEnabled;
  @override
  @JsonKey()
  final AlarmMissionType missionType;
  @override
  @JsonKey()
  final int snoozeCount;
  @override
  @JsonKey()
  final int snoozeDurationMinutes;
  @override
  @JsonKey()
  final String soundName;
  @override
  final DateTime createdAt;

  /// Create a copy of AlarmModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AlarmModelCopyWith<_AlarmModel> get copyWith =>
      __$AlarmModelCopyWithImpl<_AlarmModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AlarmModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AlarmModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.daysOfWeek, daysOfWeek) ||
                other.daysOfWeek == daysOfWeek) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.missionType, missionType) ||
                other.missionType == missionType) &&
            (identical(other.snoozeCount, snoozeCount) ||
                other.snoozeCount == snoozeCount) &&
            (identical(other.snoozeDurationMinutes, snoozeDurationMinutes) ||
                other.snoozeDurationMinutes == snoozeDurationMinutes) &&
            (identical(other.soundName, soundName) ||
                other.soundName == soundName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      label,
      time,
      daysOfWeek,
      isEnabled,
      missionType,
      snoozeCount,
      snoozeDurationMinutes,
      soundName,
      createdAt);

  @override
  String toString() {
    return 'AlarmModel(id: $id, userId: $userId, label: $label, time: $time, daysOfWeek: $daysOfWeek, isEnabled: $isEnabled, missionType: $missionType, snoozeCount: $snoozeCount, snoozeDurationMinutes: $snoozeDurationMinutes, soundName: $soundName, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$AlarmModelCopyWith<$Res>
    implements $AlarmModelCopyWith<$Res> {
  factory _$AlarmModelCopyWith(
          _AlarmModel value, $Res Function(_AlarmModel) _then) =
      __$AlarmModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String label,
      String time,
      String daysOfWeek,
      bool isEnabled,
      AlarmMissionType missionType,
      int snoozeCount,
      int snoozeDurationMinutes,
      String soundName,
      DateTime createdAt});
}

/// @nodoc
class __$AlarmModelCopyWithImpl<$Res> implements _$AlarmModelCopyWith<$Res> {
  __$AlarmModelCopyWithImpl(this._self, this._then);

  final _AlarmModel _self;
  final $Res Function(_AlarmModel) _then;

  /// Create a copy of AlarmModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? label = null,
    Object? time = null,
    Object? daysOfWeek = null,
    Object? isEnabled = null,
    Object? missionType = null,
    Object? snoozeCount = null,
    Object? snoozeDurationMinutes = null,
    Object? soundName = null,
    Object? createdAt = null,
  }) {
    return _then(_AlarmModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _self.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      daysOfWeek: null == daysOfWeek
          ? _self.daysOfWeek
          : daysOfWeek // ignore: cast_nullable_to_non_nullable
              as String,
      isEnabled: null == isEnabled
          ? _self.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      missionType: null == missionType
          ? _self.missionType
          : missionType // ignore: cast_nullable_to_non_nullable
              as AlarmMissionType,
      snoozeCount: null == snoozeCount
          ? _self.snoozeCount
          : snoozeCount // ignore: cast_nullable_to_non_nullable
              as int,
      snoozeDurationMinutes: null == snoozeDurationMinutes
          ? _self.snoozeDurationMinutes
          : snoozeDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      soundName: null == soundName
          ? _self.soundName
          : soundName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
