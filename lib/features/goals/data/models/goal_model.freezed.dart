// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GoalModel {
  String get id;
  String get userId;
  String get title;
  String? get description;
  String get lifeArea;
  String get metricType;
  double get targetValue;
  double get currentValue;
  String? get unit;
  DateTime? get targetDate;
  int get priority;
  String get status;
  String? get icon;
  String get colorHex;
  String get visibility;
  DateTime? get completedAt;
  DateTime get createdAt;
  DateTime get updatedAt;
  DateTime? get deletedAt;
  int get syncStatus;
  List<MilestoneModel> get milestones;
  List<String> get linkedHabitIds;
  List<String> get linkedTaskIds;

  /// Create a copy of GoalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GoalModelCopyWith<GoalModel> get copyWith =>
      _$GoalModelCopyWithImpl<GoalModel>(this as GoalModel, _$identity);

  /// Serializes this GoalModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GoalModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.lifeArea, lifeArea) ||
                other.lifeArea == lifeArea) &&
            (identical(other.metricType, metricType) ||
                other.metricType == metricType) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.currentValue, currentValue) ||
                other.currentValue == currentValue) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.targetDate, targetDate) ||
                other.targetDate == targetDate) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.colorHex, colorHex) ||
                other.colorHex == colorHex) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus) &&
            const DeepCollectionEquality()
                .equals(other.milestones, milestones) &&
            const DeepCollectionEquality()
                .equals(other.linkedHabitIds, linkedHabitIds) &&
            const DeepCollectionEquality()
                .equals(other.linkedTaskIds, linkedTaskIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        title,
        description,
        lifeArea,
        metricType,
        targetValue,
        currentValue,
        unit,
        targetDate,
        priority,
        status,
        icon,
        colorHex,
        visibility,
        completedAt,
        createdAt,
        updatedAt,
        deletedAt,
        syncStatus,
        const DeepCollectionEquality().hash(milestones),
        const DeepCollectionEquality().hash(linkedHabitIds),
        const DeepCollectionEquality().hash(linkedTaskIds)
      ]);

  @override
  String toString() {
    return 'GoalModel(id: $id, userId: $userId, title: $title, description: $description, lifeArea: $lifeArea, metricType: $metricType, targetValue: $targetValue, currentValue: $currentValue, unit: $unit, targetDate: $targetDate, priority: $priority, status: $status, icon: $icon, colorHex: $colorHex, visibility: $visibility, completedAt: $completedAt, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, syncStatus: $syncStatus, milestones: $milestones, linkedHabitIds: $linkedHabitIds, linkedTaskIds: $linkedTaskIds)';
  }
}

/// @nodoc
abstract mixin class $GoalModelCopyWith<$Res> {
  factory $GoalModelCopyWith(GoalModel value, $Res Function(GoalModel) _then) =
      _$GoalModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String? description,
      String lifeArea,
      String metricType,
      double targetValue,
      double currentValue,
      String? unit,
      DateTime? targetDate,
      int priority,
      String status,
      String? icon,
      String colorHex,
      String visibility,
      DateTime? completedAt,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      int syncStatus,
      List<MilestoneModel> milestones,
      List<String> linkedHabitIds,
      List<String> linkedTaskIds});
}

/// @nodoc
class _$GoalModelCopyWithImpl<$Res> implements $GoalModelCopyWith<$Res> {
  _$GoalModelCopyWithImpl(this._self, this._then);

  final GoalModel _self;
  final $Res Function(GoalModel) _then;

