// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'life_area_score_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LifeAreaScoreModel {
  String get id;
  String get userId;
  DateTime get scoredAt;
  int get health;
  int get work;
  int get finance;
  int get relationships;
  int get personalGrowth;
  int get learning;
  int get recreation;
  DateTime get createdAt;

  /// Create a copy of LifeAreaScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LifeAreaScoreModelCopyWith<LifeAreaScoreModel> get copyWith =>
      _$LifeAreaScoreModelCopyWithImpl<LifeAreaScoreModel>(
          this as LifeAreaScoreModel, _$identity);

  /// Serializes this LifeAreaScoreModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LifeAreaScoreModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.scoredAt, scoredAt) ||
                other.scoredAt == scoredAt) &&
            (identical(other.health, health) || other.health == health) &&
            (identical(other.work, work) || other.work == work) &&
            (identical(other.finance, finance) || other.finance == finance) &&
            (identical(other.relationships, relationships) ||
                other.relationships == relationships) &&
            (identical(other.personalGrowth, personalGrowth) ||
                other.personalGrowth == personalGrowth) &&
            (identical(other.learning, learning) ||
                other.learning == learning) &&
            (identical(other.recreation, recreation) ||
                other.recreation == recreation) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      scoredAt,
      health,
      work,
      finance,
      relationships,
      personalGrowth,
      learning,
      recreation,
      createdAt);

  @override
  String toString() {
    return 'LifeAreaScoreModel(id: $id, userId: $userId, scoredAt: $scoredAt, health: $health, work: $work, finance: $finance, relationships: $relationships, personalGrowth: $personalGrowth, learning: $learning, recreation: $recreation, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $LifeAreaScoreModelCopyWith<$Res> {
  factory $LifeAreaScoreModelCopyWith(
          LifeAreaScoreModel value, $Res Function(LifeAreaScoreModel) _then) =
      _$LifeAreaScoreModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime scoredAt,
      int health,
      int work,
      int finance,
      int relationships,
      int personalGrowth,
      int learning,
      int recreation,
      DateTime createdAt});
}

