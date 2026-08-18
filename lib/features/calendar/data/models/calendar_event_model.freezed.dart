// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalendarEventModel {
  String get id;
  String get userId;
  String get title;
  String? get description;
  String? get location;
  DateTime get startTime;
  DateTime get endTime;
  bool get isAllDay;
  String get color;
  String? get recurrenceRule;
  String? get linkedTaskId;
  int? get reminderMinutes;
  int get syncStatus;
  DateTime get createdAt;
  DateTime get updatedAt;

  /// Create a copy of CalendarEventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CalendarEventModelCopyWith<CalendarEventModel> get copyWith =>
      _$CalendarEventModelCopyWithImpl<CalendarEventModel>(
          this as CalendarEventModel, _$identity);

  /// Serializes this CalendarEventModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CalendarEventModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                other.recurrenceRule == recurrenceRule) &&
            (identical(other.linkedTaskId, linkedTaskId) ||
                other.linkedTaskId == linkedTaskId) &&
            (identical(other.reminderMinutes, reminderMinutes) ||
                other.reminderMinutes == reminderMinutes) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      description,
      location,
      startTime,
      endTime,
      isAllDay,
      color,
      recurrenceRule,
      linkedTaskId,
      reminderMinutes,
      syncStatus,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'CalendarEventModel(id: $id, userId: $userId, title: $title, description: $description, location: $location, startTime: $startTime, endTime: $endTime, isAllDay: $isAllDay, color: $color, recurrenceRule: $recurrenceRule, linkedTaskId: $linkedTaskId, reminderMinutes: $reminderMinutes, syncStatus: $syncStatus, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $CalendarEventModelCopyWith<$Res> {
  factory $CalendarEventModelCopyWith(
          CalendarEventModel value, $Res Function(CalendarEventModel) _then) =
      _$CalendarEventModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String? description,
      String? location,
      DateTime startTime,
      DateTime endTime,
      bool isAllDay,
      String color,
      String? recurrenceRule,
      String? linkedTaskId,
      int? reminderMinutes,
      int syncStatus,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$CalendarEventModelCopyWithImpl<$Res>
    implements $CalendarEventModelCopyWith<$Res> {
  _$CalendarEventModelCopyWithImpl(this._self, this._then);

  final CalendarEventModel _self;
  final $Res Function(CalendarEventModel) _then;

  /// Create a copy of CalendarEventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = freezed,
    Object? location = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? isAllDay = null,
    Object? color = null,
    Object? recurrenceRule = freezed,
    Object? linkedTaskId = freezed,
    Object? reminderMinutes = freezed,
    Object? syncStatus = null,
    Object? createdAt = null,
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
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isAllDay: null == isAllDay
          ? _self.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      recurrenceRule: freezed == recurrenceRule
          ? _self.recurrenceRule
          : recurrenceRule // ignore: cast_nullable_to_non_nullable
              as String?,
      linkedTaskId: freezed == linkedTaskId
          ? _self.linkedTaskId
          : linkedTaskId // ignore: cast_nullable_to_non_nullable
              as String?,
      reminderMinutes: freezed == reminderMinutes
          ? _self.reminderMinutes
          : reminderMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      syncStatus: null == syncStatus
          ? _self.syncStatus
          : syncStatus // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [CalendarEventModel].
extension CalendarEventModelPatterns on CalendarEventModel {
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
    TResult Function(_CalendarEventModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CalendarEventModel() when $default != null:
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
    TResult Function(_CalendarEventModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalendarEventModel():
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
    TResult? Function(_CalendarEventModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalendarEventModel() when $default != null:
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
            String title,
            String? description,
            String? location,
            DateTime startTime,
            DateTime endTime,
            bool isAllDay,
            String color,
            String? recurrenceRule,
            String? linkedTaskId,
            int? reminderMinutes,
            int syncStatus,
            DateTime createdAt,
            DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CalendarEventModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.title,
            _that.description,
            _that.location,
            _that.startTime,
            _that.endTime,
            _that.isAllDay,
            _that.color,
            _that.recurrenceRule,
            _that.linkedTaskId,
            _that.reminderMinutes,
            _that.syncStatus,
            _that.createdAt,
            _that.updatedAt);
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
            String title,
            String? description,
            String? location,
            DateTime startTime,
            DateTime endTime,
            bool isAllDay,
            String color,
            String? recurrenceRule,
            String? linkedTaskId,
            int? reminderMinutes,
            int syncStatus,
            DateTime createdAt,
            DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalendarEventModel():
        return $default(
            _that.id,
            _that.userId,
            _that.title,
            _that.description,
            _that.location,
            _that.startTime,
            _that.endTime,
            _that.isAllDay,
            _that.color,
            _that.recurrenceRule,
            _that.linkedTaskId,
            _that.reminderMinutes,
            _that.syncStatus,
            _that.createdAt,
            _that.updatedAt);
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
            String title,
            String? description,
            String? location,
            DateTime startTime,
            DateTime endTime,
            bool isAllDay,
            String color,
            String? recurrenceRule,
            String? linkedTaskId,
            int? reminderMinutes,
            int syncStatus,
            DateTime createdAt,
            DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalendarEventModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.title,
            _that.description,
            _that.location,
            _that.startTime,
            _that.endTime,
            _that.isAllDay,
            _that.color,
            _that.recurrenceRule,
            _that.linkedTaskId,
            _that.reminderMinutes,
            _that.syncStatus,
            _that.createdAt,
            _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CalendarEventModel implements CalendarEventModel {
  const _CalendarEventModel(
      {required this.id,
      required this.userId,
      required this.title,
      this.description,
      this.location,
      required this.startTime,
      required this.endTime,
      this.isAllDay = false,
      this.color = '#4CAF82',
      this.recurrenceRule,
      this.linkedTaskId,
      this.reminderMinutes,
      this.syncStatus = 0,
      required this.createdAt,
      required this.updatedAt});
  factory _CalendarEventModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String? location;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  @JsonKey()
  final bool isAllDay;
  @override
  @JsonKey()
  final String color;
  @override
  final String? recurrenceRule;
  @override
  final String? linkedTaskId;
  @override
  final int? reminderMinutes;
  @override
  @JsonKey()
  final int syncStatus;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  /// Create a copy of CalendarEventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CalendarEventModelCopyWith<_CalendarEventModel> get copyWith =>
      __$CalendarEventModelCopyWithImpl<_CalendarEventModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CalendarEventModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CalendarEventModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                other.recurrenceRule == recurrenceRule) &&
            (identical(other.linkedTaskId, linkedTaskId) ||
                other.linkedTaskId == linkedTaskId) &&
            (identical(other.reminderMinutes, reminderMinutes) ||
                other.reminderMinutes == reminderMinutes) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      description,
      location,
      startTime,
      endTime,
      isAllDay,
      color,
      recurrenceRule,
      linkedTaskId,
      reminderMinutes,
      syncStatus,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'CalendarEventModel(id: $id, userId: $userId, title: $title, description: $description, location: $location, startTime: $startTime, endTime: $endTime, isAllDay: $isAllDay, color: $color, recurrenceRule: $recurrenceRule, linkedTaskId: $linkedTaskId, reminderMinutes: $reminderMinutes, syncStatus: $syncStatus, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$CalendarEventModelCopyWith<$Res>
    implements $CalendarEventModelCopyWith<$Res> {
  factory _$CalendarEventModelCopyWith(
          _CalendarEventModel value, $Res Function(_CalendarEventModel) _then) =
      __$CalendarEventModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String? description,
      String? location,
      DateTime startTime,
      DateTime endTime,
      bool isAllDay,
      String color,
      String? recurrenceRule,
      String? linkedTaskId,
      int? reminderMinutes,
      int syncStatus,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$CalendarEventModelCopyWithImpl<$Res>
    implements _$CalendarEventModelCopyWith<$Res> {
  __$CalendarEventModelCopyWithImpl(this._self, this._then);

  final _CalendarEventModel _self;
  final $Res Function(_CalendarEventModel) _then;

  /// Create a copy of CalendarEventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = freezed,
    Object? location = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? isAllDay = null,
    Object? color = null,
    Object? recurrenceRule = freezed,
    Object? linkedTaskId = freezed,
    Object? reminderMinutes = freezed,
    Object? syncStatus = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_CalendarEventModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isAllDay: null == isAllDay
          ? _self.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      recurrenceRule: freezed == recurrenceRule
          ? _self.recurrenceRule
          : recurrenceRule // ignore: cast_nullable_to_non_nullable
              as String?,
      linkedTaskId: freezed == linkedTaskId
          ? _self.linkedTaskId
          : linkedTaskId // ignore: cast_nullable_to_non_nullable
              as String?,
      reminderMinutes: freezed == reminderMinutes
          ? _self.reminderMinutes
          : reminderMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      syncStatus: null == syncStatus
          ? _self.syncStatus
          : syncStatus // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
