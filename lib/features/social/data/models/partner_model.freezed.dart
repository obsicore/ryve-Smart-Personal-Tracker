// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PartnerModel {
  String get id;
  String get userId;
  String get partnerId;
  String get partnerDisplayName;
  String get status;
  int get partnerStreak;
  int get partnerHabitsToday;
  DateTime? get partnerLastActive;
  DateTime get createdAt;

  /// Create a copy of PartnerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PartnerModelCopyWith<PartnerModel> get copyWith =>
      _$PartnerModelCopyWithImpl<PartnerModel>(
          this as PartnerModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PartnerModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.partnerId, partnerId) ||
                other.partnerId == partnerId) &&
            (identical(other.partnerDisplayName, partnerDisplayName) ||
                other.partnerDisplayName == partnerDisplayName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.partnerStreak, partnerStreak) ||
                other.partnerStreak == partnerStreak) &&
            (identical(other.partnerHabitsToday, partnerHabitsToday) ||
                other.partnerHabitsToday == partnerHabitsToday) &&
            (identical(other.partnerLastActive, partnerLastActive) ||
                other.partnerLastActive == partnerLastActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      partnerId,
      partnerDisplayName,
      status,
      partnerStreak,
      partnerHabitsToday,
      partnerLastActive,
      createdAt);

  @override
  String toString() {
    return 'PartnerModel(id: $id, userId: $userId, partnerId: $partnerId, partnerDisplayName: $partnerDisplayName, status: $status, partnerStreak: $partnerStreak, partnerHabitsToday: $partnerHabitsToday, partnerLastActive: $partnerLastActive, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $PartnerModelCopyWith<$Res> {
  factory $PartnerModelCopyWith(
          PartnerModel value, $Res Function(PartnerModel) _then) =
      _$PartnerModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String partnerId,
      String partnerDisplayName,
      String status,
      int partnerStreak,
      int partnerHabitsToday,
      DateTime? partnerLastActive,
      DateTime createdAt});
}

/// @nodoc
class _$PartnerModelCopyWithImpl<$Res> implements $PartnerModelCopyWith<$Res> {
  _$PartnerModelCopyWithImpl(this._self, this._then);

  final PartnerModel _self;
  final $Res Function(PartnerModel) _then;

