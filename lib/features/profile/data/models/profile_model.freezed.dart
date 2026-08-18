// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileModel {
  String get userId;
  String get displayName;
  String? get email;
  String? get avatarUrl;
  int get level;
  int get xpTotal;
  int get xpToNextLevel;
  int get currentStreak;
  int get bestStreak;
  int get tasksCompleted;
  int get habitsLogged;
  int get focusHours;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProfileModelCopyWith<ProfileModel> get copyWith =>
      _$ProfileModelCopyWithImpl<ProfileModel>(
          this as ProfileModel, _$identity);

  /// Serializes this ProfileModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProfileModel &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.xpTotal, xpTotal) || other.xpTotal == xpTotal) &&
            (identical(other.xpToNextLevel, xpToNextLevel) ||
                other.xpToNextLevel == xpToNextLevel) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.bestStreak, bestStreak) ||
                other.bestStreak == bestStreak) &&
            (identical(other.tasksCompleted, tasksCompleted) ||
                other.tasksCompleted == tasksCompleted) &&
            (identical(other.habitsLogged, habitsLogged) ||
                other.habitsLogged == habitsLogged) &&
            (identical(other.focusHours, focusHours) ||
                other.focusHours == focusHours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      displayName,
      email,
      avatarUrl,
      level,
      xpTotal,
      xpToNextLevel,
      currentStreak,
      bestStreak,
      tasksCompleted,
      habitsLogged,
      focusHours);

  @override
  String toString() {
    return 'ProfileModel(userId: $userId, displayName: $displayName, email: $email, avatarUrl: $avatarUrl, level: $level, xpTotal: $xpTotal, xpToNextLevel: $xpToNextLevel, currentStreak: $currentStreak, bestStreak: $bestStreak, tasksCompleted: $tasksCompleted, habitsLogged: $habitsLogged, focusHours: $focusHours)';
  }
}

/// @nodoc
abstract mixin class $ProfileModelCopyWith<$Res> {
  factory $ProfileModelCopyWith(
          ProfileModel value, $Res Function(ProfileModel) _then) =
      _$ProfileModelCopyWithImpl;
  @useResult
  $Res call(
      {String userId,
      String displayName,
      String? email,
      String? avatarUrl,
      int level,
      int xpTotal,
      int xpToNextLevel,
      int currentStreak,
      int bestStreak,
      int tasksCompleted,
      int habitsLogged,
      int focusHours});
}

/// @nodoc
class _$ProfileModelCopyWithImpl<$Res> implements $ProfileModelCopyWith<$Res> {
  _$ProfileModelCopyWithImpl(this._self, this._then);