  /// Create a copy of GoalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = freezed,
    Object? lifeArea = null,
    Object? metricType = null,
    Object? targetValue = null,
    Object? currentValue = null,
    Object? unit = freezed,
    Object? targetDate = freezed,
    Object? priority = null,
    Object? status = null,
    Object? icon = freezed,
    Object? colorHex = null,
    Object? visibility = null,
    Object? completedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? syncStatus = null,
    Object? milestones = null,
    Object? linkedHabitIds = null,
    Object? linkedTaskIds = null,
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
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      lifeArea: null == lifeArea
          ? _self.lifeArea
          : lifeArea // ignore: cast_nullable_to_non_nullable
              as String,
      metricType: null == metricType
          ? _self.metricType
          : metricType // ignore: cast_nullable_to_non_nullable
              as String,
      targetValue: null == targetValue
          ? _self.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as double,
      currentValue: null == currentValue
          ? _self.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as double,
      unit: freezed == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      targetDate: freezed == targetDate
          ? _self.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      colorHex: null == colorHex
          ? _self.colorHex
          : colorHex // ignore: cast_nullable_to_non_nullable
              as String,
      visibility: null == visibility
          ? _self.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as String,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      syncStatus: null == syncStatus
          ? _self.syncStatus
          : syncStatus // ignore: cast_nullable_to_non_nullable
              as int,
      milestones: null == milestones
          ? _self.milestones
          : milestones // ignore: cast_nullable_to_non_nullable
              as List<MilestoneModel>,
      linkedHabitIds: null == linkedHabitIds
          ? _self.linkedHabitIds
          : linkedHabitIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      linkedTaskIds: null == linkedTaskIds
          ? _self.linkedTaskIds
          : linkedTaskIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [GoalModel].
extension GoalModelPatterns on GoalModel {
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
    TResult Function(_GoalModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GoalModel() when $default != null:
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
    TResult Function(_GoalModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GoalModel():
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
    TResult? Function(_GoalModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GoalModel() when $default != null:
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
            String title,
            String? description,
            String lifeArea,
            String metricType,
            double targetValue,
            double currentValue,
            String? unit,
            DateTime? targetDate,
            int priority,
            String status,
            String? icon,
            String colorHex,
            String visibility,
            DateTime? completedAt,
            DateTime createdAt,
            DateTime updatedAt,
            DateTime? deletedAt,
            int syncStatus,
            List<MilestoneModel> milestones,
            List<String> linkedHabitIds,
            List<String> linkedTaskIds)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GoalModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.title,
            _that.description,
            _that.lifeArea,
            _that.metricType,
            _that.targetValue,
            _that.currentValue,
            _that.unit,
            _that.targetDate,
            _that.priority,
            _that.status,
            _that.icon,
            _that.colorHex,
            _that.visibility,
            _that.completedAt,
            _that.createdAt,
            _that.updatedAt,
            _that.deletedAt,
            _that.syncStatus,
            _that.milestones,
            _that.linkedHabitIds,
            _that.linkedTaskIds);
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
            String title,
            String? description,
            String lifeArea,
            String metricType,
            double targetValue,
            double currentValue,
            String? unit,
            DateTime? targetDate,
            int priority,
            String status,
            String? icon,
            String colorHex,
            String visibility,
            DateTime? completedAt,
            DateTime createdAt,
            DateTime updatedAt,
            DateTime? deletedAt,
            int syncStatus,
            List<MilestoneModel> milestones,
            List<String> linkedHabitIds,
            List<String> linkedTaskIds)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GoalModel():
        return $default(
            _that.id,
            _that.userId,
            _that.title,
            _that.description,
            _that.lifeArea,
            _that.metricType,
            _that.targetValue,
            _that.currentValue,
            _that.unit,
            _that.targetDate,
            _that.priority,
            _that.status,
            _that.icon,
            _that.colorHex,
            _that.visibility,
            _that.completedAt,
            _that.createdAt,
            _that.updatedAt,
            _that.deletedAt,
            _that.syncStatus,
            _that.milestones,
            _that.linkedHabitIds,
            _that.linkedTaskIds);
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
            String title,
            String? description,
            String lifeArea,
            String metricType,
            double targetValue,
            double currentValue,
            String? unit,
            DateTime? targetDate,
            int priority,
            String status,
            String? icon,
            String colorHex,
            String visibility,
            DateTime? completedAt,
            DateTime createdAt,
            DateTime updatedAt,
            DateTime? deletedAt,
            int syncStatus,
            List<MilestoneModel> milestones,
            List<String> linkedHabitIds,
            List<String> linkedTaskIds)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GoalModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.title,
            _that.description,
            _that.lifeArea,
            _that.metricType,
            _that.targetValue,
            _that.currentValue,
            _that.unit,
            _that.targetDate,
            _that.priority,
            _that.status,
            _that.icon,
            _that.colorHex,
            _that.visibility,
            _that.completedAt,
            _that.createdAt,
            _that.updatedAt,
            _that.deletedAt,
            _that.syncStatus,
            _that.milestones,
            _that.linkedHabitIds,
            _that.linkedTaskIds);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GoalModel implements GoalModel {
  const _GoalModel(
      {required this.id,
      required this.userId,
      required this.title,
      this.description,
      required this.lifeArea,
      required this.metricType,
      required this.targetValue,
      this.currentValue = 0,
      this.unit,
      this.targetDate,
      this.priority = 1,
      this.status = 'active',
      this.icon,
      this.colorHex = '#C9A84C',
      this.visibility = 'private',
      this.completedAt,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      this.syncStatus = 0,
      final List<MilestoneModel> milestones = const [],
      final List<String> linkedHabitIds = const [],
      final List<String> linkedTaskIds = const []})
      : _milestones = milestones,
        _linkedHabitIds = linkedHabitIds,
        _linkedTaskIds = linkedTaskIds;
  factory _GoalModel.fromJson(Map<String, dynamic> json) =>
      _$GoalModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String lifeArea;
  @override
  final String metricType;
  @override
  final double targetValue;
  @override
  @JsonKey()
  final double currentValue;
  @override
  final String? unit;
  @override
  final DateTime? targetDate;
  @override
  @JsonKey()
  final int priority;
  @override
  @JsonKey()
  final String status;
  @override
  final String? icon;
  @override
  @JsonKey()
  final String colorHex;
  @override
  @JsonKey()
  final String visibility;
  @override
  final DateTime? completedAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  @JsonKey()
  final int syncStatus;
  final List<MilestoneModel> _milestones;
  @override
  @JsonKey()
  List<MilestoneModel> get milestones {
    if (_milestones is EqualUnmodifiableListView) return _milestones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_milestones);
  }

  final List<String> _linkedHabitIds;
  @override
  @JsonKey()
  List<String> get linkedHabitIds {
    if (_linkedHabitIds is EqualUnmodifiableListView) return _linkedHabitIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_linkedHabitIds);
  }

  final List<String> _linkedTaskIds;
  @override
  @JsonKey()
  List<String> get linkedTaskIds {
    if (_linkedTaskIds is EqualUnmodifiableListView) return _linkedTaskIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_linkedTaskIds);
  }

  /// Create a copy of GoalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GoalModelCopyWith<_GoalModel> get copyWith =>
      __$GoalModelCopyWithImpl<_GoalModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GoalModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GoalModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.lifeArea, lifeArea) ||
                other.lifeArea == lifeArea) &&
            (identical(other.metricType, metricType) ||
                other.metricType == metricType) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.currentValue, currentValue) ||
                other.currentValue == currentValue) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.targetDate, targetDate) ||
                other.targetDate == targetDate) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.colorHex, colorHex) ||
                other.colorHex == colorHex) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus) &&
            const DeepCollectionEquality()
                .equals(other._milestones, _milestones) &&
            const DeepCollectionEquality()
                .equals(other._linkedHabitIds, _linkedHabitIds) &&
            const DeepCollectionEquality()
                .equals(other._linkedTaskIds, _linkedTaskIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        title,
        description,
        lifeArea,
        metricType,
        targetValue,
        currentValue,
        unit,
        targetDate,
        priority,
        status,
        icon,
        colorHex,
        visibility,
        completedAt,
        createdAt,
        updatedAt,
        deletedAt,
        syncStatus,
        const DeepCollectionEquality().hash(_milestones),
        const DeepCollectionEquality().hash(_linkedHabitIds),
        const DeepCollectionEquality().hash(_linkedTaskIds)
      ]);

  @override
  String toString() {
    return 'GoalModel(id: $id, userId: $userId, title: $title, description: $description, lifeArea: $lifeArea, metricType: $metricType, targetValue: $targetValue, currentValue: $currentValue, unit: $unit, targetDate: $targetDate, priority: $priority, status: $status, icon: $icon, colorHex: $colorHex, visibility: $visibility, completedAt: $completedAt, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, syncStatus: $syncStatus, milestones: $milestones, linkedHabitIds: $linkedHabitIds, linkedTaskIds: $linkedTaskIds)';
  }
}

