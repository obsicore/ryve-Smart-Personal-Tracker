// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeeklyReportModel {
  String get id;
  String get userId;
  DateTime get weekStart;
  DateTime get weekEnd;
  int get habitsCompleted;
  int get habitsTotal;
  int get tasksCompleted;
  int get focusMinutes;
  double get avgMood;
  double get avgSleepHours;
  int get xpEarned;
  String? get aiSummary;
  String? get aiWins;
  String? get aiSuggestions;
  DateTime get generatedAt;
  DateTime get createdAt;

  /// Create a copy of WeeklyReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WeeklyReportModelCopyWith<WeeklyReportModel> get copyWith =>
      _$WeeklyReportModelCopyWithImpl<WeeklyReportModel>(
          this as WeeklyReportModel, _$identity);

  /// Serializes this WeeklyReportModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WeeklyReportModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.weekStart, weekStart) ||
                other.weekStart == weekStart) &&
            (identical(other.weekEnd, weekEnd) || other.weekEnd == weekEnd) &&
            (identical(other.habitsCompleted, habitsCompleted) ||
                other.habitsCompleted == habitsCompleted) &&
            (identical(other.habitsTotal, habitsTotal) ||
                other.habitsTotal == habitsTotal) &&
            (identical(other.tasksCompleted, tasksCompleted) ||
                other.tasksCompleted == tasksCompleted) &&
            (identical(other.focusMinutes, focusMinutes) ||
                other.focusMinutes == focusMinutes) &&
            (identical(other.avgMood, avgMood) || other.avgMood == avgMood) &&
            (identical(other.avgSleepHours, avgSleepHours) ||
                other.avgSleepHours == avgSleepHours) &&
            (identical(other.xpEarned, xpEarned) ||
                other.xpEarned == xpEarned) &&
            (identical(other.aiSummary, aiSummary) ||
                other.aiSummary == aiSummary) &&
            (identical(other.aiWins, aiWins) || other.aiWins == aiWins) &&
            (identical(other.aiSuggestions, aiSuggestions) ||
                other.aiSuggestions == aiSuggestions) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      weekStart,
      weekEnd,
      habitsCompleted,
      habitsTotal,
      tasksCompleted,
      focusMinutes,
      avgMood,
      avgSleepHours,
      xpEarned,
      aiSummary,
      aiWins,
      aiSuggestions,
      generatedAt,
      createdAt);

  @override
  String toString() {
    return 'WeeklyReportModel(id: $id, userId: $userId, weekStart: $weekStart, weekEnd: $weekEnd, habitsCompleted: $habitsCompleted, habitsTotal: $habitsTotal, tasksCompleted: $tasksCompleted, focusMinutes: $focusMinutes, avgMood: $avgMood, avgSleepHours: $avgSleepHours, xpEarned: $xpEarned, aiSummary: $aiSummary, aiWins: $aiWins, aiSuggestions: $aiSuggestions, generatedAt: $generatedAt, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $WeeklyReportModelCopyWith<$Res> {
  factory $WeeklyReportModelCopyWith(
          WeeklyReportModel value, $Res Function(WeeklyReportModel) _then) =
      _$WeeklyReportModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime weekStart,
      DateTime weekEnd,
      int habitsCompleted,
      int habitsTotal,
      int tasksCompleted,
      int focusMinutes,
      double avgMood,
      double avgSleepHours,
      int xpEarned,
      String? aiSummary,
      String? aiWins,
      String? aiSuggestions,
      DateTime generatedAt,
      DateTime createdAt});
}