/// @nodoc
class _$LifeAreaScoreModelCopyWithImpl<$Res>
    implements $LifeAreaScoreModelCopyWith<$Res> {
  _$LifeAreaScoreModelCopyWithImpl(this._self, this._then);

  final LifeAreaScoreModel _self;
  final $Res Function(LifeAreaScoreModel) _then;

  /// Create a copy of LifeAreaScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? scoredAt = null,
    Object? health = null,
    Object? work = null,
    Object? finance = null,
    Object? relationships = null,
    Object? personalGrowth = null,
    Object? learning = null,
    Object? recreation = null,
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
      scoredAt: null == scoredAt
          ? _self.scoredAt
          : scoredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      health: null == health
          ? _self.health
          : health // ignore: cast_nullable_to_non_nullable
              as int,
      work: null == work
          ? _self.work
          : work // ignore: cast_nullable_to_non_nullable
              as int,
      finance: null == finance
          ? _self.finance
          : finance // ignore: cast_nullable_to_non_nullable
              as int,
      relationships: null == relationships
          ? _self.relationships
          : relationships // ignore: cast_nullable_to_non_nullable
              as int,
      personalGrowth: null == personalGrowth
          ? _self.personalGrowth
          : personalGrowth // ignore: cast_nullable_to_non_nullable
              as int,
      learning: null == learning
          ? _self.learning
          : learning // ignore: cast_nullable_to_non_nullable
              as int,
      recreation: null == recreation
          ? _self.recreation
          : recreation // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [LifeAreaScoreModel].
extension LifeAreaScoreModelPatterns on LifeAreaScoreModel {
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
    TResult Function(_LifeAreaScoreModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LifeAreaScoreModel() when $default != null:
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
    TResult Function(_LifeAreaScoreModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LifeAreaScoreModel():
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
    TResult? Function(_LifeAreaScoreModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LifeAreaScoreModel() when $default != null:
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
            DateTime scoredAt,
            int health,
            int work,
            int finance,
            int relationships,
            int personalGrowth,
            int learning,
            int recreation,
            DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LifeAreaScoreModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.scoredAt,
            _that.health,
            _that.work,
            _that.finance,
            _that.relationships,
            _that.personalGrowth,
            _that.learning,
            _that.recreation,
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
            DateTime scoredAt,
            int health,
            int work,
            int finance,
            int relationships,
            int personalGrowth,
            int learning,
            int recreation,
            DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LifeAreaScoreModel():
        return $default(
            _that.id,
            _that.userId,
            _that.scoredAt,
            _that.health,
            _that.work,
            _that.finance,
            _that.relationships,
            _that.personalGrowth,
            _that.learning,
            _that.recreation,
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
            DateTime scoredAt,
            int health,
            int work,
            int finance,
            int relationships,
            int personalGrowth,
            int learning,
            int recreation,
            DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LifeAreaScoreModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.scoredAt,
            _that.health,
            _that.work,
            _that.finance,
            _that.relationships,
            _that.personalGrowth,
            _that.learning,
            _that.recreation,
            _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LifeAreaScoreModel implements LifeAreaScoreModel {
  const _LifeAreaScoreModel(
      {required this.id,
      required this.userId,
      required this.scoredAt,
      required this.health,
      required this.work,
      required this.finance,
      required this.relationships,
      required this.personalGrowth,
      required this.learning,
      required this.recreation,
      required this.createdAt});
  factory _LifeAreaScoreModel.fromJson(Map<String, dynamic> json) =>
      _$LifeAreaScoreModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime scoredAt;
  @override
  final int health;
  @override
  final int work;
  @override
  final int finance;
  @override
  final int relationships;
  @override
  final int personalGrowth;
  @override
  final int learning;
  @override
  final int recreation;
  @override
  final DateTime createdAt;

  /// Create a copy of LifeAreaScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LifeAreaScoreModelCopyWith<_LifeAreaScoreModel> get copyWith =>
      __$LifeAreaScoreModelCopyWithImpl<_LifeAreaScoreModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LifeAreaScoreModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LifeAreaScoreModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.scoredAt, scoredAt) ||
                other.scoredAt == scoredAt) &&
            (identical(other.health, health) || other.health == health) &&
            (identical(other.work, work) || other.work == work) &&
            (identical(other.finance, finance) || other.finance == finance) &&
            (identical(other.relationships, relationships) ||
                other.relationships == relationships) &&
            (identical(other.personalGrowth, personalGrowth) ||
                other.personalGrowth == personalGrowth) &&
            (identical(other.learning, learning) ||
                other.learning == learning) &&
            (identical(other.recreation, recreation) ||
                other.recreation == recreation) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      scoredAt,
      health,
      work,
      finance,
      relationships,
      personalGrowth,
      learning,
      recreation,
      createdAt);

  @override
  String toString() {
    return 'LifeAreaScoreModel(id: $id, userId: $userId, scoredAt: $scoredAt, health: $health, work: $work, finance: $finance, relationships: $relationships, personalGrowth: $personalGrowth, learning: $learning, recreation: $recreation, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$LifeAreaScoreModelCopyWith<$Res>
    implements $LifeAreaScoreModelCopyWith<$Res> {
  factory _$LifeAreaScoreModelCopyWith(
          _LifeAreaScoreModel value, $Res Function(_LifeAreaScoreModel) _then) =
      __$LifeAreaScoreModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime scoredAt,
      int health,
      int work,
      int finance,
      int relationships,
      int personalGrowth,
      int learning,
      int recreation,
      DateTime createdAt});
}

/// @nodoc
class __$LifeAreaScoreModelCopyWithImpl<$Res>
    implements _$LifeAreaScoreModelCopyWith<$Res> {
  __$LifeAreaScoreModelCopyWithImpl(this._self, this._then);

  final _LifeAreaScoreModel _self;
  final $Res Function(_LifeAreaScoreModel) _then;

  /// Create a copy of LifeAreaScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? scoredAt = null,
    Object? health = null,
    Object? work = null,
    Object? finance = null,
    Object? relationships = null,
    Object? personalGrowth = null,
    Object? learning = null,
    Object? recreation = null,
    Object? createdAt = null,
  }) {
    return _then(_LifeAreaScoreModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      scoredAt: null == scoredAt
          ? _self.scoredAt
          : scoredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      health: null == health
          ? _self.health
          : health // ignore: cast_nullable_to_non_nullable
              as int,
      work: null == work
          ? _self.work
          : work // ignore: cast_nullable_to_non_nullable
              as int,
      finance: null == finance
          ? _self.finance
          : finance // ignore: cast_nullable_to_non_nullable
              as int,
      relationships: null == relationships
          ? _self.relationships
          : relationships // ignore: cast_nullable_to_non_nullable
              as int,
      personalGrowth: null == personalGrowth
          ? _self.personalGrowth
          : personalGrowth // ignore: cast_nullable_to_non_nullable
              as int,
      learning: null == learning
          ? _self.learning
          : learning // ignore: cast_nullable_to_non_nullable
              as int,
      recreation: null == recreation
          ? _self.recreation
          : recreation // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
