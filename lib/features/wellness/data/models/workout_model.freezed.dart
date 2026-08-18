// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutSetModel {
  String get id;
  String get workoutId;
  String get exerciseName;
  int get setNumber;
  int? get reps;
  double? get weightKg;
  int? get durationSec;
  String? get note;

  /// Create a copy of WorkoutSetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkoutSetModelCopyWith<WorkoutSetModel> get copyWith =>
      _$WorkoutSetModelCopyWithImpl<WorkoutSetModel>(
          this as WorkoutSetModel, _$identity);

  /// Serializes this WorkoutSetModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkoutSetModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workoutId, workoutId) ||
                other.workoutId == workoutId) &&
            (identical(other.exerciseName, exerciseName) ||
                other.exerciseName == exerciseName) &&
            (identical(other.setNumber, setNumber) ||
                other.setNumber == setNumber) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.weightKg, weightKg) ||
                other.weightKg == weightKg) &&
            (identical(other.durationSec, durationSec) ||
                other.durationSec == durationSec) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, workoutId, exerciseName,
      setNumber, reps, weightKg, durationSec, note);

  @override
  String toString() {
    return 'WorkoutSetModel(id: $id, workoutId: $workoutId, exerciseName: $exerciseName, setNumber: $setNumber, reps: $reps, weightKg: $weightKg, durationSec: $durationSec, note: $note)';
  }
}

/// @nodoc
abstract mixin class $WorkoutSetModelCopyWith<$Res> {
  factory $WorkoutSetModelCopyWith(
          WorkoutSetModel value, $Res Function(WorkoutSetModel) _then) =
      _$WorkoutSetModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String workoutId,
      String exerciseName,
      int setNumber,
      int? reps,
      double? weightKg,
      int? durationSec,
      String? note});
}

/// @nodoc
class _$WorkoutSetModelCopyWithImpl<$Res>
    implements $WorkoutSetModelCopyWith<$Res> {
  _$WorkoutSetModelCopyWithImpl(this._self, this._then);

  final WorkoutSetModel _self;
  final $Res Function(WorkoutSetModel) _then;

  /// Create a copy of WorkoutSetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workoutId = null,
    Object? exerciseName = null,
    Object? setNumber = null,
    Object? reps = freezed,
    Object? weightKg = freezed,
    Object? durationSec = freezed,
    Object? note = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      workoutId: null == workoutId
          ? _self.workoutId
          : workoutId // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseName: null == exerciseName
          ? _self.exerciseName
          : exerciseName // ignore: cast_nullable_to_non_nullable
              as String,
      setNumber: null == setNumber
          ? _self.setNumber
          : setNumber // ignore: cast_nullable_to_non_nullable
              as int,
      reps: freezed == reps
          ? _self.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as int?,
      weightKg: freezed == weightKg
          ? _self.weightKg
          : weightKg // ignore: cast_nullable_to_non_nullable
              as double?,
      durationSec: freezed == durationSec
          ? _self.durationSec
          : durationSec // ignore: cast_nullable_to_non_nullable
              as int?,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [WorkoutSetModel].
extension WorkoutSetModelPatterns on WorkoutSetModel {
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
    TResult Function(_WorkoutSetModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutSetModel() when $default != null:
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
    TResult Function(_WorkoutSetModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutSetModel():
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
    TResult? Function(_WorkoutSetModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutSetModel() when $default != null:
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
            String workoutId,
            String exerciseName,
            int setNumber,
            int? reps,
            double? weightKg,
            int? durationSec,
            String? note)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutSetModel() when $default != null:
        return $default(
            _that.id,
            _that.workoutId,
            _that.exerciseName,
            _that.setNumber,
            _that.reps,
            _that.weightKg,
            _that.durationSec,
            _that.note);
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
            String workoutId,
            String exerciseName,
            int setNumber,
            int? reps,
            double? weightKg,
            int? durationSec,
            String? note)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutSetModel():
        return $default(
            _that.id,
            _that.workoutId,
            _that.exerciseName,
            _that.setNumber,
            _that.reps,
            _that.weightKg,
            _that.durationSec,
            _that.note);
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
            String workoutId,
            String exerciseName,
            int setNumber,
            int? reps,
            double? weightKg,
            int? durationSec,
            String? note)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutSetModel() when $default != null:
        return $default(
            _that.id,
            _that.workoutId,
            _that.exerciseName,
            _that.setNumber,
            _that.reps,
            _that.weightKg,
            _that.durationSec,
            _that.note);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WorkoutSetModel implements WorkoutSetModel {
  const _WorkoutSetModel(
      {required this.id,
      required this.workoutId,
      required this.exerciseName,
      required this.setNumber,
      this.reps,
      this.weightKg,
      this.durationSec,
      this.note});
  factory _WorkoutSetModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSetModelFromJson(json);

  @override
  final String id;
  @override
  final String workoutId;
  @override
  final String exerciseName;
  @override
  final int setNumber;
  @override
  final int? reps;
  @override
  final double? weightKg;
  @override
  final int? durationSec;
  @override
  final String? note;

  /// Create a copy of WorkoutSetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkoutSetModelCopyWith<_WorkoutSetModel> get copyWith =>
      __$WorkoutSetModelCopyWithImpl<_WorkoutSetModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkoutSetModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkoutSetModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workoutId, workoutId) ||
                other.workoutId == workoutId) &&
            (identical(other.exerciseName, exerciseName) ||
                other.exerciseName == exerciseName) &&
            (identical(other.setNumber, setNumber) ||
                other.setNumber == setNumber) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.weightKg, weightKg) ||
                other.weightKg == weightKg) &&
            (identical(other.durationSec, durationSec) ||
                other.durationSec == durationSec) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, workoutId, exerciseName,
      setNumber, reps, weightKg, durationSec, note);

  @override
  String toString() {
    return 'WorkoutSetModel(id: $id, workoutId: $workoutId, exerciseName: $exerciseName, setNumber: $setNumber, reps: $reps, weightKg: $weightKg, durationSec: $durationSec, note: $note)';
  }
}