/// @nodoc
class _$WeeklyReportModelCopyWithImpl<$Res>
    implements $WeeklyReportModelCopyWith<$Res> {
  _$WeeklyReportModelCopyWithImpl(this._self, this._then);

  final WeeklyReportModel _self;
  final $Res Function(WeeklyReportModel) _then;

  /// Create a copy of WeeklyReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? weekStart = null,
    Object? weekEnd = null,
    Object? habitsCompleted = null,
    Object? habitsTotal = null,
    Object? tasksCompleted = null,
    Object? focusMinutes = null,
    Object? avgMood = null,
    Object? avgSleepHours = null,
    Object? xpEarned = null,
    Object? aiSummary = freezed,
    Object? aiWins = freezed,
    Object? aiSuggestions = freezed,
    Object? generatedAt = null,
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
      weekStart: null == weekStart
          ? _self.weekStart
          : weekStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weekEnd: null == weekEnd
          ? _self.weekEnd
          : weekEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      habitsCompleted: null == habitsCompleted
          ? _self.habitsCompleted
          : habitsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      habitsTotal: null == habitsTotal
          ? _self.habitsTotal
          : habitsTotal // ignore: cast_nullable_to_non_nullable
              as int,
      tasksCompleted: null == tasksCompleted
          ? _self.tasksCompleted
          : tasksCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      focusMinutes: null == focusMinutes
          ? _self.focusMinutes
          : focusMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      avgMood: null == avgMood
          ? _self.avgMood
          : avgMood // ignore: cast_nullable_to_non_nullable
              as double,
      avgSleepHours: null == avgSleepHours
          ? _self.avgSleepHours
          : avgSleepHours // ignore: cast_nullable_to_non_nullable
              as double,
      xpEarned: null == xpEarned
          ? _self.xpEarned
          : xpEarned // ignore: cast_nullable_to_non_nullable
              as int,
      aiSummary: freezed == aiSummary
          ? _self.aiSummary
          : aiSummary // ignore: cast_nullable_to_non_nullable
              as String?,
      aiWins: freezed == aiWins
          ? _self.aiWins
          : aiWins // ignore: cast_nullable_to_non_nullable
              as String?,
      aiSuggestions: freezed == aiSuggestions
          ? _self.aiSuggestions
          : aiSuggestions // ignore: cast_nullable_to_non_nullable
              as String?,
      generatedAt: null == generatedAt
          ? _self.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [WeeklyReportModel].
extension WeeklyReportModelPatterns on WeeklyReportModel {
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
    TResult Function(_WeeklyReportModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WeeklyReportModel() when $default != null:
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
    TResult Function(_WeeklyReportModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WeeklyReportModel():
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
    TResult? Function(_WeeklyReportModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WeeklyReportModel() when $default != null:
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
            DateTime weekStart,
            DateTime weekEnd,
            int habitsCompleted,
            int habitsTotal,
            int tasksCompleted,
            int focusMinutes,
            double avgMood,
            double avgSleepHours,
            int xpEarned,
            String? aiSummary,
            String? aiWins,
            String? aiSuggestions,
            DateTime generatedAt,
            DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WeeklyReportModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.weekStart,
            _that.weekEnd,
            _that.habitsCompleted,
            _that.habitsTotal,
            _that.tasksCompleted,
            _that.focusMinutes,
            _that.avgMood,
            _that.avgSleepHours,
            _that.xpEarned,
            _that.aiSummary,
            _that.aiWins,
            _that.aiSuggestions,
            _that.generatedAt,
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
            DateTime weekStart,
            DateTime weekEnd,
            int habitsCompleted,
            int habitsTotal,
            int tasksCompleted,
            int focusMinutes,
            double avgMood,
            double avgSleepHours,
            int xpEarned,
            String? aiSummary,
            String? aiWins,
            String? aiSuggestions,
            DateTime generatedAt,
            DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WeeklyReportModel():
        return $default(
            _that.id,
            _that.userId,
            _that.weekStart,
            _that.weekEnd,
            _that.habitsCompleted,
            _that.habitsTotal,
            _that.tasksCompleted,
            _that.focusMinutes,
            _that.avgMood,
            _that.avgSleepHours,
            _that.xpEarned,
            _that.aiSummary,
            _that.aiWins,
            _that.aiSuggestions,
            _that.generatedAt,
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
            DateTime weekStart,
            DateTime weekEnd,
            int habitsCompleted,
            int habitsTotal,
            int tasksCompleted,
            int focusMinutes,
            double avgMood,
            double avgSleepHours,
            int xpEarned,
            String? aiSummary,
            String? aiWins,
            String? aiSuggestions,
            DateTime generatedAt,
            DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WeeklyReportModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.weekStart,
            _that.weekEnd,
            _that.habitsCompleted,
            _that.habitsTotal,
            _that.tasksCompleted,
            _that.focusMinutes,
            _that.avgMood,
            _that.avgSleepHours,
            _that.xpEarned,
            _that.aiSummary,
            _that.aiWins,
            _that.aiSuggestions,
            _that.generatedAt,
            _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WeeklyReportModel implements WeeklyReportModel {
  const _WeeklyReportModel(
      {required this.id,
      required this.userId,
      required this.weekStart,
      required this.weekEnd,
      this.habitsCompleted = 0,
      this.habitsTotal = 0,
      this.tasksCompleted = 0,
      this.focusMinutes = 0,
      this.avgMood = 0,
      this.avgSleepHours = 0,
      this.xpEarned = 0,
      this.aiSummary,
      this.aiWins,
      this.aiSuggestions,
      required this.generatedAt,
      required this.createdAt});
  factory _WeeklyReportModel.fromJson(Map<String, dynamic> json) =>
      _$WeeklyReportModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime weekStart;
  @override
  final DateTime weekEnd;
  @override
  @JsonKey()
  final int habitsCompleted;
  @override
  @JsonKey()
  final int habitsTotal;
  @override
  @JsonKey()
  final int tasksCompleted;
  @override
  @JsonKey()
  final int focusMinutes;
  @override
  @JsonKey()
  final double avgMood;
  @override
  @JsonKey()
  final double avgSleepHours;
  @override
  @JsonKey()
  final int xpEarned;
  @override
  final String? aiSummary;
  @override
  final String? aiWins;
  @override
  final String? aiSuggestions;
  @override
  final DateTime generatedAt;
  @override
  final DateTime createdAt;

  /// Create a copy of WeeklyReportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WeeklyReportModelCopyWith<_WeeklyReportModel> get copyWith =>
      __$WeeklyReportModelCopyWithImpl<_WeeklyReportModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WeeklyReportModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WeeklyReportModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.weekStart, weekStart) ||
                other.weekStart == weekStart) &&
            (identical(other.weekEnd, weekEnd) || other.weekEnd == weekEnd) &&
            (identical(other.habitsCompleted, habitsCompleted) ||
                other.habitsCompleted == habitsCompleted) &&
            (identical(other.habitsTotal, habitsTotal) ||
                other.habitsTotal == habitsTotal) &&
            (identical(other.tasksCompleted, tasksCompleted) ||
                other.tasksCompleted == tasksCompleted) &&
            (identical(other.focusMinutes, focusMinutes) ||
                other.focusMinutes == focusMinutes) &&
            (identical(other.avgMood, avgMood) || other.avgMood == avgMood) &&
            (identical(other.avgSleepHours, avgSleepHours) ||
                other.avgSleepHours == avgSleepHours) &&
            (identical(other.xpEarned, xpEarned) ||
                other.xpEarned == xpEarned) &&
            (identical(other.aiSummary, aiSummary) ||
                other.aiSummary == aiSummary) &&
            (identical(other.aiWins, aiWins) || other.aiWins == aiWins) &&
            (identical(other.aiSuggestions, aiSuggestions) ||
                other.aiSuggestions == aiSuggestions) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      weekStart,
      weekEnd,
      habitsCompleted,
      habitsTotal,
      tasksCompleted,
      focusMinutes,
      avgMood,
      avgSleepHours,
      xpEarned,
      aiSummary,
      aiWins,
      aiSuggestions,
      generatedAt,
      createdAt);

  @override
  String toString() {
    return 'WeeklyReportModel(id: $id, userId: $userId, weekStart: $weekStart, weekEnd: $weekEnd, habitsCompleted: $habitsCompleted, habitsTotal: $habitsTotal, tasksCompleted: $tasksCompleted, focusMinutes: $focusMinutes, avgMood: $avgMood, avgSleepHours: $avgSleepHours, xpEarned: $xpEarned, aiSummary: $aiSummary, aiWins: $aiWins, aiSuggestions: $aiSuggestions, generatedAt: $generatedAt, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$WeeklyReportModelCopyWith<$Res>
    implements $WeeklyReportModelCopyWith<$Res> {
  factory _$WeeklyReportModelCopyWith(
          _WeeklyReportModel value, $Res Function(_WeeklyReportModel) _then) =
      __$WeeklyReportModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime weekStart,
      DateTime weekEnd,
      int habitsCompleted,
      int habitsTotal,
      int tasksCompleted,
      int focusMinutes,
      double avgMood,
      double avgSleepHours,
      int xpEarned,
      String? aiSummary,
      String? aiWins,
      String? aiSuggestions,
      DateTime generatedAt,
      DateTime createdAt});
}

/// @nodoc
class __$WeeklyReportModelCopyWithImpl<$Res>
    implements _$WeeklyReportModelCopyWith<$Res> {
  __$WeeklyReportModelCopyWithImpl(this._self, this._then);

  final _WeeklyReportModel _self;
  final $Res Function(_WeeklyReportModel) _then;

  /// Create a copy of WeeklyReportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? weekStart = null,
    Object? weekEnd = null,
    Object? habitsCompleted = null,
    Object? habitsTotal = null,
    Object? tasksCompleted = null,
    Object? focusMinutes = null,
    Object? avgMood = null,
    Object? avgSleepHours = null,
    Object? xpEarned = null,
    Object? aiSummary = freezed,
    Object? aiWins = freezed,
    Object? aiSuggestions = freezed,
    Object? generatedAt = null,
    Object? createdAt = null,
  }) {
    return _then(_WeeklyReportModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      weekStart: null == weekStart
          ? _self.weekStart
          : weekStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weekEnd: null == weekEnd
          ? _self.weekEnd
          : weekEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      habitsCompleted: null == habitsCompleted
          ? _self.habitsCompleted
          : habitsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      habitsTotal: null == habitsTotal
          ? _self.habitsTotal
          : habitsTotal // ignore: cast_nullable_to_non_nullable
              as int,
      tasksCompleted: null == tasksCompleted
          ? _self.tasksCompleted
          : tasksCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      focusMinutes: null == focusMinutes
          ? _self.focusMinutes
          : focusMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      avgMood: null == avgMood
          ? _self.avgMood
          : avgMood // ignore: cast_nullable_to_non_nullable
              as double,
      avgSleepHours: null == avgSleepHours
          ? _self.avgSleepHours
          : avgSleepHours // ignore: cast_nullable_to_non_nullable
              as double,
      xpEarned: null == xpEarned
          ? _self.xpEarned
          : xpEarned // ignore: cast_nullable_to_non_nullable
              as int,
      aiSummary: freezed == aiSummary
          ? _self.aiSummary
          : aiSummary // ignore: cast_nullable_to_non_nullable
              as String?,
      aiWins: freezed == aiWins
          ? _self.aiWins
          : aiWins // ignore: cast_nullable_to_non_nullable
              as String?,
      aiSuggestions: freezed == aiSuggestions
          ? _self.aiSuggestions
          : aiSuggestions // ignore: cast_nullable_to_non_nullable
              as String?,
      generatedAt: null == generatedAt
          ? _self.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
