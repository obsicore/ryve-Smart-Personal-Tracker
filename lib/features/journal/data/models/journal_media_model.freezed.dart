// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_media_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JournalMediaModel {
  String get id;
  String get entryId;
  String get mediaType;
  String get fileUrl;
  String? get thumbnailUrl;
  DateTime get createdAt;

  /// Create a copy of JournalMediaModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $JournalMediaModelCopyWith<JournalMediaModel> get copyWith =>
      _$JournalMediaModelCopyWithImpl<JournalMediaModel>(
          this as JournalMediaModel, _$identity);

  /// Serializes this JournalMediaModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is JournalMediaModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.entryId, entryId) || other.entryId == entryId) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, entryId, mediaType, fileUrl, thumbnailUrl, createdAt);

  @override
  String toString() {
    return 'JournalMediaModel(id: $id, entryId: $entryId, mediaType: $mediaType, fileUrl: $fileUrl, thumbnailUrl: $thumbnailUrl, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $JournalMediaModelCopyWith<$Res> {
  factory $JournalMediaModelCopyWith(
          JournalMediaModel value, $Res Function(JournalMediaModel) _then) =
      _$JournalMediaModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String entryId,
      String mediaType,
      String fileUrl,
      String? thumbnailUrl,
      DateTime createdAt});
}

/// @nodoc
class _$JournalMediaModelCopyWithImpl<$Res>
    implements $JournalMediaModelCopyWith<$Res> {
  _$JournalMediaModelCopyWithImpl(this._self, this._then);

  final JournalMediaModel _self;
  final $Res Function(JournalMediaModel) _then;

  /// Create a copy of JournalMediaModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? entryId = null,
    Object? mediaType = null,
    Object? fileUrl = null,
    Object? thumbnailUrl = freezed,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      entryId: null == entryId
          ? _self.entryId
          : entryId // ignore: cast_nullable_to_non_nullable
              as String,
      mediaType: null == mediaType
          ? _self.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String,
      fileUrl: null == fileUrl
          ? _self.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: freezed == thumbnailUrl
          ? _self.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [JournalMediaModel].
extension JournalMediaModelPatterns on JournalMediaModel {
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
    TResult Function(_JournalMediaModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _JournalMediaModel() when $default != null:
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
    TResult Function(_JournalMediaModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JournalMediaModel():
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
    TResult? Function(_JournalMediaModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JournalMediaModel() when $default != null:
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
    TResult Function(String id, String entryId, String mediaType,
            String fileUrl, String? thumbnailUrl, DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _JournalMediaModel() when $default != null:
        return $default(_that.id, _that.entryId, _that.mediaType, _that.fileUrl,
            _that.thumbnailUrl, _that.createdAt);
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
    TResult Function(String id, String entryId, String mediaType,
            String fileUrl, String? thumbnailUrl, DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JournalMediaModel():
        return $default(_that.id, _that.entryId, _that.mediaType, _that.fileUrl,
            _that.thumbnailUrl, _that.createdAt);
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
    TResult? Function(String id, String entryId, String mediaType,
            String fileUrl, String? thumbnailUrl, DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JournalMediaModel() when $default != null:
        return $default(_that.id, _that.entryId, _that.mediaType, _that.fileUrl,
            _that.thumbnailUrl, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _JournalMediaModel implements JournalMediaModel {
  const _JournalMediaModel(
      {required this.id,
      required this.entryId,
      this.mediaType = 'image',
      required this.fileUrl,
      this.thumbnailUrl,
      required this.createdAt});
  factory _JournalMediaModel.fromJson(Map<String, dynamic> json) =>
      _$JournalMediaModelFromJson(json);

  @override
  final String id;
  @override
  final String entryId;
  @override
  @JsonKey()
  final String mediaType;
  @override
  final String fileUrl;
  @override
  final String? thumbnailUrl;
  @override
  final DateTime createdAt;

  /// Create a copy of JournalMediaModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$JournalMediaModelCopyWith<_JournalMediaModel> get copyWith =>
      __$JournalMediaModelCopyWithImpl<_JournalMediaModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$JournalMediaModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _JournalMediaModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.entryId, entryId) || other.entryId == entryId) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, entryId, mediaType, fileUrl, thumbnailUrl, createdAt);

  @override
  String toString() {
    return 'JournalMediaModel(id: $id, entryId: $entryId, mediaType: $mediaType, fileUrl: $fileUrl, thumbnailUrl: $thumbnailUrl, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$JournalMediaModelCopyWith<$Res>
    implements $JournalMediaModelCopyWith<$Res> {
  factory _$JournalMediaModelCopyWith(
          _JournalMediaModel value, $Res Function(_JournalMediaModel) _then) =
      __$JournalMediaModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String entryId,
      String mediaType,
      String fileUrl,
      String? thumbnailUrl,
      DateTime createdAt});
}

/// @nodoc
class __$JournalMediaModelCopyWithImpl<$Res>
    implements _$JournalMediaModelCopyWith<$Res> {
  __$JournalMediaModelCopyWithImpl(this._self, this._then);

  final _JournalMediaModel _self;
  final $Res Function(_JournalMediaModel) _then;

  /// Create a copy of JournalMediaModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? entryId = null,
    Object? mediaType = null,
    Object? fileUrl = null,
    Object? thumbnailUrl = freezed,
    Object? createdAt = null,
  }) {
    return _then(_JournalMediaModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      entryId: null == entryId
          ? _self.entryId
          : entryId // ignore: cast_nullable_to_non_nullable
              as String,
      mediaType: null == mediaType
          ? _self.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String,
      fileUrl: null == fileUrl
          ? _self.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: freezed == thumbnailUrl
          ? _self.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