/// @nodoc
abstract mixin class _$WorkoutSetModelCopyWith<$Res>
    implements $WorkoutSetModelCopyWith<$Res> {
  factory _$WorkoutSetModelCopyWith(
          _WorkoutSetModel value, $Res Function(_WorkoutSetModel) _then) =
      __$WorkoutSetModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String workoutId,
      String exerciseName,
      int setNumber,
      int? reps,
      double? weightKg,
      int? durationSec,
      String? note});
}

/// @nodoc
class __$WorkoutSetModelCopyWithImpl<$Res>
    implements _$WorkoutSetModelCopyWith<$Res> {
  __$WorkoutSetModelCopyWithImpl(this._self, this._then);

  final _WorkoutSetModel _self;
  final $Res Function(_WorkoutSetModel) _then;

  /// Create a copy of WorkoutSetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? workoutId = null,
    Object? exerciseName = null,
    Object? setNumber = null,
    Object? reps = freezed,
    Object? weightKg = freezed,
    Object? durationSec = freezed,
    Object? note = freezed,
  }) {
    return _then(_WorkoutSetModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      workoutId: null == workoutId
          ? _self.workoutId
          : workoutId // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseName: null == exerciseName
          ? _self.exerciseName
          : exerciseName // ignore: cast_nullable_to_non_nullable
              as String,
      setNumber: null == setNumber
          ? _self.setNumber
          : setNumber // ignore: cast_nullable_to_non_nullable
              as int,
      reps: freezed == reps
          ? _self.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as int?,
      weightKg: freezed == weightKg
          ? _self.weightKg
          : weightKg // ignore: cast_nullable_to_non_nullable
              as double?,
      durationSec: freezed == durationSec
          ? _self.durationSec
          : durationSec // ignore: cast_nullable_to_non_nullable
              as int?,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$WorkoutLogModel {
  String get id;
  String get userId;
  String get workoutType;
  String? get name;
  DateTime get startedAt;
  DateTime? get endedAt;
  int? get durationMin;
  double? get distanceM;
  int? get calories;
  int? get avgHeartRate;
  String get source;
  String? get note;
  DateTime get createdAt;
  DateTime get updatedAt;
  int get syncStatus;
  List<WorkoutSetModel> get sets;

  /// Create a copy of WorkoutLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkoutLogModelCopyWith<WorkoutLogModel> get copyWith =>
      _$WorkoutLogModelCopyWithImpl<WorkoutLogModel>(
          this as WorkoutLogModel, _$identity);

  /// Serializes this WorkoutLogModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkoutLogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.workoutType, workoutType) ||
                other.workoutType == workoutType) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.durationMin, durationMin) ||
                other.durationMin == durationMin) &&
            (identical(other.distanceM, distanceM) ||
                other.distanceM == distanceM) &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.avgHeartRate, avgHeartRate) ||
                other.avgHeartRate == avgHeartRate) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus) &&
            const DeepCollectionEquality().equals(other.sets, sets));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      workoutType,
      name,
      startedAt,
      endedAt,
      durationMin,
      distanceM,
      calories,
      avgHeartRate,
      source,
      note,
      createdAt,
      updatedAt,
      syncStatus,
      const DeepCollectionEquality().hash(sets));

  @override
  String toString() {
    return 'WorkoutLogModel(id: $id, userId: $userId, workoutType: $workoutType, name: $name, startedAt: $startedAt, endedAt: $endedAt, durationMin: $durationMin, distanceM: $distanceM, calories: $calories, avgHeartRate: $avgHeartRate, source: $source, note: $note, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, sets: $sets)';
  }
}

