// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_plan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AIPlanModel {
  String get id;
  String get userId;
  DateTime get planDate;
  String get status;
  String? get promptContext;
  String? get modelUsed;
  DateTime get generatedAt;
  DateTime? get acceptedAt;
  DateTime get createdAt;
  List<AIPlanItemModel> get items;

  /// Create a copy of AIPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AIPlanModelCopyWith<AIPlanModel> get copyWith =>
      _$AIPlanModelCopyWithImpl<AIPlanModel>(this as AIPlanModel, _$identity);

  /// Serializes this AIPlanModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AIPlanModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.planDate, planDate) ||
                other.planDate == planDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.promptContext, promptContext) ||
                other.promptContext == promptContext) &&
            (identical(other.modelUsed, modelUsed) ||
                other.modelUsed == modelUsed) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.acceptedAt, acceptedAt) ||
                other.acceptedAt == acceptedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      planDate,
      status,
      promptContext,
      modelUsed,
      generatedAt,
      acceptedAt,
      createdAt,
      const DeepCollectionEquality().hash(items));

  @override
  String toString() {
    return 'AIPlanModel(id: $id, userId: $userId, planDate: $planDate, status: $status, promptContext: $promptContext, modelUsed: $modelUsed, generatedAt: $generatedAt, acceptedAt: $acceptedAt, createdAt: $createdAt, items: $items)';
  }
}

/// @nodoc
abstract mixin class $AIPlanModelCopyWith<$Res> {
  factory $AIPlanModelCopyWith(
          AIPlanModel value, $Res Function(AIPlanModel) _then) =
      _$AIPlanModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime planDate,
      String status,
      String? promptContext,
      String? modelUsed,
      DateTime generatedAt,
      DateTime? acceptedAt,
      DateTime createdAt,
      List<AIPlanItemModel> items});
}

/// @nodoc
class _$AIPlanModelCopyWithImpl<$Res> implements $AIPlanModelCopyWith<$Res> {
  _$AIPlanModelCopyWithImpl(this._self, this._then);

  final AIPlanModel _self;
  final $Res Function(AIPlanModel) _then;