  final ProfileModel _self;
  final $Res Function(ProfileModel) _then;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? email = freezed,
    Object? avatarUrl = freezed,
    Object? level = null,
    Object? xpTotal = null,
    Object? xpToNextLevel = null,
    Object? currentStreak = null,
    Object? bestStreak = null,
    Object? tasksCompleted = null,
    Object? habitsLogged = null,
    Object? focusHours = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      level: null == level
          ? _self.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      xpTotal: null == xpTotal
          ? _self.xpTotal
          : xpTotal // ignore: cast_nullable_to_non_nullable
              as int,
      xpToNextLevel: null == xpToNextLevel
          ? _self.xpToNextLevel
          : xpToNextLevel // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _self.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      bestStreak: null == bestStreak
          ? _self.bestStreak
          : bestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      tasksCompleted: null == tasksCompleted
          ? _self.tasksCompleted
          : tasksCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      habitsLogged: null == habitsLogged
          ? _self.habitsLogged
          : habitsLogged // ignore: cast_nullable_to_non_nullable
              as int,
      focusHours: null == focusHours
          ? _self.focusHours
          : focusHours // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [ProfileModel].
extension ProfileModelPatterns on ProfileModel {
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
    TResult Function(_ProfileModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProfileModel() when $default != null:
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
    TResult Function(_ProfileModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProfileModel():
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
    TResult? Function(_ProfileModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProfileModel() when $default != null:
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
            String userId,
            String displayName,
            String? email,
            String? avatarUrl,
            int level,
            int xpTotal,
            int xpToNextLevel,
            int currentStreak,
            int bestStreak,
            int tasksCompleted,
            int habitsLogged,
            int focusHours)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProfileModel() when $default != null:
        return $default(
            _that.userId,
            _that.displayName,
            _that.email,
            _that.avatarUrl,
            _that.level,
            _that.xpTotal,
            _that.xpToNextLevel,
            _that.currentStreak,
            _that.bestStreak,
            _that.tasksCompleted,
            _that.habitsLogged,
            _that.focusHours);
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
            String userId,
            String displayName,
            String? email,
            String? avatarUrl,
            int level,
            int xpTotal,
            int xpToNextLevel,
            int currentStreak,
            int bestStreak,
            int tasksCompleted,
            int habitsLogged,
            int focusHours)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProfileModel():
        return $default(
            _that.userId,
            _that.displayName,
            _that.email,
            _that.avatarUrl,
            _that.level,
            _that.xpTotal,
            _that.xpToNextLevel,
            _that.currentStreak,
            _that.bestStreak,
            _that.tasksCompleted,
            _that.habitsLogged,
            _that.focusHours);
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
            String userId,
            String displayName,
            String? email,
            String? avatarUrl,
            int level,
            int xpTotal,
            int xpToNextLevel,
            int currentStreak,
            int bestStreak,
            int tasksCompleted,
            int habitsLogged,
            int focusHours)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProfileModel() when $default != null:
        return $default(
            _that.userId,
            _that.displayName,
            _that.email,
            _that.avatarUrl,
            _that.level,
            _that.xpTotal,
            _that.xpToNextLevel,
            _that.currentStreak,
            _that.bestStreak,
            _that.tasksCompleted,
            _that.habitsLogged,
            _that.focusHours);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ProfileModel implements ProfileModel {
  const _ProfileModel(
      {required this.userId,
      required this.displayName,
      this.email,
      this.avatarUrl,
      this.level = 1,
      this.xpTotal = 0,
      this.xpToNextLevel = 0,
      this.currentStreak = 0,
      this.bestStreak = 0,
      this.tasksCompleted = 0,
      this.habitsLogged = 0,
      this.focusHours = 0});
  factory _ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  @override
  final String userId;
  @override
  final String displayName;
  @override
  final String? email;
  @override
  final String? avatarUrl;
  @override
  @JsonKey()
  final int level;
  @override
  @JsonKey()
  final int xpTotal;
  @override
  @JsonKey()
  final int xpToNextLevel;
  @override
  @JsonKey()
  final int currentStreak;
  @override
  @JsonKey()
  final int bestStreak;
  @override
  @JsonKey()
  final int tasksCompleted;
  @override
  @JsonKey()
  final int habitsLogged;
  @override
  @JsonKey()
  final int focusHours;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProfileModelCopyWith<_ProfileModel> get copyWith =>
      __$ProfileModelCopyWithImpl<_ProfileModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProfileModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProfileModel &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.xpTotal, xpTotal) || other.xpTotal == xpTotal) &&
            (identical(other.xpToNextLevel, xpToNextLevel) ||
                other.xpToNextLevel == xpToNextLevel) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.bestStreak, bestStreak) ||
                other.bestStreak == bestStreak) &&
            (identical(other.tasksCompleted, tasksCompleted) ||
                other.tasksCompleted == tasksCompleted) &&
            (identical(other.habitsLogged, habitsLogged) ||
                other.habitsLogged == habitsLogged) &&
            (identical(other.focusHours, focusHours) ||
                other.focusHours == focusHours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      displayName,
      email,
      avatarUrl,
      level,
      xpTotal,
      xpToNextLevel,
      currentStreak,
      bestStreak,
      tasksCompleted,
      habitsLogged,
      focusHours);

  @override
  String toString() {
    return 'ProfileModel(userId: $userId, displayName: $displayName, email: $email, avatarUrl: $avatarUrl, level: $level, xpTotal: $xpTotal, xpToNextLevel: $xpToNextLevel, currentStreak: $currentStreak, bestStreak: $bestStreak, tasksCompleted: $tasksCompleted, habitsLogged: $habitsLogged, focusHours: $focusHours)';
  }
}

