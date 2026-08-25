// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_plan_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AIPlanItemModel {
  String get id;
  String get planId;
  String get slotStart;
  String get slotEnd;
  String get title;
  String? get description;
  AIPlanItemType get itemType;
  String? get linkedTaskId;
  String? get linkedHabitId;
  int get sortOrder;
  String get itemStatus;

  /// Create a copy of AIPlanItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AIPlanItemModelCopyWith<AIPlanItemModel> get copyWith =>
      _$AIPlanItemModelCopyWithImpl<AIPlanItemModel>(
          this as AIPlanItemModel, _$identity);

  /// Serializes this AIPlanItemModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AIPlanItemModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.planId, planId) || other.planId == planId) &&
            (identical(other.slotStart, slotStart) ||
                other.slotStart == slotStart) &&
            (identical(other.slotEnd, slotEnd) || other.slotEnd == slotEnd) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.itemType, itemType) ||
                other.itemType == itemType) &&
            (identical(other.linkedTaskId, linkedTaskId) ||
                other.linkedTaskId == linkedTaskId) &&
            (identical(other.linkedHabitId, linkedHabitId) ||
                other.linkedHabitId == linkedHabitId) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.itemStatus, itemStatus) ||
                other.itemStatus == itemStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      planId,
      slotStart,
      slotEnd,
      title,
      description,
      itemType,
      linkedTaskId,
      linkedHabitId,
      sortOrder,
      itemStatus);

  @override
  String toString() {
    return 'AIPlanItemModel(id: $id, planId: $planId, slotStart: $slotStart, slotEnd: $slotEnd, title: $title, description: $description, itemType: $itemType, linkedTaskId: $linkedTaskId, linkedHabitId: $linkedHabitId, sortOrder: $sortOrder, itemStatus: $itemStatus)';
  }
}

/// @nodoc
abstract mixin class $AIPlanItemModelCopyWith<$Res> {
  factory $AIPlanItemModelCopyWith(
          AIPlanItemModel value, $Res Function(AIPlanItemModel) _then) =
      _$AIPlanItemModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String planId,
      String slotStart,
      String slotEnd,
      String title,
      String? description,
      AIPlanItemType itemType,
      String? linkedTaskId,
      String? linkedHabitId,
      int sortOrder,
      String itemStatus});
}

