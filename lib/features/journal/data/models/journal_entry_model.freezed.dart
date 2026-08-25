// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JournalEntryModel {
  String get id;
  String get userId;
  DateTime get entryDate;
  String? get title;
  String get content;
  String? get moodTag;
  bool get isPrivate;
  int get wordCount;
  DateTime get createdAt;
  DateTime get updatedAt;
  int get syncStatus;
  List<JournalMediaModel> get media;

  /// Create a copy of JournalEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $JournalEntryModelCopyWith<JournalEntryModel> get copyWith =>
      _$JournalEntryModelCopyWithImpl<JournalEntryModel>(
          this as JournalEntryModel, _$identity);

  /// Serializes this JournalEntryModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is JournalEntryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.entryDate, entryDate) ||
                other.entryDate == entryDate) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.moodTag, moodTag) || other.moodTag == moodTag) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.wordCount, wordCount) ||
                other.wordCount == wordCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus) &&
            const DeepCollectionEquality().equals(other.media, media));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      entryDate,
      title,
      content,
      moodTag,
      isPrivate,
      wordCount,
      createdAt,
      updatedAt,
      syncStatus,
      const DeepCollectionEquality().hash(media));

  @override
  String toString() {
    return 'JournalEntryModel(id: $id, userId: $userId, entryDate: $entryDate, title: $title, content: $content, moodTag: $moodTag, isPrivate: $isPrivate, wordCount: $wordCount, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, media: $media)';
  }
}

/// @nodoc
abstract mixin class $JournalEntryModelCopyWith<$Res> {
  factory $JournalEntryModelCopyWith(
          JournalEntryModel value, $Res Function(JournalEntryModel) _then) =
      _$JournalEntryModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime entryDate,
      String? title,
      String content,
      String? moodTag,
      bool isPrivate,
      int wordCount,
      DateTime createdAt,
      DateTime updatedAt,
      int syncStatus,
      List<JournalMediaModel> media});
}