  /// Create a copy of PartnerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? partnerId = null,
    Object? partnerDisplayName = null,
    Object? status = null,
    Object? partnerStreak = null,
    Object? partnerHabitsToday = null,
    Object? partnerLastActive = freezed,
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
      partnerId: null == partnerId
          ? _self.partnerId
          : partnerId // ignore: cast_nullable_to_non_nullable
              as String,
      partnerDisplayName: null == partnerDisplayName
          ? _self.partnerDisplayName
          : partnerDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      partnerStreak: null == partnerStreak
          ? _self.partnerStreak
          : partnerStreak // ignore: cast_nullable_to_non_nullable
              as int,
      partnerHabitsToday: null == partnerHabitsToday
          ? _self.partnerHabitsToday
          : partnerHabitsToday // ignore: cast_nullable_to_non_nullable
              as int,
      partnerLastActive: freezed == partnerLastActive
          ? _self.partnerLastActive
          : partnerLastActive // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [PartnerModel].
extension PartnerModelPatterns on PartnerModel {
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
    TResult Function(_PartnerModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PartnerModel() when $default != null:
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
    TResult Function(_PartnerModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PartnerModel():
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
    TResult? Function(_PartnerModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PartnerModel() when $default != null:
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
            String partnerId,
            String partnerDisplayName,
            String status,
            int partnerStreak,
            int partnerHabitsToday,
            DateTime? partnerLastActive,
            DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PartnerModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.partnerId,
            _that.partnerDisplayName,
            _that.status,
            _that.partnerStreak,
            _that.partnerHabitsToday,
            _that.partnerLastActive,
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
            String partnerId,
            String partnerDisplayName,
            String status,
            int partnerStreak,
            int partnerHabitsToday,
            DateTime? partnerLastActive,
            DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PartnerModel():
        return $default(
            _that.id,
            _that.userId,
            _that.partnerId,
            _that.partnerDisplayName,
            _that.status,
            _that.partnerStreak,
            _that.partnerHabitsToday,
            _that.partnerLastActive,
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
            String partnerId,
            String partnerDisplayName,
            String status,
            int partnerStreak,
            int partnerHabitsToday,
            DateTime? partnerLastActive,
            DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PartnerModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.partnerId,
            _that.partnerDisplayName,
            _that.status,
            _that.partnerStreak,
            _that.partnerHabitsToday,
            _that.partnerLastActive,
            _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PartnerModel implements PartnerModel {
  const _PartnerModel(
      {required this.id,
      required this.userId,
      required this.partnerId,
      required this.partnerDisplayName,
      required this.status,
      required this.partnerStreak,
      required this.partnerHabitsToday,
      this.partnerLastActive,
      required this.createdAt});

  @override
  final String id;
  @override
  final String userId;
  @override
  final String partnerId;
  @override
  final String partnerDisplayName;
  @override
  final String status;
  @override
  final int partnerStreak;
  @override
  final int partnerHabitsToday;
  @override
  final DateTime? partnerLastActive;
  @override
  final DateTime createdAt;

  /// Create a copy of PartnerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PartnerModelCopyWith<_PartnerModel> get copyWith =>
      __$PartnerModelCopyWithImpl<_PartnerModel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PartnerModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.partnerId, partnerId) ||
                other.partnerId == partnerId) &&
            (identical(other.partnerDisplayName, partnerDisplayName) ||
                other.partnerDisplayName == partnerDisplayName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.partnerStreak, partnerStreak) ||
                other.partnerStreak == partnerStreak) &&
            (identical(other.partnerHabitsToday, partnerHabitsToday) ||
                other.partnerHabitsToday == partnerHabitsToday) &&
            (identical(other.partnerLastActive, partnerLastActive) ||
                other.partnerLastActive == partnerLastActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      partnerId,
      partnerDisplayName,
      status,
      partnerStreak,
      partnerHabitsToday,
      partnerLastActive,
      createdAt);

  @override
  String toString() {
    return 'PartnerModel(id: $id, userId: $userId, partnerId: $partnerId, partnerDisplayName: $partnerDisplayName, status: $status, partnerStreak: $partnerStreak, partnerHabitsToday: $partnerHabitsToday, partnerLastActive: $partnerLastActive, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$PartnerModelCopyWith<$Res>
    implements $PartnerModelCopyWith<$Res> {
  factory _$PartnerModelCopyWith(
          _PartnerModel value, $Res Function(_PartnerModel) _then) =
      __$PartnerModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String partnerId,
      String partnerDisplayName,
      String status,
      int partnerStreak,
      int partnerHabitsToday,
      DateTime? partnerLastActive,
      DateTime createdAt});
}

/// @nodoc
class __$PartnerModelCopyWithImpl<$Res>
    implements _$PartnerModelCopyWith<$Res> {
  __$PartnerModelCopyWithImpl(this._self, this._then);

  final _PartnerModel _self;
  final $Res Function(_PartnerModel) _then;

  /// Create a copy of PartnerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? partnerId = null,
    Object? partnerDisplayName = null,
    Object? status = null,
    Object? partnerStreak = null,
    Object? partnerHabitsToday = null,
    Object? partnerLastActive = freezed,
    Object? createdAt = null,
  }) {
    return _then(_PartnerModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      partnerId: null == partnerId
          ? _self.partnerId
          : partnerId // ignore: cast_nullable_to_non_nullable
              as String,
      partnerDisplayName: null == partnerDisplayName
          ? _self.partnerDisplayName
          : partnerDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      partnerStreak: null == partnerStreak
          ? _self.partnerStreak
          : partnerStreak // ignore: cast_nullable_to_non_nullable
              as int,
      partnerHabitsToday: null == partnerHabitsToday
          ? _self.partnerHabitsToday
          : partnerHabitsToday // ignore: cast_nullable_to_non_nullable
              as int,
      partnerLastActive: freezed == partnerLastActive
          ? _self.partnerLastActive
          : partnerLastActive // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
mixin _$PartnerCheckInModel {
  String get id;
  String get partnershipId;
  String get userId;
  String get fromDisplayName;
  String? get note;
  DateTime get createdAt;

  /// Create a copy of PartnerCheckInModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PartnerCheckInModelCopyWith<PartnerCheckInModel> get copyWith =>
      _$PartnerCheckInModelCopyWithImpl<PartnerCheckInModel>(
          this as PartnerCheckInModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PartnerCheckInModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.partnershipId, partnershipId) ||
                other.partnershipId == partnershipId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.fromDisplayName, fromDisplayName) ||
                other.fromDisplayName == fromDisplayName) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, partnershipId, userId, fromDisplayName, note, createdAt);