/// @nodoc
abstract mixin class $WorkoutLogModelCopyWith<$Res> {
  factory $WorkoutLogModelCopyWith(
          WorkoutLogModel value, $Res Function(WorkoutLogModel) _then) =
      _$WorkoutLogModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String workoutType,
      String? name,
      DateTime startedAt,
      DateTime? endedAt,
      int? durationMin,
      double? distanceM,
      int? calories,
      int? avgHeartRate,
      String source,
      String? note,
      DateTime createdAt,
      DateTime updatedAt,
      int syncStatus,
      List<WorkoutSetModel> sets});
}

/// @nodoc
class _$WorkoutLogModelCopyWithImpl<$Res>
    implements $WorkoutLogModelCopyWith<$Res> {
  _$WorkoutLogModelCopyWithImpl(this._self, this._then);

  final WorkoutLogModel _self;
  final $Res Function(WorkoutLogModel) _then;

  /// Create a copy of WorkoutLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? workoutType = null,
    Object? name = freezed,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? durationMin = freezed,
    Object? distanceM = freezed,
    Object? calories = freezed,
    Object? avgHeartRate = freezed,
    Object? source = null,
    Object? note = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncStatus = null,
    Object? sets = null,
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
      workoutType: null == workoutType
          ? _self.workoutType
          : workoutType // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      startedAt: null == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endedAt: freezed == endedAt
          ? _self.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      durationMin: freezed == durationMin
          ? _self.durationMin
          : durationMin // ignore: cast_nullable_to_non_nullable
              as int?,
      distanceM: freezed == distanceM
          ? _self.distanceM
          : distanceM // ignore: cast_nullable_to_non_nullable
              as double?,
      calories: freezed == calories
          ? _self.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int?,
      avgHeartRate: freezed == avgHeartRate
          ? _self.avgHeartRate
          : avgHeartRate // ignore: cast_nullable_to_non_nullable
              as int?,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
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
      sets: null == sets
          ? _self.sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSetModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [WorkoutLogModel].
extension WorkoutLogModelPatterns on WorkoutLogModel {
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
    TResult Function(_WorkoutLogModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutLogModel() when $default != null:
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
    TResult Function(_WorkoutLogModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutLogModel():
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
    TResult? Function(_WorkoutLogModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutLogModel() when $default != null:
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
            String workoutType,
            String? name,
            DateTime startedAt,
            DateTime? endedAt,
            int? durationMin,
            double? distanceM,
            int? calories,
            int? avgHeartRate,
            String source,
            String? note,
            DateTime createdAt,
            DateTime updatedAt,
            int syncStatus,
            List<WorkoutSetModel> sets)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutLogModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.workoutType,
            _that.name,
            _that.startedAt,
            _that.endedAt,
            _that.durationMin,
            _that.distanceM,
            _that.calories,
            _that.avgHeartRate,
            _that.source,
            _that.note,
            _that.createdAt,
            _that.updatedAt,
            _that.syncStatus,
            _that.sets);
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
            String workoutType,
            String? name,
            DateTime startedAt,
            DateTime? endedAt,
            int? durationMin,
            double? distanceM,
            int? calories,
            int? avgHeartRate,
            String source,
            String? note,
            DateTime createdAt,
            DateTime updatedAt,
            int syncStatus,
            List<WorkoutSetModel> sets)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutLogModel():
        return $default(
            _that.id,
            _that.userId,
            _that.workoutType,
            _that.name,
            _that.startedAt,
            _that.endedAt,
            _that.durationMin,
            _that.distanceM,
            _that.calories,
            _that.avgHeartRate,
            _that.source,
            _that.note,
            _that.createdAt,
            _that.updatedAt,
            _that.syncStatus,
            _that.sets);
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
            String workoutType,
            String? name,
            DateTime startedAt,
            DateTime? endedAt,
            int? durationMin,
            double? distanceM,
            int? calories,
            int? avgHeartRate,
            String source,
            String? note,
            DateTime createdAt,
            DateTime updatedAt,
            int syncStatus,
            List<WorkoutSetModel> sets)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutLogModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.workoutType,
            _that.name,
            _that.startedAt,
            _that.endedAt,
            _that.durationMin,
            _that.distanceM,
            _that.calories,
            _that.avgHeartRate,
            _that.source,
            _that.note,
            _that.createdAt,
            _that.updatedAt,
            _that.syncStatus,
            _that.sets);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WorkoutLogModel implements WorkoutLogModel {
  const _WorkoutLogModel(
      {required this.id,
      required this.userId,
      required this.workoutType,
      this.name,
      required this.startedAt,
      this.endedAt,
      this.durationMin,
      this.distanceM,
      this.calories,
      this.avgHeartRate,
      this.source = 'manual',
      this.note,
      required this.createdAt,
      required this.updatedAt,
      this.syncStatus = 0,
      final List<WorkoutSetModel> sets = const []})
      : _sets = sets;
  factory _WorkoutLogModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutLogModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String workoutType;
  @override
  final String? name;
  @override
  final DateTime startedAt;
  @override
  final DateTime? endedAt;
  @override
  final int? durationMin;
  @override
  final double? distanceM;
  @override
  final int? calories;
  @override
  final int? avgHeartRate;
  @override
  @JsonKey()
  final String source;
  @override
  final String? note;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final int syncStatus;
  final List<WorkoutSetModel> _sets;
  @override
  @JsonKey()
  List<WorkoutSetModel> get sets {
    if (_sets is EqualUnmodifiableListView) return _sets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sets);
  }

  /// Create a copy of WorkoutLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkoutLogModelCopyWith<_WorkoutLogModel> get copyWith =>
      __$WorkoutLogModelCopyWithImpl<_WorkoutLogModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkoutLogModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkoutLogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.workoutType, workoutType) ||
                other.workoutType == workoutType) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.durationMin, durationMin) ||
                other.durationMin == durationMin) &&
            (identical(other.distanceM, distanceM) ||
                other.distanceM == distanceM) &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.avgHeartRate, avgHeartRate) ||
                other.avgHeartRate == avgHeartRate) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus) &&
            const DeepCollectionEquality().equals(other._sets, _sets));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      workoutType,
      name,
      startedAt,
      endedAt,
      durationMin,
      distanceM,
      calories,
      avgHeartRate,
      source,
      note,
      createdAt,
      updatedAt,
      syncStatus,
      const DeepCollectionEquality().hash(_sets));

  @override
  String toString() {
    return 'WorkoutLogModel(id: $id, userId: $userId, workoutType: $workoutType, name: $name, startedAt: $startedAt, endedAt: $endedAt, durationMin: $durationMin, distanceM: $distanceM, calories: $calories, avgHeartRate: $avgHeartRate, source: $source, note: $note, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, sets: $sets)';
  }
}