  /// Create a copy of AIPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? planDate = null,
    Object? status = null,
    Object? promptContext = freezed,
    Object? modelUsed = freezed,
    Object? generatedAt = null,
    Object? acceptedAt = freezed,
    Object? createdAt = null,
    Object? items = null,
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
      planDate: null == planDate
          ? _self.planDate
          : planDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      promptContext: freezed == promptContext
          ? _self.promptContext
          : promptContext // ignore: cast_nullable_to_non_nullable
              as String?,
      modelUsed: freezed == modelUsed
          ? _self.modelUsed
          : modelUsed // ignore: cast_nullable_to_non_nullable
              as String?,
      generatedAt: null == generatedAt
          ? _self.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      acceptedAt: freezed == acceptedAt
          ? _self.acceptedAt
          : acceptedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<AIPlanItemModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [AIPlanModel].
extension AIPlanModelPatterns on AIPlanModel {
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
    TResult Function(_AIPlanModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AIPlanModel() when $default != null:
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
    TResult Function(_AIPlanModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AIPlanModel():
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
    TResult? Function(_AIPlanModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AIPlanModel() when $default != null:
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
            DateTime planDate,
            String status,
            String? promptContext,
            String? modelUsed,
            DateTime generatedAt,
            DateTime? acceptedAt,
            DateTime createdAt,
            List<AIPlanItemModel> items)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AIPlanModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.planDate,
            _that.status,
            _that.promptContext,
            _that.modelUsed,
            _that.generatedAt,
            _that.acceptedAt,
            _that.createdAt,
            _that.items);
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
            DateTime planDate,
            String status,
            String? promptContext,
            String? modelUsed,
            DateTime generatedAt,
            DateTime? acceptedAt,
            DateTime createdAt,
            List<AIPlanItemModel> items)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AIPlanModel():
        return $default(
            _that.id,
            _that.userId,
            _that.planDate,
            _that.status,
            _that.promptContext,
            _that.modelUsed,
            _that.generatedAt,
            _that.acceptedAt,
            _that.createdAt,
            _that.items);
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
            DateTime planDate,
            String status,
            String? promptContext,
            String? modelUsed,
            DateTime generatedAt,
            DateTime? acceptedAt,
            DateTime createdAt,
            List<AIPlanItemModel> items)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AIPlanModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.planDate,
            _that.status,
            _that.promptContext,
            _that.modelUsed,
            _that.generatedAt,
            _that.acceptedAt,
            _that.createdAt,
            _that.items);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AIPlanModel implements AIPlanModel {
  const _AIPlanModel(
      {required this.id,
      required this.userId,
      required this.planDate,
      this.status = 'draft',
      this.promptContext,
      this.modelUsed,
      required this.generatedAt,
      this.acceptedAt,
      required this.createdAt,
      final List<AIPlanItemModel> items = const []})
      : _items = items;
  factory _AIPlanModel.fromJson(Map<String, dynamic> json) =>
      _$AIPlanModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime planDate;
  @override
  @JsonKey()
  final String status;
  @override
  final String? promptContext;
  @override
  final String? modelUsed;
  @override
  final DateTime generatedAt;
  @override
  final DateTime? acceptedAt;
  @override
  final DateTime createdAt;
  final List<AIPlanItemModel> _items;
  @override
  @JsonKey()
  List<AIPlanItemModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Create a copy of AIPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AIPlanModelCopyWith<_AIPlanModel> get copyWith =>
      __$AIPlanModelCopyWithImpl<_AIPlanModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AIPlanModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AIPlanModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.planDate, planDate) ||
                other.planDate == planDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.promptContext, promptContext) ||
                other.promptContext == promptContext) &&
            (identical(other.modelUsed, modelUsed) ||
                other.modelUsed == modelUsed) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.acceptedAt, acceptedAt) ||
                other.acceptedAt == acceptedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      planDate,
      status,
      promptContext,
      modelUsed,
      generatedAt,
      acceptedAt,
      createdAt,
      const DeepCollectionEquality().hash(_items));

  @override
  String toString() {
    return 'AIPlanModel(id: $id, userId: $userId, planDate: $planDate, status: $status, promptContext: $promptContext, modelUsed: $modelUsed, generatedAt: $generatedAt, acceptedAt: $acceptedAt, createdAt: $createdAt, items: $items)';
  }
}

/// @nodoc
abstract mixin class _$AIPlanModelCopyWith<$Res>
    implements $AIPlanModelCopyWith<$Res> {
  factory _$AIPlanModelCopyWith(
          _AIPlanModel value, $Res Function(_AIPlanModel) _then) =
      __$AIPlanModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime planDate,
      String status,
      String? promptContext,
      String? modelUsed,
      DateTime generatedAt,
      DateTime? acceptedAt,
      DateTime createdAt,
      List<AIPlanItemModel> items});
}

/// @nodoc
class __$AIPlanModelCopyWithImpl<$Res> implements _$AIPlanModelCopyWith<$Res> {
  __$AIPlanModelCopyWithImpl(this._self, this._then);

  final _AIPlanModel _self;
  final $Res Function(_AIPlanModel) _then;

  /// Create a copy of AIPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? planDate = null,
    Object? status = null,
    Object? promptContext = freezed,
    Object? modelUsed = freezed,
    Object? generatedAt = null,
    Object? acceptedAt = freezed,
    Object? createdAt = null,
    Object? items = null,
  }) {
    return _then(_AIPlanModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      planDate: null == planDate
          ? _self.planDate
          : planDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      promptContext: freezed == promptContext
          ? _self.promptContext
          : promptContext // ignore: cast_nullable_to_non_nullable
              as String?,
      modelUsed: freezed == modelUsed
          ? _self.modelUsed
          : modelUsed // ignore: cast_nullable_to_non_nullable
              as String?,
      generatedAt: null == generatedAt
          ? _self.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      acceptedAt: freezed == acceptedAt
          ? _self.acceptedAt
          : acceptedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<AIPlanItemModel>,
    ));
  }
}

// dart format on