  @override
  String toString() {
    return 'PartnerCheckInModel(id: $id, partnershipId: $partnershipId, userId: $userId, fromDisplayName: $fromDisplayName, note: $note, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $PartnerCheckInModelCopyWith<$Res> {
  factory $PartnerCheckInModelCopyWith(
          PartnerCheckInModel value, $Res Function(PartnerCheckInModel) _then) =
      _$PartnerCheckInModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String partnershipId,
      String userId,
      String fromDisplayName,
      String? note,
      DateTime createdAt});
}

/// @nodoc
class _$PartnerCheckInModelCopyWithImpl<$Res>
    implements $PartnerCheckInModelCopyWith<$Res> {
  _$PartnerCheckInModelCopyWithImpl(this._self, this._then);

  final PartnerCheckInModel _self;
  final $Res Function(PartnerCheckInModel) _then;

  /// Create a copy of PartnerCheckInModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? partnershipId = null,
    Object? userId = null,
    Object? fromDisplayName = null,
    Object? note = freezed,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      partnershipId: null == partnershipId
          ? _self.partnershipId
          : partnershipId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      fromDisplayName: null == fromDisplayName
          ? _self.fromDisplayName
          : fromDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [PartnerCheckInModel].
extension PartnerCheckInModelPatterns on PartnerCheckInModel {
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
    TResult Function(_PartnerCheckInModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PartnerCheckInModel() when $default != null:
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
    TResult Function(_PartnerCheckInModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PartnerCheckInModel():
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
    TResult? Function(_PartnerCheckInModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PartnerCheckInModel() when $default != null:
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
    TResult Function(String id, String partnershipId, String userId,
            String fromDisplayName, String? note, DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PartnerCheckInModel() when $default != null:
        return $default(_that.id, _that.partnershipId, _that.userId,
            _that.fromDisplayName, _that.note, _that.createdAt);
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
    TResult Function(String id, String partnershipId, String userId,
            String fromDisplayName, String? note, DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PartnerCheckInModel():
        return $default(_that.id, _that.partnershipId, _that.userId,
            _that.fromDisplayName, _that.note, _that.createdAt);
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
    TResult? Function(String id, String partnershipId, String userId,
            String fromDisplayName, String? note, DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PartnerCheckInModel() when $default != null:
        return $default(_that.id, _that.partnershipId, _that.userId,
            _that.fromDisplayName, _that.note, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PartnerCheckInModel implements PartnerCheckInModel {
  const _PartnerCheckInModel(
      {required this.id,
      required this.partnershipId,
      required this.userId,
      required this.fromDisplayName,
      this.note,
      required this.createdAt});

  @override
  final String id;
  @override
  final String partnershipId;
  @override
  final String userId;
  @override
  final String fromDisplayName;
  @override
  final String? note;
  @override
  final DateTime createdAt;

  /// Create a copy of PartnerCheckInModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PartnerCheckInModelCopyWith<_PartnerCheckInModel> get copyWith =>
      __$PartnerCheckInModelCopyWithImpl<_PartnerCheckInModel>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PartnerCheckInModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.partnershipId, partnershipId) ||
                other.partnershipId == partnershipId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.fromDisplayName, fromDisplayName) ||
                other.fromDisplayName == fromDisplayName) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, partnershipId, userId, fromDisplayName, note, createdAt);

  @override
  String toString() {
    return 'PartnerCheckInModel(id: $id, partnershipId: $partnershipId, userId: $userId, fromDisplayName: $fromDisplayName, note: $note, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$PartnerCheckInModelCopyWith<$Res>
    implements $PartnerCheckInModelCopyWith<$Res> {
  factory _$PartnerCheckInModelCopyWith(_PartnerCheckInModel value,
          $Res Function(_PartnerCheckInModel) _then) =
      __$PartnerCheckInModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String partnershipId,
      String userId,
      String fromDisplayName,
      String? note,
      DateTime createdAt});
}

/// @nodoc
class __$PartnerCheckInModelCopyWithImpl<$Res>
    implements _$PartnerCheckInModelCopyWith<$Res> {
  __$PartnerCheckInModelCopyWithImpl(this._self, this._then);

  final _PartnerCheckInModel _self;
  final $Res Function(_PartnerCheckInModel) _then;

  /// Create a copy of PartnerCheckInModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? partnershipId = null,
    Object? userId = null,
    Object? fromDisplayName = null,
    Object? note = freezed,
    Object? createdAt = null,
  }) {
    return _then(_PartnerCheckInModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      partnershipId: null == partnershipId
          ? _self.partnershipId
          : partnershipId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      fromDisplayName: null == fromDisplayName
          ? _self.fromDisplayName
          : fromDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
