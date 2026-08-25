// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'smart_reminder_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SmartReminderModel {
  String get id;
  String get userId;
  String? get linkedType;
  String? get linkedId;
  String get title;
  String? get body;
  ReminderTriggerType get triggerType;
  Map<String, dynamic> get triggerConfig;
  bool get isActive;
  DateTime? get snoozedUntil;
  DateTime? get lastTriggered;
  DateTime get createdAt;
  DateTime get updatedAt;

  /// Create a copy of SmartReminderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SmartReminderModelCopyWith<SmartReminderModel> get copyWith =>
      _$SmartReminderModelCopyWithImpl<SmartReminderModel>(
          this as SmartReminderModel, _$identity);

  /// Serializes this SmartReminderModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SmartReminderModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.linkedType, linkedType) ||
                other.linkedType == linkedType) &&
            (identical(other.linkedId, linkedId) ||
                other.linkedId == linkedId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.triggerType, triggerType) ||
                other.triggerType == triggerType) &&
            const DeepCollectionEquality()
                .equals(other.triggerConfig, triggerConfig) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.snoozedUntil, snoozedUntil) ||
                other.snoozedUntil == snoozedUntil) &&
            (identical(other.lastTriggered, lastTriggered) ||
                other.lastTriggered == lastTriggered) &&
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
      linkedType,
      linkedId,
      title,
      body,
      triggerType,
      const DeepCollectionEquality().hash(triggerConfig),
      isActive,
      snoozedUntil,
      lastTriggered,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'SmartReminderModel(id: $id, userId: $userId, linkedType: $linkedType, linkedId: $linkedId, title: $title, body: $body, triggerType: $triggerType, triggerConfig: $triggerConfig, isActive: $isActive, snoozedUntil: $snoozedUntil, lastTriggered: $lastTriggered, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $SmartReminderModelCopyWith<$Res> {
  factory $SmartReminderModelCopyWith(
          SmartReminderModel value, $Res Function(SmartReminderModel) _then) =
      _$SmartReminderModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String? linkedType,
      String? linkedId,
      String title,
      String? body,
      ReminderTriggerType triggerType,
      Map<String, dynamic> triggerConfig,
      bool isActive,
      DateTime? snoozedUntil,
      DateTime? lastTriggered,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$SmartReminderModelCopyWithImpl<$Res>
    implements $SmartReminderModelCopyWith<$Res> {
  _$SmartReminderModelCopyWithImpl(this._self, this._then);

  final SmartReminderModel _self;
  final $Res Function(SmartReminderModel) _then;

  /// Create a copy of SmartReminderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? linkedType = freezed,
    Object? linkedId = freezed,
    Object? title = null,
    Object? body = freezed,
    Object? triggerType = null,
    Object? triggerConfig = null,
    Object? isActive = null,
    Object? snoozedUntil = freezed,
    Object? lastTriggered = freezed,
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
      linkedType: freezed == linkedType
          ? _self.linkedType
          : linkedType // ignore: cast_nullable_to_non_nullable
              as String?,
      linkedId: freezed == linkedId
          ? _self.linkedId
          : linkedId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: freezed == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      triggerType: null == triggerType
          ? _self.triggerType
          : triggerType // ignore: cast_nullable_to_non_nullable
              as ReminderTriggerType,
      triggerConfig: null == triggerConfig
          ? _self.triggerConfig
          : triggerConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      snoozedUntil: freezed == snoozedUntil
          ? _self.snoozedUntil
          : snoozedUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastTriggered: freezed == lastTriggered
          ? _self.lastTriggered
          : lastTriggered // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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

/// Adds pattern-matching-related methods to [SmartReminderModel].
extension SmartReminderModelPatterns on SmartReminderModel {
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
    TResult Function(_SmartReminderModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SmartReminderModel() when $default != null:
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
    TResult Function(_SmartReminderModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmartReminderModel():
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
    TResult? Function(_SmartReminderModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmartReminderModel() when $default != null:
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
            String? linkedType,
            String? linkedId,
            String title,
            String? body,
            ReminderTriggerType triggerType,
            Map<String, dynamic> triggerConfig,
            bool isActive,
            DateTime? snoozedUntil,
            DateTime? lastTriggered,
            DateTime createdAt,
            DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SmartReminderModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.linkedType,
            _that.linkedId,
            _that.title,
            _that.body,
            _that.triggerType,
            _that.triggerConfig,
            _that.isActive,
            _that.snoozedUntil,
            _that.lastTriggered,
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
            String? linkedType,
            String? linkedId,
            String title,
            String? body,
            ReminderTriggerType triggerType,
            Map<String, dynamic> triggerConfig,
            bool isActive,
            DateTime? snoozedUntil,
            DateTime? lastTriggered,
            DateTime createdAt,
            DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmartReminderModel():
        return $default(
            _that.id,
            _that.userId,
            _that.linkedType,
            _that.linkedId,
            _that.title,
            _that.body,
            _that.triggerType,
            _that.triggerConfig,
            _that.isActive,
            _that.snoozedUntil,
            _that.lastTriggered,
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
            String? linkedType,
            String? linkedId,
            String title,
            String? body,
            ReminderTriggerType triggerType,
            Map<String, dynamic> triggerConfig,
            bool isActive,
            DateTime? snoozedUntil,
            DateTime? lastTriggered,
            DateTime createdAt,
            DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmartReminderModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.linkedType,
            _that.linkedId,
            _that.title,
            _that.body,
            _that.triggerType,
            _that.triggerConfig,
            _that.isActive,
            _that.snoozedUntil,
            _that.lastTriggered,
            _that.createdAt,
            _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SmartReminderModel implements SmartReminderModel {
  const _SmartReminderModel(
      {required this.id,
      required this.userId,
      this.linkedType,
      this.linkedId,
      required this.title,
      this.body,
      required this.triggerType,
      required final Map<String, dynamic> triggerConfig,
      this.isActive = true,
      this.snoozedUntil,
      this.lastTriggered,
      required this.createdAt,
      required this.updatedAt})
      : _triggerConfig = triggerConfig;
  factory _SmartReminderModel.fromJson(Map<String, dynamic> json) =>
      _$SmartReminderModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String? linkedType;
  @override
  final String? linkedId;
  @override
  final String title;
  @override
  final String? body;
  @override
  final ReminderTriggerType triggerType;
  final Map<String, dynamic> _triggerConfig;
  @override
  Map<String, dynamic> get triggerConfig {
    if (_triggerConfig is EqualUnmodifiableMapView) return _triggerConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_triggerConfig);
  }

  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? snoozedUntil;
  @override
  final DateTime? lastTriggered;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  /// Create a copy of SmartReminderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SmartReminderModelCopyWith<_SmartReminderModel> get copyWith =>
      __$SmartReminderModelCopyWithImpl<_SmartReminderModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SmartReminderModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SmartReminderModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.linkedType, linkedType) ||
                other.linkedType == linkedType) &&
            (identical(other.linkedId, linkedId) ||
                other.linkedId == linkedId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.triggerType, triggerType) ||
                other.triggerType == triggerType) &&
            const DeepCollectionEquality()
                .equals(other._triggerConfig, _triggerConfig) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.snoozedUntil, snoozedUntil) ||
                other.snoozedUntil == snoozedUntil) &&
            (identical(other.lastTriggered, lastTriggered) ||
                other.lastTriggered == lastTriggered) &&
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
      linkedType,
      linkedId,
      title,
      body,
      triggerType,
      const DeepCollectionEquality().hash(_triggerConfig),
      isActive,
      snoozedUntil,
      lastTriggered,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'SmartReminderModel(id: $id, userId: $userId, linkedType: $linkedType, linkedId: $linkedId, title: $title, body: $body, triggerType: $triggerType, triggerConfig: $triggerConfig, isActive: $isActive, snoozedUntil: $snoozedUntil, lastTriggered: $lastTriggered, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$SmartReminderModelCopyWith<$Res>
    implements $SmartReminderModelCopyWith<$Res> {
  factory _$SmartReminderModelCopyWith(
          _SmartReminderModel value, $Res Function(_SmartReminderModel) _then) =
      __$SmartReminderModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String? linkedType,
      String? linkedId,
      String title,
      String? body,
      ReminderTriggerType triggerType,
      Map<String, dynamic> triggerConfig,
      bool isActive,
      DateTime? snoozedUntil,
      DateTime? lastTriggered,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$SmartReminderModelCopyWithImpl<$Res>
    implements _$SmartReminderModelCopyWith<$Res> {
  __$SmartReminderModelCopyWithImpl(this._self, this._then);

  final _SmartReminderModel _self;
  final $Res Function(_SmartReminderModel) _then;

  /// Create a copy of SmartReminderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? linkedType = freezed,
    Object? linkedId = freezed,
    Object? title = null,
    Object? body = freezed,
    Object? triggerType = null,
    Object? triggerConfig = null,
    Object? isActive = null,
    Object? snoozedUntil = freezed,
    Object? lastTriggered = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_SmartReminderModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      linkedType: freezed == linkedType
          ? _self.linkedType
          : linkedType // ignore: cast_nullable_to_non_nullable
              as String?,
      linkedId: freezed == linkedId
          ? _self.linkedId
          : linkedId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: freezed == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      triggerType: null == triggerType
          ? _self.triggerType
          : triggerType // ignore: cast_nullable_to_non_nullable
              as ReminderTriggerType,
      triggerConfig: null == triggerConfig
          ? _self._triggerConfig
          : triggerConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      snoozedUntil: freezed == snoozedUntil
          ? _self.snoozedUntil
          : snoozedUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastTriggered: freezed == lastTriggered
          ? _self.lastTriggered
          : lastTriggered // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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

/// @nodoc
mixin _$LocationTriggerModel {
  String get id;
  String get userId;
  String get label;
  double get latitude;
  double get longitude;
  double get radiusMeters;
  DateTime get createdAt;

  /// Create a copy of LocationTriggerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LocationTriggerModelCopyWith<LocationTriggerModel> get copyWith =>
      _$LocationTriggerModelCopyWithImpl<LocationTriggerModel>(
          this as LocationTriggerModel, _$identity);

  /// Serializes this LocationTriggerModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LocationTriggerModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.radiusMeters, radiusMeters) ||
                other.radiusMeters == radiusMeters) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, label, latitude,
      longitude, radiusMeters, createdAt);

  @override
  String toString() {
    return 'LocationTriggerModel(id: $id, userId: $userId, label: $label, latitude: $latitude, longitude: $longitude, radiusMeters: $radiusMeters, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $LocationTriggerModelCopyWith<$Res> {
  factory $LocationTriggerModelCopyWith(LocationTriggerModel value,
          $Res Function(LocationTriggerModel) _then) =
      _$LocationTriggerModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String label,
      double latitude,
      double longitude,
      double radiusMeters,
      DateTime createdAt});
}

