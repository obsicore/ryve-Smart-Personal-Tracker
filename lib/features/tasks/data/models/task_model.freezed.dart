// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskModel {
  String get id;
  String get userId;
  String get title;
  String? get description;
  TaskPriority get priority;
  bool get isUrgent;
  bool get isImportant;
  DateTime? get dueDate;
  bool get isCompleted;
  DateTime? get completedAt;
  List<SubtaskModel> get subtasks;
  List<String> get tagIds;
  DateTime get createdAt;
  DateTime get updatedAt;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TaskModelCopyWith<TaskModel> get copyWith =>
      _$TaskModelCopyWithImpl<TaskModel>(this as TaskModel, _$identity);

  /// Serializes this TaskModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TaskModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.isUrgent, isUrgent) ||
                other.isUrgent == isUrgent) &&
            (identical(other.isImportant, isImportant) ||
                other.isImportant == isImportant) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            const DeepCollectionEquality().equals(other.subtasks, subtasks) &&
            const DeepCollectionEquality().equals(other.tagIds, tagIds) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      description,
      priority,
      isUrgent,
      isImportant,
      dueDate,
      isCompleted,
      completedAt,
      const DeepCollectionEquality().hash(subtasks),
      const DeepCollectionEquality().hash(tagIds),
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'TaskModel(id: $id, userId: $userId, title: $title, description: $description, priority: $priority, isUrgent: $isUrgent, isImportant: $isImportant, dueDate: $dueDate, isCompleted: $isCompleted, completedAt: $completedAt, subtasks: $subtasks, tagIds: $tagIds, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $TaskModelCopyWith<$Res> {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) _then) =
      _$TaskModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String? description,
      TaskPriority priority,
      bool isUrgent,
      bool isImportant,
      DateTime? dueDate,
      bool isCompleted,
      DateTime? completedAt,
      List<SubtaskModel> subtasks,
      List<String> tagIds,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$TaskModelCopyWithImpl<$Res> implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._self, this._then);

  final TaskModel _self;
  final $Res Function(TaskModel) _then;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = freezed,
    Object? priority = null,
    Object? isUrgent = null,
    Object? isImportant = null,
    Object? dueDate = freezed,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? subtasks = null,
    Object? tagIds = null,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TaskPriority,
      isUrgent: null == isUrgent
          ? _self.isUrgent
          : isUrgent // ignore: cast_nullable_to_non_nullable
              as bool,
      isImportant: null == isImportant
          ? _self.isImportant
          : isImportant // ignore: cast_nullable_to_non_nullable
              as bool,
      dueDate: freezed == dueDate
          ? _self.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      subtasks: null == subtasks
          ? _self.subtasks
          : subtasks // ignore: cast_nullable_to_non_nullable
              as List<SubtaskModel>,
      tagIds: null == tagIds
          ? _self.tagIds
          : tagIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [TaskModel].