/// @nodoc
class _$AIPlanItemModelCopyWithImpl<$Res>
    implements $AIPlanItemModelCopyWith<$Res> {
  _$AIPlanItemModelCopyWithImpl(this._self, this._then);

  final AIPlanItemModel _self;
  final $Res Function(AIPlanItemModel) _then;

  /// Create a copy of AIPlanItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? planId = null,
    Object? slotStart = null,
    Object? slotEnd = null,
    Object? title = null,
    Object? description = freezed,
    Object? itemType = null,
    Object? linkedTaskId = freezed,
    Object? linkedHabitId = freezed,
    Object? sortOrder = null,
    Object? itemStatus = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      planId: null == planId
          ? _self.planId
          : planId // ignore: cast_nullable_to_non_nullable
              as String,
      slotStart: null == slotStart
          ? _self.slotStart
          : slotStart // ignore: cast_nullable_to_non_nullable
              as String,
      slotEnd: null == slotEnd
          ? _self.slotEnd
          : slotEnd // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      itemType: null == itemType
          ? _self.itemType
          : itemType // ignore: cast_nullable_to_non_nullable
              as AIPlanItemType,
      linkedTaskId: freezed == linkedTaskId
          ? _self.linkedTaskId
          : linkedTaskId // ignore: cast_nullable_to_non_nullable
              as String?,
      linkedHabitId: freezed == linkedHabitId
          ? _self.linkedHabitId
          : linkedHabitId // ignore: cast_nullable_to_non_nullable
              as String?,
      sortOrder: null == sortOrder
          ? _self.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      itemStatus: null == itemStatus
          ? _self.itemStatus
          : itemStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [AIPlanItemModel].
extension AIPlanItemModelPatterns on AIPlanItemModel {
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
    TResult Function(_AIPlanItemModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AIPlanItemModel() when $default != null:
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
    TResult Function(_AIPlanItemModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AIPlanItemModel():
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
    TResult? Function(_AIPlanItemModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AIPlanItemModel() when $default != null:
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
            String planId,
            String slotStart,
            String slotEnd,
            String title,
            String? description,
            AIPlanItemType itemType,
            String? linkedTaskId,
            String? linkedHabitId,
            int sortOrder,
            String itemStatus)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AIPlanItemModel() when $default != null:
        return $default(
            _that.id,
            _that.planId,
            _that.slotStart,
            _that.slotEnd,
            _that.title,
            _that.description,
            _that.itemType,
            _that.linkedTaskId,
            _that.linkedHabitId,
            _that.sortOrder,
            _that.itemStatus);
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
            String planId,
            String slotStart,
            String slotEnd,
            String title,
            String? description,
            AIPlanItemType itemType,
            String? linkedTaskId,
            String? linkedHabitId,
            int sortOrder,
            String itemStatus)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AIPlanItemModel():
        return $default(
            _that.id,
            _that.planId,
            _that.slotStart,
            _that.slotEnd,
            _that.title,
            _that.description,
            _that.itemType,
            _that.linkedTaskId,
            _that.linkedHabitId,
            _that.sortOrder,
            _that.itemStatus);
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
            String planId,
            String slotStart,
            String slotEnd,
            String title,
            String? description,
            AIPlanItemType itemType,
            String? linkedTaskId,
            String? linkedHabitId,
            int sortOrder,
            String itemStatus)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AIPlanItemModel() when $default != null:
        return $default(
            _that.id,
            _that.planId,
            _that.slotStart,
            _that.slotEnd,
            _that.title,
            _that.description,
            _that.itemType,
            _that.linkedTaskId,
            _that.linkedHabitId,
            _that.sortOrder,
            _that.itemStatus);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AIPlanItemModel implements AIPlanItemModel {
  const _AIPlanItemModel(
      {required this.id,
      required this.planId,
      required this.slotStart,
      required this.slotEnd,
      required this.title,
      this.description,
      required this.itemType,
      this.linkedTaskId,
      this.linkedHabitId,
      this.sortOrder = 0,
      this.itemStatus = 'pending'});
  factory _AIPlanItemModel.fromJson(Map<String, dynamic> json) =>
      _$AIPlanItemModelFromJson(json);

  @override
  final String id;
  @override
  final String planId;
  @override
  final String slotStart;
  @override
  final String slotEnd;
  @override
  final String title;
  @override
  final String? description;
  @override
  final AIPlanItemType itemType;
  @override
  final String? linkedTaskId;
  @override
  final String? linkedHabitId;
  @override
  @JsonKey()
  final int sortOrder;
  @override
  @JsonKey()
  final String itemStatus;

  /// Create a copy of AIPlanItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AIPlanItemModelCopyWith<_AIPlanItemModel> get copyWith =>
      __$AIPlanItemModelCopyWithImpl<_AIPlanItemModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AIPlanItemModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AIPlanItemModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.planId, planId) || other.planId == planId) &&
            (identical(other.slotStart, slotStart) ||
                other.slotStart == slotStart) &&
            (identical(other.slotEnd, slotEnd) || other.slotEnd == slotEnd) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.itemType, itemType) ||
                other.itemType == itemType) &&
            (identical(other.linkedTaskId, linkedTaskId) ||
                other.linkedTaskId == linkedTaskId) &&
            (identical(other.linkedHabitId, linkedHabitId) ||
                other.linkedHabitId == linkedHabitId) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.itemStatus, itemStatus) ||
                other.itemStatus == itemStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      planId,
      slotStart,
      slotEnd,
      title,
      description,
      itemType,
      linkedTaskId,
      linkedHabitId,
      sortOrder,
      itemStatus);

  @override
  String toString() {
    return 'AIPlanItemModel(id: $id, planId: $planId, slotStart: $slotStart, slotEnd: $slotEnd, title: $title, description: $description, itemType: $itemType, linkedTaskId: $linkedTaskId, linkedHabitId: $linkedHabitId, sortOrder: $sortOrder, itemStatus: $itemStatus)';
  }
}

/// @nodoc
abstract mixin class _$AIPlanItemModelCopyWith<$Res>
    implements $AIPlanItemModelCopyWith<$Res> {
  factory _$AIPlanItemModelCopyWith(
          _AIPlanItemModel value, $Res Function(_AIPlanItemModel) _then) =
      __$AIPlanItemModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String planId,
      String slotStart,
      String slotEnd,
      String title,
      String? description,
      AIPlanItemType itemType,
      String? linkedTaskId,
      String? linkedHabitId,
      int sortOrder,
      String itemStatus});
}

/// @nodoc
class __$AIPlanItemModelCopyWithImpl<$Res>
    implements _$AIPlanItemModelCopyWith<$Res> {
  __$AIPlanItemModelCopyWithImpl(this._self, this._then);

  final _AIPlanItemModel _self;
  final $Res Function(_AIPlanItemModel) _then;

  /// Create a copy of AIPlanItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? planId = null,
    Object? slotStart = null,
    Object? slotEnd = null,
    Object? title = null,
    Object? description = freezed,
    Object? itemType = null,
    Object? linkedTaskId = freezed,
    Object? linkedHabitId = freezed,
    Object? sortOrder = null,
    Object? itemStatus = null,
  }) {
    return _then(_AIPlanItemModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      planId: null == planId
          ? _self.planId
          : planId // ignore: cast_nullable_to_non_nullable
              as String,
      slotStart: null == slotStart
          ? _self.slotStart
          : slotStart // ignore: cast_nullable_to_non_nullable
              as String,
      slotEnd: null == slotEnd
          ? _self.slotEnd
          : slotEnd // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      itemType: null == itemType
          ? _self.itemType
          : itemType // ignore: cast_nullable_to_non_nullable
              as AIPlanItemType,
      linkedTaskId: freezed == linkedTaskId
          ? _self.linkedTaskId
          : linkedTaskId // ignore: cast_nullable_to_non_nullable
              as String?,
      linkedHabitId: freezed == linkedHabitId
          ? _self.linkedHabitId
          : linkedHabitId // ignore: cast_nullable_to_non_nullable
              as String?,
      sortOrder: null == sortOrder
          ? _self.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      itemStatus: null == itemStatus
          ? _self.itemStatus
          : itemStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