/// @nodoc
abstract mixin class _$GoalModelCopyWith<$Res>
    implements $GoalModelCopyWith<$Res> {
  factory _$GoalModelCopyWith(
          _GoalModel value, $Res Function(_GoalModel) _then) =
      __$GoalModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String? description,
      String lifeArea,
      String metricType,
      double targetValue,
      double currentValue,
      String? unit,
      DateTime? targetDate,
      int priority,
      String status,
      String? icon,
      String colorHex,
      String visibility,
      DateTime? completedAt,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      int syncStatus,
      List<MilestoneModel> milestones,
      List<String> linkedHabitIds,
      List<String> linkedTaskIds});
}

/// @nodoc
class __$GoalModelCopyWithImpl<$Res> implements _$GoalModelCopyWith<$Res> {
  __$GoalModelCopyWithImpl(this._self, this._then);

  final _GoalModel _self;
  final $Res Function(_GoalModel) _then;

  /// Create a copy of GoalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = freezed,
    Object? lifeArea = null,
    Object? metricType = null,
    Object? targetValue = null,
    Object? currentValue = null,
    Object? unit = freezed,
    Object? targetDate = freezed,
    Object? priority = null,
    Object? status = null,
    Object? icon = freezed,
    Object? colorHex = null,
    Object? visibility = null,
    Object? completedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? syncStatus = null,
    Object? milestones = null,
    Object? linkedHabitIds = null,
    Object? linkedTaskIds = null,
  }) {
    return _then(_GoalModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      lifeArea: null == lifeArea
          ? _self.lifeArea
          : lifeArea // ignore: cast_nullable_to_non_nullable
              as String,
      metricType: null == metricType
          ? _self.metricType
          : metricType // ignore: cast_nullable_to_non_nullable
              as String,
      targetValue: null == targetValue
          ? _self.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as double,
      currentValue: null == currentValue
          ? _self.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as double,
      unit: freezed == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      targetDate: freezed == targetDate
          ? _self.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      colorHex: null == colorHex
          ? _self.colorHex
          : colorHex // ignore: cast_nullable_to_non_nullable
              as String,
      visibility: null == visibility
          ? _self.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as String,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      syncStatus: null == syncStatus
          ? _self.syncStatus
          : syncStatus // ignore: cast_nullable_to_non_nullable
              as int,
      milestones: null == milestones
          ? _self._milestones
          : milestones // ignore: cast_nullable_to_non_nullable
              as List<MilestoneModel>,
      linkedHabitIds: null == linkedHabitIds
          ? _self._linkedHabitIds
          : linkedHabitIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      linkedTaskIds: null == linkedTaskIds
          ? _self._linkedTaskIds
          : linkedTaskIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