/// @nodoc
abstract mixin class _$ProfileModelCopyWith<$Res>
    implements $ProfileModelCopyWith<$Res> {
  factory _$ProfileModelCopyWith(
          _ProfileModel value, $Res Function(_ProfileModel) _then) =
      __$ProfileModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String userId,
      String displayName,
      String? email,
      String? avatarUrl,
      int level,
      int xpTotal,
      int xpToNextLevel,
      int currentStreak,
      int bestStreak,
      int tasksCompleted,
      int habitsLogged,
      int focusHours});
}

/// @nodoc
class __$ProfileModelCopyWithImpl<$Res>
    implements _$ProfileModelCopyWith<$Res> {
  __$ProfileModelCopyWithImpl(this._self, this._then);

  final _ProfileModel _self;
  final $Res Function(_ProfileModel) _then;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? email = freezed,
    Object? avatarUrl = freezed,
    Object? level = null,
    Object? xpTotal = null,
    Object? xpToNextLevel = null,
    Object? currentStreak = null,
    Object? bestStreak = null,
    Object? tasksCompleted = null,
    Object? habitsLogged = null,
    Object? focusHours = null,
  }) {
    return _then(_ProfileModel(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      level: null == level
          ? _self.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      xpTotal: null == xpTotal
          ? _self.xpTotal
          : xpTotal // ignore: cast_nullable_to_non_nullable
              as int,
      xpToNextLevel: null == xpToNextLevel
          ? _self.xpToNextLevel
          : xpToNextLevel // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _self.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      bestStreak: null == bestStreak
          ? _self.bestStreak
          : bestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      tasksCompleted: null == tasksCompleted
          ? _self.tasksCompleted
          : tasksCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      habitsLogged: null == habitsLogged
          ? _self.habitsLogged
          : habitsLogged // ignore: cast_nullable_to_non_nullable
              as int,
      focusHours: null == focusHours
          ? _self.focusHours
          : focusHours // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$BadgeModel {
  String get id;
  String get name;
  String get description;
  String get iconEmoji;
  String get category;
  int get rarity;
  bool get isEarned;
  DateTime? get earnedAt;

  /// Create a copy of BadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BadgeModelCopyWith<BadgeModel> get copyWith =>
      _$BadgeModelCopyWithImpl<BadgeModel>(this as BadgeModel, _$identity);

  /// Serializes this BadgeModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BadgeModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.iconEmoji, iconEmoji) ||
                other.iconEmoji == iconEmoji) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.rarity, rarity) || other.rarity == rarity) &&
            (identical(other.isEarned, isEarned) ||
                other.isEarned == isEarned) &&
            (identical(other.earnedAt, earnedAt) ||
                other.earnedAt == earnedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, iconEmoji,
      category, rarity, isEarned, earnedAt);

  @override
  String toString() {
    return 'BadgeModel(id: $id, name: $name, description: $description, iconEmoji: $iconEmoji, category: $category, rarity: $rarity, isEarned: $isEarned, earnedAt: $earnedAt)';
  }
}

/// @nodoc
abstract mixin class $BadgeModelCopyWith<$Res> {
  factory $BadgeModelCopyWith(
          BadgeModel value, $Res Function(BadgeModel) _then) =
      _$BadgeModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String iconEmoji,
      String category,
      int rarity,
      bool isEarned,
      DateTime? earnedAt});
}

/// @nodoc
class _$BadgeModelCopyWithImpl<$Res> implements $BadgeModelCopyWith<$Res> {
  _$BadgeModelCopyWithImpl(this._self, this._then);

  final BadgeModel _self;
  final $Res Function(BadgeModel) _then;

