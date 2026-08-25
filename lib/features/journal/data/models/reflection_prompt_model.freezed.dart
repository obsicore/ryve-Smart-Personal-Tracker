// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reflection_prompt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReflectionPromptModel {
  String get id;
  String get content;
  String get category;
  bool get isActive;
  DateTime get createdAt;

  /// Create a copy of ReflectionPromptModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReflectionPromptModelCopyWith<ReflectionPromptModel> get copyWith =>
      _$ReflectionPromptModelCopyWithImpl<ReflectionPromptModel>(
          this as ReflectionPromptModel, _$identity);

  /// Serializes this ReflectionPromptModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReflectionPromptModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, content, category, isActive, createdAt);

  @override
  String toString() {
    return 'ReflectionPromptModel(id: $id, content: $content, category: $category, isActive: $isActive, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $ReflectionPromptModelCopyWith<$Res> {
  factory $ReflectionPromptModelCopyWith(ReflectionPromptModel value,
          $Res Function(ReflectionPromptModel) _then) =
      _$ReflectionPromptModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String content,
      String category,
      bool isActive,
      DateTime createdAt});
}

/// @nodoc
class _$ReflectionPromptModelCopyWithImpl<$Res>
    implements $ReflectionPromptModelCopyWith<$Res> {
  _$ReflectionPromptModelCopyWithImpl(this._self, this._then);

  final ReflectionPromptModel _self;
  final $Res Function(ReflectionPromptModel) _then;

  /// Create a copy of ReflectionPromptModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? category = null,
    Object? isActive = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [ReflectionPromptModel].
extension ReflectionPromptModelPatterns on ReflectionPromptModel {
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
    TResult Function(_ReflectionPromptModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReflectionPromptModel() when $default != null:
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
    TResult Function(_ReflectionPromptModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReflectionPromptModel():
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
    TResult? Function(_ReflectionPromptModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReflectionPromptModel() when $default != null:
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
    TResult Function(String id, String content, String category, bool isActive,
            DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReflectionPromptModel() when $default != null:
        return $default(_that.id, _that.content, _that.category, _that.isActive,
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
    TResult Function(String id, String content, String category, bool isActive,
            DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReflectionPromptModel():
        return $default(_that.id, _that.content, _that.category, _that.isActive,
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
    TResult? Function(String id, String content, String category, bool isActive,
            DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReflectionPromptModel() when $default != null:
        return $default(_that.id, _that.content, _that.category, _that.isActive,
            _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ReflectionPromptModel implements ReflectionPromptModel {
  const _ReflectionPromptModel(
      {required this.id,
      required this.content,
      this.category = 'general',
      this.isActive = true,
      required this.createdAt});
  factory _ReflectionPromptModel.fromJson(Map<String, dynamic> json) =>
      _$ReflectionPromptModelFromJson(json);

  @override
  final String id;
  @override
  final String content;
  @override
  @JsonKey()
  final String category;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;

  /// Create a copy of ReflectionPromptModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReflectionPromptModelCopyWith<_ReflectionPromptModel> get copyWith =>
      __$ReflectionPromptModelCopyWithImpl<_ReflectionPromptModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReflectionPromptModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReflectionPromptModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, content, category, isActive, createdAt);

  @override
  String toString() {
    return 'ReflectionPromptModel(id: $id, content: $content, category: $category, isActive: $isActive, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$ReflectionPromptModelCopyWith<$Res>
    implements $ReflectionPromptModelCopyWith<$Res> {
  factory _$ReflectionPromptModelCopyWith(_ReflectionPromptModel value,
          $Res Function(_ReflectionPromptModel) _then) =
      __$ReflectionPromptModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String content,
      String category,
      bool isActive,
      DateTime createdAt});
}

/// @nodoc
class __$ReflectionPromptModelCopyWithImpl<$Res>
    implements _$ReflectionPromptModelCopyWith<$Res> {
  __$ReflectionPromptModelCopyWithImpl(this._self, this._then);

  final _ReflectionPromptModel _self;
  final $Res Function(_ReflectionPromptModel) _then;

  /// Create a copy of ReflectionPromptModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? category = null,
    Object? isActive = null,
    Object? createdAt = null,
  }) {
    return _then(_ReflectionPromptModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
mixin _$ReflectionResponseModel {
  String get id;
  String get userId;
  String get promptId;
  String get response;
  DateTime get createdAt;

  /// Create a copy of ReflectionResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReflectionResponseModelCopyWith<ReflectionResponseModel> get copyWith =>
      _$ReflectionResponseModelCopyWithImpl<ReflectionResponseModel>(
          this as ReflectionResponseModel, _$identity);

  /// Serializes this ReflectionResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReflectionResponseModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.promptId, promptId) ||
                other.promptId == promptId) &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, promptId, response, createdAt);

  @override
  String toString() {
    return 'ReflectionResponseModel(id: $id, userId: $userId, promptId: $promptId, response: $response, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $ReflectionResponseModelCopyWith<$Res> {
  factory $ReflectionResponseModelCopyWith(ReflectionResponseModel value,
          $Res Function(ReflectionResponseModel) _then) =
      _$ReflectionResponseModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String promptId,
      String response,
      DateTime createdAt});
}

/// @nodoc
class _$ReflectionResponseModelCopyWithImpl<$Res>
    implements $ReflectionResponseModelCopyWith<$Res> {
  _$ReflectionResponseModelCopyWithImpl(this._self, this._then);

  final ReflectionResponseModel _self;
  final $Res Function(ReflectionResponseModel) _then;

  /// Create a copy of ReflectionResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? promptId = null,
    Object? response = null,
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
      promptId: null == promptId
          ? _self.promptId
          : promptId // ignore: cast_nullable_to_non_nullable
              as String,
      response: null == response
          ? _self.response
          : response // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [ReflectionResponseModel].
extension ReflectionResponseModelPatterns on ReflectionResponseModel {
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
    TResult Function(_ReflectionResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReflectionResponseModel() when $default != null:
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
    TResult Function(_ReflectionResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReflectionResponseModel():
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
    TResult? Function(_ReflectionResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReflectionResponseModel() when $default != null:
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
    TResult Function(String id, String userId, String promptId, String response,
            DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReflectionResponseModel() when $default != null:
        return $default(_that.id, _that.userId, _that.promptId, _that.response,
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
    TResult Function(String id, String userId, String promptId, String response,
            DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReflectionResponseModel():
        return $default(_that.id, _that.userId, _that.promptId, _that.response,
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
    TResult? Function(String id, String userId, String promptId,
            String response, DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReflectionResponseModel() when $default != null:
        return $default(_that.id, _that.userId, _that.promptId, _that.response,
            _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ReflectionResponseModel implements ReflectionResponseModel {
  const _ReflectionResponseModel(
      {required this.id,
      required this.userId,
      required this.promptId,
      required this.response,
      required this.createdAt});
  factory _ReflectionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ReflectionResponseModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String promptId;
  @override
  final String response;
  @override
  final DateTime createdAt;

  /// Create a copy of ReflectionResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReflectionResponseModelCopyWith<_ReflectionResponseModel> get copyWith =>
      __$ReflectionResponseModelCopyWithImpl<_ReflectionResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReflectionResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReflectionResponseModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.promptId, promptId) ||
                other.promptId == promptId) &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, promptId, response, createdAt);

  @override
  String toString() {
    return 'ReflectionResponseModel(id: $id, userId: $userId, promptId: $promptId, response: $response, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$ReflectionResponseModelCopyWith<$Res>
    implements $ReflectionResponseModelCopyWith<$Res> {
  factory _$ReflectionResponseModelCopyWith(_ReflectionResponseModel value,
          $Res Function(_ReflectionResponseModel) _then) =
      __$ReflectionResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String promptId,
      String response,
      DateTime createdAt});
}

/// @nodoc
class __$ReflectionResponseModelCopyWithImpl<$Res>
    implements _$ReflectionResponseModelCopyWith<$Res> {
  __$ReflectionResponseModelCopyWithImpl(this._self, this._then);

  final _ReflectionResponseModel _self;
  final $Res Function(_ReflectionResponseModel) _then;

  /// Create a copy of ReflectionResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? promptId = null,
    Object? response = null,
    Object? createdAt = null,
  }) {
    return _then(_ReflectionResponseModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      promptId: null == promptId
          ? _self.promptId
          : promptId // ignore: cast_nullable_to_non_nullable
              as String,
      response: null == response
          ? _self.response
          : response // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
