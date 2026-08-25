// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coaching_insight_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CoachingInsightModel {
  String get id;
  String get userId;
  String get category;
  String get content;
  String? get contextJson;
  bool get isRead;
  bool get isDismissed;
  DateTime get generatedAt;
  DateTime? get readAt;

  /// Create a copy of CoachingInsightModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CoachingInsightModelCopyWith<CoachingInsightModel> get copyWith =>
      _$CoachingInsightModelCopyWithImpl<CoachingInsightModel>(
          this as CoachingInsightModel, _$identity);

  /// Serializes this CoachingInsightModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CoachingInsightModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.contextJson, contextJson) ||
                other.contextJson == contextJson) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isDismissed, isDismissed) ||
                other.isDismissed == isDismissed) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, category, content,
      contextJson, isRead, isDismissed, generatedAt, readAt);

  @override
  String toString() {
    return 'CoachingInsightModel(id: $id, userId: $userId, category: $category, content: $content, contextJson: $contextJson, isRead: $isRead, isDismissed: $isDismissed, generatedAt: $generatedAt, readAt: $readAt)';
  }
}

/// @nodoc
abstract mixin class $CoachingInsightModelCopyWith<$Res> {
  factory $CoachingInsightModelCopyWith(CoachingInsightModel value,
          $Res Function(CoachingInsightModel) _then) =
      _$CoachingInsightModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String category,
      String content,
      String? contextJson,
      bool isRead,
      bool isDismissed,
      DateTime generatedAt,
      DateTime? readAt});
}

/// @nodoc
class _$CoachingInsightModelCopyWithImpl<$Res>
    implements $CoachingInsightModelCopyWith<$Res> {
  _$CoachingInsightModelCopyWithImpl(this._self, this._then);

  final CoachingInsightModel _self;
  final $Res Function(CoachingInsightModel) _then;

  /// Create a copy of CoachingInsightModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? category = null,
    Object? content = null,
    Object? contextJson = freezed,
    Object? isRead = null,
    Object? isDismissed = null,
    Object? generatedAt = null,
    Object? readAt = freezed,
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
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      contextJson: freezed == contextJson
          ? _self.contextJson
          : contextJson // ignore: cast_nullable_to_non_nullable
              as String?,
      isRead: null == isRead
          ? _self.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      isDismissed: null == isDismissed
          ? _self.isDismissed
          : isDismissed // ignore: cast_nullable_to_non_nullable
              as bool,
      generatedAt: null == generatedAt
          ? _self.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readAt: freezed == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CoachingInsightModel].
extension CoachingInsightModelPatterns on CoachingInsightModel {
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
    TResult Function(_CoachingInsightModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CoachingInsightModel() when $default != null:
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
    TResult Function(_CoachingInsightModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CoachingInsightModel():
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
    TResult? Function(_CoachingInsightModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CoachingInsightModel() when $default != null:
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
            String category,
            String content,
            String? contextJson,
            bool isRead,
            bool isDismissed,
            DateTime generatedAt,
            DateTime? readAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CoachingInsightModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.category,
            _that.content,
            _that.contextJson,
            _that.isRead,
            _that.isDismissed,
            _that.generatedAt,
            _that.readAt);
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
            String category,
            String content,
            String? contextJson,
            bool isRead,
            bool isDismissed,
            DateTime generatedAt,
            DateTime? readAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CoachingInsightModel():
        return $default(
            _that.id,
            _that.userId,
            _that.category,
            _that.content,
            _that.contextJson,
            _that.isRead,
            _that.isDismissed,
            _that.generatedAt,
            _that.readAt);
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
            String category,
            String content,
            String? contextJson,
            bool isRead,
            bool isDismissed,
            DateTime generatedAt,
            DateTime? readAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CoachingInsightModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.category,
            _that.content,
            _that.contextJson,
            _that.isRead,
            _that.isDismissed,
            _that.generatedAt,
            _that.readAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CoachingInsightModel implements CoachingInsightModel {
  const _CoachingInsightModel(
      {required this.id,
      required this.userId,
      required this.category,
      required this.content,
      this.contextJson,
      this.isRead = false,
      this.isDismissed = false,
      required this.generatedAt,
      this.readAt});
  factory _CoachingInsightModel.fromJson(Map<String, dynamic> json) =>
      _$CoachingInsightModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String category;
  @override
  final String content;
  @override
  final String? contextJson;
  @override
  @JsonKey()
  final bool isRead;
  @override
  @JsonKey()
  final bool isDismissed;
  @override
  final DateTime generatedAt;
  @override
  final DateTime? readAt;

  /// Create a copy of CoachingInsightModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CoachingInsightModelCopyWith<_CoachingInsightModel> get copyWith =>
      __$CoachingInsightModelCopyWithImpl<_CoachingInsightModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CoachingInsightModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CoachingInsightModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.contextJson, contextJson) ||
                other.contextJson == contextJson) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isDismissed, isDismissed) ||
                other.isDismissed == isDismissed) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, category, content,
      contextJson, isRead, isDismissed, generatedAt, readAt);

  @override
  String toString() {
    return 'CoachingInsightModel(id: $id, userId: $userId, category: $category, content: $content, contextJson: $contextJson, isRead: $isRead, isDismissed: $isDismissed, generatedAt: $generatedAt, readAt: $readAt)';
  }
}

/// @nodoc
abstract mixin class _$CoachingInsightModelCopyWith<$Res>
    implements $CoachingInsightModelCopyWith<$Res> {
  factory _$CoachingInsightModelCopyWith(_CoachingInsightModel value,
          $Res Function(_CoachingInsightModel) _then) =
      __$CoachingInsightModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String category,
      String content,
      String? contextJson,
      bool isRead,
      bool isDismissed,
      DateTime generatedAt,
      DateTime? readAt});
}

/// @nodoc
class __$CoachingInsightModelCopyWithImpl<$Res>
    implements _$CoachingInsightModelCopyWith<$Res> {
  __$CoachingInsightModelCopyWithImpl(this._self, this._then);

  final _CoachingInsightModel _self;
  final $Res Function(_CoachingInsightModel) _then;

  /// Create a copy of CoachingInsightModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? category = null,
    Object? content = null,
    Object? contextJson = freezed,
    Object? isRead = null,
    Object? isDismissed = null,
    Object? generatedAt = null,
    Object? readAt = freezed,
  }) {
    return _then(_CoachingInsightModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      contextJson: freezed == contextJson
          ? _self.contextJson
          : contextJson // ignore: cast_nullable_to_non_nullable
              as String?,
      isRead: null == isRead
          ? _self.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      isDismissed: null == isDismissed
          ? _self.isDismissed
          : isDismissed // ignore: cast_nullable_to_non_nullable
              as bool,
      generatedAt: null == generatedAt
          ? _self.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readAt: freezed == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