/// @nodoc
class _$JournalEntryModelCopyWithImpl<$Res>
    implements $JournalEntryModelCopyWith<$Res> {
  _$JournalEntryModelCopyWithImpl(this._self, this._then);

  final JournalEntryModel _self;
  final $Res Function(JournalEntryModel) _then;

  /// Create a copy of JournalEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? entryDate = null,
    Object? title = freezed,
    Object? content = null,
    Object? moodTag = freezed,
    Object? isPrivate = null,
    Object? wordCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncStatus = null,
    Object? media = null,
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
      entryDate: null == entryDate
          ? _self.entryDate
          : entryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      moodTag: freezed == moodTag
          ? _self.moodTag
          : moodTag // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrivate: null == isPrivate
          ? _self.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
      wordCount: null == wordCount
          ? _self.wordCount
          : wordCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncStatus: null == syncStatus
          ? _self.syncStatus
          : syncStatus // ignore: cast_nullable_to_non_nullable
              as int,
      media: null == media
          ? _self.media
          : media // ignore: cast_nullable_to_non_nullable
              as List<JournalMediaModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [JournalEntryModel].
extension JournalEntryModelPatterns on JournalEntryModel {
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
    TResult Function(_JournalEntryModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _JournalEntryModel() when $default != null:
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
    TResult Function(_JournalEntryModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JournalEntryModel():
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
    TResult? Function(_JournalEntryModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JournalEntryModel() when $default != null:
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
            DateTime entryDate,
            String? title,
            String content,
            String? moodTag,
            bool isPrivate,
            int wordCount,
            DateTime createdAt,
            DateTime updatedAt,
            int syncStatus,
            List<JournalMediaModel> media)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _JournalEntryModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.entryDate,
            _that.title,
            _that.content,
            _that.moodTag,
            _that.isPrivate,
            _that.wordCount,
            _that.createdAt,
            _that.updatedAt,
            _that.syncStatus,
            _that.media);
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
            DateTime entryDate,
            String? title,
            String content,
            String? moodTag,
            bool isPrivate,
            int wordCount,
            DateTime createdAt,
            DateTime updatedAt,
            int syncStatus,
            List<JournalMediaModel> media)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JournalEntryModel():
        return $default(
            _that.id,
            _that.userId,
            _that.entryDate,
            _that.title,
            _that.content,
            _that.moodTag,
            _that.isPrivate,
            _that.wordCount,
            _that.createdAt,
            _that.updatedAt,
            _that.syncStatus,
            _that.media);
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
            DateTime entryDate,
            String? title,
            String content,
            String? moodTag,
            bool isPrivate,
            int wordCount,
            DateTime createdAt,
            DateTime updatedAt,
            int syncStatus,
            List<JournalMediaModel> media)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JournalEntryModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.entryDate,
            _that.title,
            _that.content,
            _that.moodTag,
            _that.isPrivate,
            _that.wordCount,
            _that.createdAt,
            _that.updatedAt,
            _that.syncStatus,
            _that.media);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _JournalEntryModel implements JournalEntryModel {
  const _JournalEntryModel(
      {required this.id,
      required this.userId,
      required this.entryDate,
      this.title,
      this.content = '',
      this.moodTag,
      this.isPrivate = true,
      this.wordCount = 0,
      required this.createdAt,
      required this.updatedAt,
      this.syncStatus = 0,
      final List<JournalMediaModel> media = const []})
      : _media = media;
  factory _JournalEntryModel.fromJson(Map<String, dynamic> json) =>
      _$JournalEntryModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime entryDate;
  @override
  final String? title;
  @override
  @JsonKey()
  final String content;
  @override
  final String? moodTag;
  @override
  @JsonKey()
  final bool isPrivate;
  @override
  @JsonKey()
  final int wordCount;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final int syncStatus;
  final List<JournalMediaModel> _media;
  @override
  @JsonKey()
  List<JournalMediaModel> get media {
    if (_media is EqualUnmodifiableListView) return _media;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_media);
  }

  /// Create a copy of JournalEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$JournalEntryModelCopyWith<_JournalEntryModel> get copyWith =>
      __$JournalEntryModelCopyWithImpl<_JournalEntryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$JournalEntryModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _JournalEntryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.entryDate, entryDate) ||
                other.entryDate == entryDate) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.moodTag, moodTag) || other.moodTag == moodTag) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.wordCount, wordCount) ||
                other.wordCount == wordCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus) &&
            const DeepCollectionEquality().equals(other._media, _media));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      entryDate,
      title,
      content,
      moodTag,
      isPrivate,
      wordCount,
      createdAt,
      updatedAt,
      syncStatus,
      const DeepCollectionEquality().hash(_media));

  @override
  String toString() {
    return 'JournalEntryModel(id: $id, userId: $userId, entryDate: $entryDate, title: $title, content: $content, moodTag: $moodTag, isPrivate: $isPrivate, wordCount: $wordCount, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, media: $media)';
  }
}

/// @nodoc
abstract mixin class _$JournalEntryModelCopyWith<$Res>
    implements $JournalEntryModelCopyWith<$Res> {
  factory _$JournalEntryModelCopyWith(
          _JournalEntryModel value, $Res Function(_JournalEntryModel) _then) =
      __$JournalEntryModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime entryDate,
      String? title,
      String content,
      String? moodTag,
      bool isPrivate,
      int wordCount,
      DateTime createdAt,
      DateTime updatedAt,
      int syncStatus,
      List<JournalMediaModel> media});
}

/// @nodoc
class __$JournalEntryModelCopyWithImpl<$Res>
    implements _$JournalEntryModelCopyWith<$Res> {
  __$JournalEntryModelCopyWithImpl(this._self, this._then);

  final _JournalEntryModel _self;
  final $Res Function(_JournalEntryModel) _then;

  /// Create a copy of JournalEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? entryDate = null,
    Object? title = freezed,
    Object? content = null,
    Object? moodTag = freezed,
    Object? isPrivate = null,
    Object? wordCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncStatus = null,
    Object? media = null,
  }) {
    return _then(_JournalEntryModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      entryDate: null == entryDate
          ? _self.entryDate
          : entryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      moodTag: freezed == moodTag
          ? _self.moodTag
          : moodTag // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrivate: null == isPrivate
          ? _self.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
      wordCount: null == wordCount
          ? _self.wordCount
          : wordCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncStatus: null == syncStatus
          ? _self.syncStatus
          : syncStatus // ignore: cast_nullable_to_non_nullable
              as int,
      media: null == media
          ? _self._media
          : media // ignore: cast_nullable_to_non_nullable
              as List<JournalMediaModel>,
    ));
  }
}

// dart format on