/// @nodoc
class _$LocationTriggerModelCopyWithImpl<$Res>
    implements $LocationTriggerModelCopyWith<$Res> {
  _$LocationTriggerModelCopyWithImpl(this._self, this._then);

  final LocationTriggerModel _self;
  final $Res Function(LocationTriggerModel) _then;

  /// Create a copy of LocationTriggerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? label = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? radiusMeters = null,
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
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      radiusMeters: null == radiusMeters
          ? _self.radiusMeters
          : radiusMeters // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [LocationTriggerModel].
extension LocationTriggerModelPatterns on LocationTriggerModel {
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
    TResult Function(_LocationTriggerModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LocationTriggerModel() when $default != null:
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
    TResult Function(_LocationTriggerModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationTriggerModel():
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
    TResult? Function(_LocationTriggerModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationTriggerModel() when $default != null:
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
    TResult Function(String id, String userId, String label, double latitude,
            double longitude, double radiusMeters, DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LocationTriggerModel() when $default != null:
        return $default(_that.id, _that.userId, _that.label, _that.latitude,
            _that.longitude, _that.radiusMeters, _that.createdAt);
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
    TResult Function(String id, String userId, String label, double latitude,
            double longitude, double radiusMeters, DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationTriggerModel():
        return $default(_that.id, _that.userId, _that.label, _that.latitude,
            _that.longitude, _that.radiusMeters, _that.createdAt);
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
    TResult? Function(String id, String userId, String label, double latitude,
            double longitude, double radiusMeters, DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationTriggerModel() when $default != null:
        return $default(_that.id, _that.userId, _that.label, _that.latitude,
            _that.longitude, _that.radiusMeters, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LocationTriggerModel implements LocationTriggerModel {
  const _LocationTriggerModel(
      {required this.id,
      required this.userId,
      required this.label,
      required this.latitude,
      required this.longitude,
      this.radiusMeters = 150,
      required this.createdAt});
  factory _LocationTriggerModel.fromJson(Map<String, dynamic> json) =>
      _$LocationTriggerModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String label;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  @JsonKey()
  final double radiusMeters;
  @override
  final DateTime createdAt;

  /// Create a copy of LocationTriggerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LocationTriggerModelCopyWith<_LocationTriggerModel> get copyWith =>
      __$LocationTriggerModelCopyWithImpl<_LocationTriggerModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LocationTriggerModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LocationTriggerModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.radiusMeters, radiusMeters) ||
                other.radiusMeters == radiusMeters) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, label, latitude,
      longitude, radiusMeters, createdAt);

  @override
  String toString() {
    return 'LocationTriggerModel(id: $id, userId: $userId, label: $label, latitude: $latitude, longitude: $longitude, radiusMeters: $radiusMeters, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$LocationTriggerModelCopyWith<$Res>
    implements $LocationTriggerModelCopyWith<$Res> {
  factory _$LocationTriggerModelCopyWith(_LocationTriggerModel value,
          $Res Function(_LocationTriggerModel) _then) =
      __$LocationTriggerModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String label,
      double latitude,
      double longitude,
      double radiusMeters,
      DateTime createdAt});
}

/// @nodoc
class __$LocationTriggerModelCopyWithImpl<$Res>
    implements _$LocationTriggerModelCopyWith<$Res> {
  __$LocationTriggerModelCopyWithImpl(this._self, this._then);

  final _LocationTriggerModel _self;
  final $Res Function(_LocationTriggerModel) _then;

  /// Create a copy of LocationTriggerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? label = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? radiusMeters = null,
    Object? createdAt = null,
  }) {
    return _then(_LocationTriggerModel(
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
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      radiusMeters: null == radiusMeters
          ? _self.radiusMeters
          : radiusMeters // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