/// @nodoc
abstract mixin class _$WorkoutLogModelCopyWith<$Res>
    implements $WorkoutLogModelCopyWith<$Res> {
  factory _$WorkoutLogModelCopyWith(
          _WorkoutLogModel value, $Res Function(_WorkoutLogModel) _then) =
      __$WorkoutLogModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String workoutType,
      String? name,
      DateTime startedAt,
      DateTime? endedAt,
      int? durationMin,
      double? distanceM,
      int? calories,
      int? avgHeartRate,
      String source,
      String? note,
      DateTime createdAt,
      DateTime updatedAt,
      int syncStatus,
      List<WorkoutSetModel> sets});
}

/// @nodoc
class __$WorkoutLogModelCopyWithImpl<$Res>
    implements _$WorkoutLogModelCopyWith<$Res> {
  __$WorkoutLogModelCopyWithImpl(this._self, this._then);

  final _WorkoutLogModel _self;
  final $Res Function(_WorkoutLogModel) _then;

  /// Create a copy of WorkoutLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? workoutType = null,
    Object? name = freezed,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? durationMin = freezed,
    Object? distanceM = freezed,
    Object? calories = freezed,
    Object? avgHeartRate = freezed,
    Object? source = null,
    Object? note = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncStatus = null,
    Object? sets = null,
  }) {
    return _then(_WorkoutLogModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      workoutType: null == workoutType
          ? _self.workoutType
          : workoutType // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      startedAt: null == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endedAt: freezed == endedAt
          ? _self.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      durationMin: freezed == durationMin
          ? _self.durationMin
          : durationMin // ignore: cast_nullable_to_non_nullable
              as int?,
      distanceM: freezed == distanceM
          ? _self.distanceM
          : distanceM // ignore: cast_nullable_to_non_nullable
              as double?,
      calories: freezed == calories
          ? _self.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int?,
      avgHeartRate: freezed == avgHeartRate
          ? _self.avgHeartRate
          : avgHeartRate // ignore: cast_nullable_to_non_nullable
              as int?,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
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
      sets: null == sets
          ? _self._sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSetModel>,
    ));
  }
}

// dart format on