  /// Create a copy of BadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? iconEmoji = null,
    Object? category = null,
    Object? rarity = null,
    Object? isEarned = null,
    Object? earnedAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      iconEmoji: null == iconEmoji
          ? _self.iconEmoji
          : iconEmoji // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      rarity: null == rarity
          ? _self.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      isEarned: null == isEarned
          ? _self.isEarned
          : isEarned // ignore: cast_nullable_to_non_nullable
              as bool,
      earnedAt: freezed == earnedAt
          ? _self.earnedAt
          : earnedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [BadgeModel].
extension BadgeModelPatterns on BadgeModel {
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
    TResult Function(_BadgeModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BadgeModel() when $default != null:
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
    TResult Function(_BadgeModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeModel():
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
    TResult? Function(_BadgeModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeModel() when $default != null:
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
            String name,
            String description,
            String iconEmoji,
            String category,
            int rarity,
            bool isEarned,
            DateTime? earnedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BadgeModel() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.iconEmoji,
            _that.category,
            _that.rarity,
            _that.isEarned,
            _that.earnedAt);
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
            String name,
            String description,
            String iconEmoji,
            String category,
            int rarity,
            bool isEarned,
            DateTime? earnedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeModel():
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.iconEmoji,
            _that.category,
            _that.rarity,
            _that.isEarned,
            _that.earnedAt);
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
            String name,
            String description,
            String iconEmoji,
            String category,
            int rarity,
            bool isEarned,
            DateTime? earnedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeModel() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.iconEmoji,
            _that.category,
            _that.rarity,
            _that.isEarned,
            _that.earnedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BadgeModel implements BadgeModel {
  const _BadgeModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.iconEmoji,
      required this.category,
      this.rarity = 1,
      this.isEarned = false,
      this.earnedAt});
  factory _BadgeModel.fromJson(Map<String, dynamic> json) =>
      _$BadgeModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String iconEmoji;
  @override
  final String category;
  @override
  @JsonKey()
  final int rarity;
  @override
  @JsonKey()
  final bool isEarned;
  @override
  final DateTime? earnedAt;

  /// Create a copy of BadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BadgeModelCopyWith<_BadgeModel> get copyWith =>
      __$BadgeModelCopyWithImpl<_BadgeModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BadgeModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BadgeModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.iconEmoji, iconEmoji) ||
                other.iconEmoji == iconEmoji) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.rarity, rarity) || other.rarity == rarity) &&
            (identical(other.isEarned, isEarned) ||
                other.isEarned == isEarned) &&
            (identical(other.earnedAt, earnedAt) ||
                other.earnedAt == earnedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, iconEmoji,
      category, rarity, isEarned, earnedAt);

  @override
  String toString() {
    return 'BadgeModel(id: $id, name: $name, description: $description, iconEmoji: $iconEmoji, category: $category, rarity: $rarity, isEarned: $isEarned, earnedAt: $earnedAt)';
  }
}

/// @nodoc
abstract mixin class _$BadgeModelCopyWith<$Res>
    implements $BadgeModelCopyWith<$Res> {
  factory _$BadgeModelCopyWith(
          _BadgeModel value, $Res Function(_BadgeModel) _then) =
      __$BadgeModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String iconEmoji,
      String category,
      int rarity,
      bool isEarned,
      DateTime? earnedAt});
}

/// @nodoc
class __$BadgeModelCopyWithImpl<$Res> implements _$BadgeModelCopyWith<$Res> {
  __$BadgeModelCopyWithImpl(this._self, this._then);

  final _BadgeModel _self;
  final $Res Function(_BadgeModel) _then;

  /// Create a copy of BadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? iconEmoji = null,
    Object? category = null,
    Object? rarity = null,
    Object? isEarned = null,
    Object? earnedAt = freezed,
  }) {
    return _then(_BadgeModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      iconEmoji: null == iconEmoji
          ? _self.iconEmoji
          : iconEmoji // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      rarity: null == rarity
          ? _self.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      isEarned: null == isEarned
          ? _self.isEarned
          : isEarned // ignore: cast_nullable_to_non_nullable
              as bool,
      earnedAt: freezed == earnedAt
          ? _self.earnedAt
          : earnedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