extension TaskModelPatterns on TaskModel {
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
    TResult Function(_TaskModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TaskModel() when $default != null:
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
    TResult Function(_TaskModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TaskModel():
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
    TResult? Function(_TaskModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TaskModel() when $default != null:
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
            TaskPriority priority,
            bool isUrgent,
            bool isImportant,
            DateTime? dueDate,
            bool isCompleted,
            DateTime? completedAt,
            List<SubtaskModel> subtasks,
            List<String> tagIds,
            DateTime createdAt,
            DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TaskModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.title,
            _that.description,
            _that.priority,
            _that.isUrgent,
            _that.isImportant,
            _that.dueDate,
            _that.isCompleted,
            _that.completedAt,
            _that.subtasks,
            _that.tagIds,
            _that.createdAt,
            _that.updatedAt);
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
            TaskPriority priority,
            bool isUrgent,
            bool isImportant,
            DateTime? dueDate,
            bool isCompleted,
            DateTime? completedAt,
            List<SubtaskModel> subtasks,
            List<String> tagIds,
            DateTime createdAt,
            DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TaskModel():
        return $default(
            _that.id,
            _that.userId,
            _that.title,
            _that.description,
            _that.priority,
            _that.isUrgent,
            _that.isImportant,
            _that.dueDate,
            _that.isCompleted,
            _that.completedAt,
            _that.subtasks,
            _that.tagIds,
            _that.createdAt,
            _that.updatedAt);
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
            TaskPriority priority,
            bool isUrgent,
            bool isImportant,
            DateTime? dueDate,
            bool isCompleted,
            DateTime? completedAt,
            List<SubtaskModel> subtasks,
            List<String> tagIds,
            DateTime createdAt,
            DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TaskModel() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.title,
            _that.description,
            _that.priority,
            _that.isUrgent,
            _that.isImportant,
            _that.dueDate,
            _that.isCompleted,
            _that.completedAt,
            _that.subtasks,
            _that.tagIds,
            _that.createdAt,
            _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TaskModel implements TaskModel {
  const _TaskModel(
      {required this.id,
      required this.userId,
      required this.title,
      this.description,
      this.priority = TaskPriority.medium,
      this.isUrgent = false,
      this.isImportant = true,
      this.dueDate,
      this.isCompleted = false,
      this.completedAt,
      final List<SubtaskModel> subtasks = const [],
      final List<String> tagIds = const [],
      required this.createdAt,
      required this.updatedAt})
      : _subtasks = subtasks,
        _tagIds = tagIds;
  factory _TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String? description;
  @override
  @JsonKey()
  final TaskPriority priority;
  @override
  @JsonKey()
  final bool isUrgent;
  @override
  @JsonKey()
  final bool isImportant;
  @override
  final DateTime? dueDate;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final DateTime? completedAt;
  final List<SubtaskModel> _subtasks;
  @override
  @JsonKey()
  List<SubtaskModel> get subtasks {
    if (_subtasks is EqualUnmodifiableListView) return _subtasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subtasks);
  }

  final List<String> _tagIds;
  @override
  @JsonKey()
  List<String> get tagIds {
    if (_tagIds is EqualUnmodifiableListView) return _tagIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tagIds);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TaskModelCopyWith<_TaskModel> get copyWith =>
      __$TaskModelCopyWithImpl<_TaskModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TaskModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TaskModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.isUrgent, isUrgent) ||
                other.isUrgent == isUrgent) &&
            (identical(other.isImportant, isImportant) ||
                other.isImportant == isImportant) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            const DeepCollectionEquality().equals(other._subtasks, _subtasks) &&
            const DeepCollectionEquality().equals(other._tagIds, _tagIds) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      description,
      priority,
      isUrgent,
      isImportant,
      dueDate,
      isCompleted,
      completedAt,
      const DeepCollectionEquality().hash(_subtasks),
      const DeepCollectionEquality().hash(_tagIds),
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'TaskModel(id: $id, userId: $userId, title: $title, description: $description, priority: $priority, isUrgent: $isUrgent, isImportant: $isImportant, dueDate: $dueDate, isCompleted: $isCompleted, completedAt: $completedAt, subtasks: $subtasks, tagIds: $tagIds, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$TaskModelCopyWith<$Res>
    implements $TaskModelCopyWith<$Res> {
  factory _$TaskModelCopyWith(
          _TaskModel value, $Res Function(_TaskModel) _then) =
      __$TaskModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String? description,
      TaskPriority priority,
      bool isUrgent,
      bool isImportant,
      DateTime? dueDate,
      bool isCompleted,
      DateTime? completedAt,
      List<SubtaskModel> subtasks,
      List<String> tagIds,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$TaskModelCopyWithImpl<$Res> implements _$TaskModelCopyWith<$Res> {
  __$TaskModelCopyWithImpl(this._self, this._then);

  final _TaskModel _self;
  final $Res Function(_TaskModel) _then;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = freezed,
    Object? priority = null,
    Object? isUrgent = null,
    Object? isImportant = null,
    Object? dueDate = freezed,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? subtasks = null,
    Object? tagIds = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_TaskModel(
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
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TaskPriority,
      isUrgent: null == isUrgent
          ? _self.isUrgent
          : isUrgent // ignore: cast_nullable_to_non_nullable
              as bool,
      isImportant: null == isImportant
          ? _self.isImportant
          : isImportant // ignore: cast_nullable_to_non_nullable
              as bool,
      dueDate: freezed == dueDate
          ? _self.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      subtasks: null == subtasks
          ? _self._subtasks
          : subtasks // ignore: cast_nullable_to_non_nullable
              as List<SubtaskModel>,
      tagIds: null == tagIds
          ? _self._tagIds
          : tagIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
mixin _$SubtaskModel {
  String get id;
  String get taskId;
  String get title;
  bool get isCompleted;
  int get order;

  /// Create a copy of SubtaskModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubtaskModelCopyWith<SubtaskModel> get copyWith =>
      _$SubtaskModelCopyWithImpl<SubtaskModel>(
          this as SubtaskModel, _$identity);

  /// Serializes this SubtaskModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SubtaskModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, taskId, title, isCompleted, order);

  @override
  String toString() {
    return 'SubtaskModel(id: $id, taskId: $taskId, title: $title, isCompleted: $isCompleted, order: $order)';
  }
}

/// @nodoc
abstract mixin class $SubtaskModelCopyWith<$Res> {
  factory $SubtaskModelCopyWith(
          SubtaskModel value, $Res Function(SubtaskModel) _then) =
      _$SubtaskModelCopyWithImpl;
  @useResult
  $Res call(
      {String id, String taskId, String title, bool isCompleted, int order});
}

/// @nodoc
class _$SubtaskModelCopyWithImpl<$Res> implements $SubtaskModelCopyWith<$Res> {
  _$SubtaskModelCopyWithImpl(this._self, this._then);

  final SubtaskModel _self;
  final $Res Function(SubtaskModel) _then;

  /// Create a copy of SubtaskModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? taskId = null,
    Object? title = null,
    Object? isCompleted = null,
    Object? order = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      taskId: null == taskId
          ? _self.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [SubtaskModel].
extension SubtaskModelPatterns on SubtaskModel {
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
    TResult Function(_SubtaskModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubtaskModel() when $default != null:
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
    TResult Function(_SubtaskModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubtaskModel():
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
    TResult? Function(_SubtaskModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubtaskModel() when $default != null:
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
    TResult Function(String id, String taskId, String title, bool isCompleted,
            int order)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubtaskModel() when $default != null:
        return $default(_that.id, _that.taskId, _that.title, _that.isCompleted,
            _that.order);
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
            String id, String taskId, String title, bool isCompleted, int order)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubtaskModel():
        return $default(_that.id, _that.taskId, _that.title, _that.isCompleted,
            _that.order);
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
    TResult? Function(String id, String taskId, String title, bool isCompleted,
            int order)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubtaskModel() when $default != null:
        return $default(_that.id, _that.taskId, _that.title, _that.isCompleted,
            _that.order);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SubtaskModel implements SubtaskModel {
  const _SubtaskModel(
      {required this.id,
      required this.taskId,
      required this.title,
      this.isCompleted = false,
      required this.order});
  factory _SubtaskModel.fromJson(Map<String, dynamic> json) =>
      _$SubtaskModelFromJson(json);

  @override
  final String id;
  @override
  final String taskId;
  @override
  final String title;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final int order;

  /// Create a copy of SubtaskModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubtaskModelCopyWith<_SubtaskModel> get copyWith =>
      __$SubtaskModelCopyWithImpl<_SubtaskModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SubtaskModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubtaskModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, taskId, title, isCompleted, order);

  @override
  String toString() {
    return 'SubtaskModel(id: $id, taskId: $taskId, title: $title, isCompleted: $isCompleted, order: $order)';
  }
}

/// @nodoc
abstract mixin class _$SubtaskModelCopyWith<$Res>
    implements $SubtaskModelCopyWith<$Res> {
  factory _$SubtaskModelCopyWith(
          _SubtaskModel value, $Res Function(_SubtaskModel) _then) =
      __$SubtaskModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id, String taskId, String title, bool isCompleted, int order});
}

/// @nodoc
class __$SubtaskModelCopyWithImpl<$Res>
    implements _$SubtaskModelCopyWith<$Res> {
  __$SubtaskModelCopyWithImpl(this._self, this._then);

  final _SubtaskModel _self;
  final $Res Function(_SubtaskModel) _then;

  /// Create a copy of SubtaskModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? taskId = null,
    Object? title = null,
    Object? isCompleted = null,
    Object? order = null,
  }) {
    return _then(_SubtaskModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      taskId: null == taskId
          ? _self.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$TagModel {
  String get id;
  String get name;
  String get color;

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TagModelCopyWith<TagModel> get copyWith =>
      _$TagModelCopyWithImpl<TagModel>(this as TagModel, _$identity);

  /// Serializes this TagModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TagModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, color);

  @override
  String toString() {
    return 'TagModel(id: $id, name: $name, color: $color)';
  }
}

/// @nodoc
abstract mixin class $TagModelCopyWith<$Res> {
  factory $TagModelCopyWith(TagModel value, $Res Function(TagModel) _then) =
      _$TagModelCopyWithImpl;
  @useResult
  $Res call({String id, String name, String color});
}

/// @nodoc
class _$TagModelCopyWithImpl<$Res> implements $TagModelCopyWith<$Res> {
  _$TagModelCopyWithImpl(this._self, this._then);

  final TagModel _self;
  final $Res Function(TagModel) _then;

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = null,
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
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [TagModel].
extension TagModelPatterns on TagModel {
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
    TResult Function(_TagModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TagModel() when $default != null:
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
    TResult Function(_TagModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TagModel():
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
    TResult? Function(_TagModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TagModel() when $default != null:
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
    TResult Function(String id, String name, String color)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TagModel() when $default != null:
        return $default(_that.id, _that.name, _that.color);
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
    TResult Function(String id, String name, String color) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TagModel():
        return $default(_that.id, _that.name, _that.color);
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
    TResult? Function(String id, String name, String color)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TagModel() when $default != null:
        return $default(_that.id, _that.name, _that.color);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TagModel implements TagModel {
  const _TagModel(
      {required this.id, required this.name, this.color = '#C9A84C'});
  factory _TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String color;

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TagModelCopyWith<_TagModel> get copyWith =>
      __$TagModelCopyWithImpl<_TagModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TagModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TagModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, color);

  @override
  String toString() {
    return 'TagModel(id: $id, name: $name, color: $color)';
  }
}

/// @nodoc
abstract mixin class _$TagModelCopyWith<$Res>
    implements $TagModelCopyWith<$Res> {
  factory _$TagModelCopyWith(_TagModel value, $Res Function(_TagModel) _then) =
      __$TagModelCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String name, String color});
}

/// @nodoc
class __$TagModelCopyWithImpl<$Res> implements _$TagModelCopyWith<$Res> {
  __$TagModelCopyWithImpl(this._self, this._then);

  final _TagModel _self;
  final $Res Function(_TagModel) _then;

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = null,
  }) {
    return _then(_TagModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
