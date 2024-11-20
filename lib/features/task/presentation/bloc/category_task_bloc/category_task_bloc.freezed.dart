// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_task_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CategoryTaskEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(CategoryModel categorySelected) categorySelected,
    required TResult Function(CategoryModel category) addCategory,
    required TResult Function(CategoryModel category) editCategory,
    required TResult Function(CategoryModel category) deleteCategory,
    required TResult Function(Task task) categoryTaskChanged,
    required TResult Function(String keyword) searchTask,
    required TResult Function() clearSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(CategoryModel categorySelected)? categorySelected,
    TResult? Function(CategoryModel category)? addCategory,
    TResult? Function(CategoryModel category)? editCategory,
    TResult? Function(CategoryModel category)? deleteCategory,
    TResult? Function(Task task)? categoryTaskChanged,
    TResult? Function(String keyword)? searchTask,
    TResult? Function()? clearSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(CategoryModel categorySelected)? categorySelected,
    TResult Function(CategoryModel category)? addCategory,
    TResult Function(CategoryModel category)? editCategory,
    TResult Function(CategoryModel category)? deleteCategory,
    TResult Function(Task task)? categoryTaskChanged,
    TResult Function(String keyword)? searchTask,
    TResult Function()? clearSearch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_CategorySelected value) categorySelected,
    required TResult Function(InsertNewCategory value) addCategory,
    required TResult Function(_EditCategory value) editCategory,
    required TResult Function(_DeleteCategory value) deleteCategory,
    required TResult Function(_CategoryTaskChanged value) categoryTaskChanged,
    required TResult Function(_SearchTask value) searchTask,
    required TResult Function(_ClearSearch value) clearSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_CategorySelected value)? categorySelected,
    TResult? Function(InsertNewCategory value)? addCategory,
    TResult? Function(_EditCategory value)? editCategory,
    TResult? Function(_DeleteCategory value)? deleteCategory,
    TResult? Function(_CategoryTaskChanged value)? categoryTaskChanged,
    TResult? Function(_SearchTask value)? searchTask,
    TResult? Function(_ClearSearch value)? clearSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_CategorySelected value)? categorySelected,
    TResult Function(InsertNewCategory value)? addCategory,
    TResult Function(_EditCategory value)? editCategory,
    TResult Function(_DeleteCategory value)? deleteCategory,
    TResult Function(_CategoryTaskChanged value)? categoryTaskChanged,
    TResult Function(_SearchTask value)? searchTask,
    TResult Function(_ClearSearch value)? clearSearch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryTaskEventCopyWith<$Res> {
  factory $CategoryTaskEventCopyWith(
          CategoryTaskEvent value, $Res Function(CategoryTaskEvent) then) =
      _$CategoryTaskEventCopyWithImpl<$Res, CategoryTaskEvent>;
}

/// @nodoc
class _$CategoryTaskEventCopyWithImpl<$Res, $Val extends CategoryTaskEvent>
    implements $CategoryTaskEventCopyWith<$Res> {
  _$CategoryTaskEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$CategoryTaskEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl with DiagnosticableTreeMixin implements _Started {
  const _$StartedImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CategoryTaskEvent.started()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'CategoryTaskEvent.started'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(CategoryModel categorySelected) categorySelected,
    required TResult Function(CategoryModel category) addCategory,
    required TResult Function(CategoryModel category) editCategory,
    required TResult Function(CategoryModel category) deleteCategory,
    required TResult Function(Task task) categoryTaskChanged,
    required TResult Function(String keyword) searchTask,
    required TResult Function() clearSearch,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(CategoryModel categorySelected)? categorySelected,
    TResult? Function(CategoryModel category)? addCategory,
    TResult? Function(CategoryModel category)? editCategory,
    TResult? Function(CategoryModel category)? deleteCategory,
    TResult? Function(Task task)? categoryTaskChanged,
    TResult? Function(String keyword)? searchTask,
    TResult? Function()? clearSearch,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(CategoryModel categorySelected)? categorySelected,
    TResult Function(CategoryModel category)? addCategory,
    TResult Function(CategoryModel category)? editCategory,
    TResult Function(CategoryModel category)? deleteCategory,
    TResult Function(Task task)? categoryTaskChanged,
    TResult Function(String keyword)? searchTask,
    TResult Function()? clearSearch,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_CategorySelected value) categorySelected,
    required TResult Function(InsertNewCategory value) addCategory,
    required TResult Function(_EditCategory value) editCategory,
    required TResult Function(_DeleteCategory value) deleteCategory,
    required TResult Function(_CategoryTaskChanged value) categoryTaskChanged,
    required TResult Function(_SearchTask value) searchTask,
    required TResult Function(_ClearSearch value) clearSearch,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_CategorySelected value)? categorySelected,
    TResult? Function(InsertNewCategory value)? addCategory,
    TResult? Function(_EditCategory value)? editCategory,
    TResult? Function(_DeleteCategory value)? deleteCategory,
    TResult? Function(_CategoryTaskChanged value)? categoryTaskChanged,
    TResult? Function(_SearchTask value)? searchTask,
    TResult? Function(_ClearSearch value)? clearSearch,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_CategorySelected value)? categorySelected,
    TResult Function(InsertNewCategory value)? addCategory,
    TResult Function(_EditCategory value)? editCategory,
    TResult Function(_DeleteCategory value)? deleteCategory,
    TResult Function(_CategoryTaskChanged value)? categoryTaskChanged,
    TResult Function(_SearchTask value)? searchTask,
    TResult Function(_ClearSearch value)? clearSearch,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements CategoryTaskEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$CategorySelectedImplCopyWith<$Res> {
  factory _$$CategorySelectedImplCopyWith(_$CategorySelectedImpl value,
          $Res Function(_$CategorySelectedImpl) then) =
      __$$CategorySelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CategoryModel categorySelected});
}

/// @nodoc
class __$$CategorySelectedImplCopyWithImpl<$Res>
    extends _$CategoryTaskEventCopyWithImpl<$Res, _$CategorySelectedImpl>
    implements _$$CategorySelectedImplCopyWith<$Res> {
  __$$CategorySelectedImplCopyWithImpl(_$CategorySelectedImpl _value,
      $Res Function(_$CategorySelectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categorySelected = null,
  }) {
    return _then(_$CategorySelectedImpl(
      null == categorySelected
          ? _value.categorySelected
          : categorySelected // ignore: cast_nullable_to_non_nullable
              as CategoryModel,
    ));
  }
}

/// @nodoc

class _$CategorySelectedImpl
    with DiagnosticableTreeMixin
    implements _CategorySelected {
  const _$CategorySelectedImpl(this.categorySelected);

  @override
  final CategoryModel categorySelected;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CategoryTaskEvent.categorySelected(categorySelected: $categorySelected)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CategoryTaskEvent.categorySelected'))
      ..add(DiagnosticsProperty('categorySelected', categorySelected));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategorySelectedImpl &&
            (identical(other.categorySelected, categorySelected) ||
                other.categorySelected == categorySelected));
  }

  @override
  int get hashCode => Object.hash(runtimeType, categorySelected);

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategorySelectedImplCopyWith<_$CategorySelectedImpl> get copyWith =>
      __$$CategorySelectedImplCopyWithImpl<_$CategorySelectedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(CategoryModel categorySelected) categorySelected,
    required TResult Function(CategoryModel category) addCategory,
    required TResult Function(CategoryModel category) editCategory,
    required TResult Function(CategoryModel category) deleteCategory,
    required TResult Function(Task task) categoryTaskChanged,
    required TResult Function(String keyword) searchTask,
    required TResult Function() clearSearch,
  }) {
    return categorySelected(this.categorySelected);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(CategoryModel categorySelected)? categorySelected,
    TResult? Function(CategoryModel category)? addCategory,
    TResult? Function(CategoryModel category)? editCategory,
    TResult? Function(CategoryModel category)? deleteCategory,
    TResult? Function(Task task)? categoryTaskChanged,
    TResult? Function(String keyword)? searchTask,
    TResult? Function()? clearSearch,
  }) {
    return categorySelected?.call(this.categorySelected);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(CategoryModel categorySelected)? categorySelected,
    TResult Function(CategoryModel category)? addCategory,
    TResult Function(CategoryModel category)? editCategory,
    TResult Function(CategoryModel category)? deleteCategory,
    TResult Function(Task task)? categoryTaskChanged,
    TResult Function(String keyword)? searchTask,
    TResult Function()? clearSearch,
    required TResult orElse(),
  }) {
    if (categorySelected != null) {
      return categorySelected(this.categorySelected);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_CategorySelected value) categorySelected,
    required TResult Function(InsertNewCategory value) addCategory,
    required TResult Function(_EditCategory value) editCategory,
    required TResult Function(_DeleteCategory value) deleteCategory,
    required TResult Function(_CategoryTaskChanged value) categoryTaskChanged,
    required TResult Function(_SearchTask value) searchTask,
    required TResult Function(_ClearSearch value) clearSearch,
  }) {
    return categorySelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_CategorySelected value)? categorySelected,
    TResult? Function(InsertNewCategory value)? addCategory,
    TResult? Function(_EditCategory value)? editCategory,
    TResult? Function(_DeleteCategory value)? deleteCategory,
    TResult? Function(_CategoryTaskChanged value)? categoryTaskChanged,
    TResult? Function(_SearchTask value)? searchTask,
    TResult? Function(_ClearSearch value)? clearSearch,
  }) {
    return categorySelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_CategorySelected value)? categorySelected,
    TResult Function(InsertNewCategory value)? addCategory,
    TResult Function(_EditCategory value)? editCategory,
    TResult Function(_DeleteCategory value)? deleteCategory,
    TResult Function(_CategoryTaskChanged value)? categoryTaskChanged,
    TResult Function(_SearchTask value)? searchTask,
    TResult Function(_ClearSearch value)? clearSearch,
    required TResult orElse(),
  }) {
    if (categorySelected != null) {
      return categorySelected(this);
    }
    return orElse();
  }
}

abstract class _CategorySelected implements CategoryTaskEvent {
  const factory _CategorySelected(final CategoryModel categorySelected) =
      _$CategorySelectedImpl;

  CategoryModel get categorySelected;

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategorySelectedImplCopyWith<_$CategorySelectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InsertNewCategoryImplCopyWith<$Res> {
  factory _$$InsertNewCategoryImplCopyWith(_$InsertNewCategoryImpl value,
          $Res Function(_$InsertNewCategoryImpl) then) =
      __$$InsertNewCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CategoryModel category});
}

/// @nodoc
class __$$InsertNewCategoryImplCopyWithImpl<$Res>
    extends _$CategoryTaskEventCopyWithImpl<$Res, _$InsertNewCategoryImpl>
    implements _$$InsertNewCategoryImplCopyWith<$Res> {
  __$$InsertNewCategoryImplCopyWithImpl(_$InsertNewCategoryImpl _value,
      $Res Function(_$InsertNewCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
  }) {
    return _then(_$InsertNewCategoryImpl(
      null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryModel,
    ));
  }
}

/// @nodoc

class _$InsertNewCategoryImpl
    with DiagnosticableTreeMixin
    implements InsertNewCategory {
  const _$InsertNewCategoryImpl(this.category);

  @override
  final CategoryModel category;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CategoryTaskEvent.addCategory(category: $category)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CategoryTaskEvent.addCategory'))
      ..add(DiagnosticsProperty('category', category));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsertNewCategoryImpl &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InsertNewCategoryImplCopyWith<_$InsertNewCategoryImpl> get copyWith =>
      __$$InsertNewCategoryImplCopyWithImpl<_$InsertNewCategoryImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(CategoryModel categorySelected) categorySelected,
    required TResult Function(CategoryModel category) addCategory,
    required TResult Function(CategoryModel category) editCategory,
    required TResult Function(CategoryModel category) deleteCategory,
    required TResult Function(Task task) categoryTaskChanged,
    required TResult Function(String keyword) searchTask,
    required TResult Function() clearSearch,
  }) {
    return addCategory(category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(CategoryModel categorySelected)? categorySelected,
    TResult? Function(CategoryModel category)? addCategory,
    TResult? Function(CategoryModel category)? editCategory,
    TResult? Function(CategoryModel category)? deleteCategory,
    TResult? Function(Task task)? categoryTaskChanged,
    TResult? Function(String keyword)? searchTask,
    TResult? Function()? clearSearch,
  }) {
    return addCategory?.call(category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(CategoryModel categorySelected)? categorySelected,
    TResult Function(CategoryModel category)? addCategory,
    TResult Function(CategoryModel category)? editCategory,
    TResult Function(CategoryModel category)? deleteCategory,
    TResult Function(Task task)? categoryTaskChanged,
    TResult Function(String keyword)? searchTask,
    TResult Function()? clearSearch,
    required TResult orElse(),
  }) {
    if (addCategory != null) {
      return addCategory(category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_CategorySelected value) categorySelected,
    required TResult Function(InsertNewCategory value) addCategory,
    required TResult Function(_EditCategory value) editCategory,
    required TResult Function(_DeleteCategory value) deleteCategory,
    required TResult Function(_CategoryTaskChanged value) categoryTaskChanged,
    required TResult Function(_SearchTask value) searchTask,
    required TResult Function(_ClearSearch value) clearSearch,
  }) {
    return addCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_CategorySelected value)? categorySelected,
    TResult? Function(InsertNewCategory value)? addCategory,
    TResult? Function(_EditCategory value)? editCategory,
    TResult? Function(_DeleteCategory value)? deleteCategory,
    TResult? Function(_CategoryTaskChanged value)? categoryTaskChanged,
    TResult? Function(_SearchTask value)? searchTask,
    TResult? Function(_ClearSearch value)? clearSearch,
  }) {
    return addCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_CategorySelected value)? categorySelected,
    TResult Function(InsertNewCategory value)? addCategory,
    TResult Function(_EditCategory value)? editCategory,
    TResult Function(_DeleteCategory value)? deleteCategory,
    TResult Function(_CategoryTaskChanged value)? categoryTaskChanged,
    TResult Function(_SearchTask value)? searchTask,
    TResult Function(_ClearSearch value)? clearSearch,
    required TResult orElse(),
  }) {
    if (addCategory != null) {
      return addCategory(this);
    }
    return orElse();
  }
}

abstract class InsertNewCategory implements CategoryTaskEvent {
  const factory InsertNewCategory(final CategoryModel category) =
      _$InsertNewCategoryImpl;

  CategoryModel get category;

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InsertNewCategoryImplCopyWith<_$InsertNewCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditCategoryImplCopyWith<$Res> {
  factory _$$EditCategoryImplCopyWith(
          _$EditCategoryImpl value, $Res Function(_$EditCategoryImpl) then) =
      __$$EditCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CategoryModel category});
}

/// @nodoc
class __$$EditCategoryImplCopyWithImpl<$Res>
    extends _$CategoryTaskEventCopyWithImpl<$Res, _$EditCategoryImpl>
    implements _$$EditCategoryImplCopyWith<$Res> {
  __$$EditCategoryImplCopyWithImpl(
      _$EditCategoryImpl _value, $Res Function(_$EditCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
  }) {
    return _then(_$EditCategoryImpl(
      null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryModel,
    ));
  }
}

/// @nodoc

class _$EditCategoryImpl with DiagnosticableTreeMixin implements _EditCategory {
  const _$EditCategoryImpl(this.category);

  @override
  final CategoryModel category;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CategoryTaskEvent.editCategory(category: $category)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CategoryTaskEvent.editCategory'))
      ..add(DiagnosticsProperty('category', category));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditCategoryImpl &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditCategoryImplCopyWith<_$EditCategoryImpl> get copyWith =>
      __$$EditCategoryImplCopyWithImpl<_$EditCategoryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(CategoryModel categorySelected) categorySelected,
    required TResult Function(CategoryModel category) addCategory,
    required TResult Function(CategoryModel category) editCategory,
    required TResult Function(CategoryModel category) deleteCategory,
    required TResult Function(Task task) categoryTaskChanged,
    required TResult Function(String keyword) searchTask,
    required TResult Function() clearSearch,
  }) {
    return editCategory(category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(CategoryModel categorySelected)? categorySelected,
    TResult? Function(CategoryModel category)? addCategory,
    TResult? Function(CategoryModel category)? editCategory,
    TResult? Function(CategoryModel category)? deleteCategory,
    TResult? Function(Task task)? categoryTaskChanged,
    TResult? Function(String keyword)? searchTask,
    TResult? Function()? clearSearch,
  }) {
    return editCategory?.call(category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(CategoryModel categorySelected)? categorySelected,
    TResult Function(CategoryModel category)? addCategory,
    TResult Function(CategoryModel category)? editCategory,
    TResult Function(CategoryModel category)? deleteCategory,
    TResult Function(Task task)? categoryTaskChanged,
    TResult Function(String keyword)? searchTask,
    TResult Function()? clearSearch,
    required TResult orElse(),
  }) {
    if (editCategory != null) {
      return editCategory(category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_CategorySelected value) categorySelected,
    required TResult Function(InsertNewCategory value) addCategory,
    required TResult Function(_EditCategory value) editCategory,
    required TResult Function(_DeleteCategory value) deleteCategory,
    required TResult Function(_CategoryTaskChanged value) categoryTaskChanged,
    required TResult Function(_SearchTask value) searchTask,
    required TResult Function(_ClearSearch value) clearSearch,
  }) {
    return editCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_CategorySelected value)? categorySelected,
    TResult? Function(InsertNewCategory value)? addCategory,
    TResult? Function(_EditCategory value)? editCategory,
    TResult? Function(_DeleteCategory value)? deleteCategory,
    TResult? Function(_CategoryTaskChanged value)? categoryTaskChanged,
    TResult? Function(_SearchTask value)? searchTask,
    TResult? Function(_ClearSearch value)? clearSearch,
  }) {
    return editCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_CategorySelected value)? categorySelected,
    TResult Function(InsertNewCategory value)? addCategory,
    TResult Function(_EditCategory value)? editCategory,
    TResult Function(_DeleteCategory value)? deleteCategory,
    TResult Function(_CategoryTaskChanged value)? categoryTaskChanged,
    TResult Function(_SearchTask value)? searchTask,
    TResult Function(_ClearSearch value)? clearSearch,
    required TResult orElse(),
  }) {
    if (editCategory != null) {
      return editCategory(this);
    }
    return orElse();
  }
}

abstract class _EditCategory implements CategoryTaskEvent {
  const factory _EditCategory(final CategoryModel category) =
      _$EditCategoryImpl;

  CategoryModel get category;

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditCategoryImplCopyWith<_$EditCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteCategoryImplCopyWith<$Res> {
  factory _$$DeleteCategoryImplCopyWith(_$DeleteCategoryImpl value,
          $Res Function(_$DeleteCategoryImpl) then) =
      __$$DeleteCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CategoryModel category});
}

/// @nodoc
class __$$DeleteCategoryImplCopyWithImpl<$Res>
    extends _$CategoryTaskEventCopyWithImpl<$Res, _$DeleteCategoryImpl>
    implements _$$DeleteCategoryImplCopyWith<$Res> {
  __$$DeleteCategoryImplCopyWithImpl(
      _$DeleteCategoryImpl _value, $Res Function(_$DeleteCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
  }) {
    return _then(_$DeleteCategoryImpl(
      null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryModel,
    ));
  }
}

/// @nodoc

class _$DeleteCategoryImpl
    with DiagnosticableTreeMixin
    implements _DeleteCategory {
  const _$DeleteCategoryImpl(this.category);

  @override
  final CategoryModel category;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CategoryTaskEvent.deleteCategory(category: $category)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CategoryTaskEvent.deleteCategory'))
      ..add(DiagnosticsProperty('category', category));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteCategoryImpl &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteCategoryImplCopyWith<_$DeleteCategoryImpl> get copyWith =>
      __$$DeleteCategoryImplCopyWithImpl<_$DeleteCategoryImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(CategoryModel categorySelected) categorySelected,
    required TResult Function(CategoryModel category) addCategory,
    required TResult Function(CategoryModel category) editCategory,
    required TResult Function(CategoryModel category) deleteCategory,
    required TResult Function(Task task) categoryTaskChanged,
    required TResult Function(String keyword) searchTask,
    required TResult Function() clearSearch,
  }) {
    return deleteCategory(category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(CategoryModel categorySelected)? categorySelected,
    TResult? Function(CategoryModel category)? addCategory,
    TResult? Function(CategoryModel category)? editCategory,
    TResult? Function(CategoryModel category)? deleteCategory,
    TResult? Function(Task task)? categoryTaskChanged,
    TResult? Function(String keyword)? searchTask,
    TResult? Function()? clearSearch,
  }) {
    return deleteCategory?.call(category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(CategoryModel categorySelected)? categorySelected,
    TResult Function(CategoryModel category)? addCategory,
    TResult Function(CategoryModel category)? editCategory,
    TResult Function(CategoryModel category)? deleteCategory,
    TResult Function(Task task)? categoryTaskChanged,
    TResult Function(String keyword)? searchTask,
    TResult Function()? clearSearch,
    required TResult orElse(),
  }) {
    if (deleteCategory != null) {
      return deleteCategory(category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_CategorySelected value) categorySelected,
    required TResult Function(InsertNewCategory value) addCategory,
    required TResult Function(_EditCategory value) editCategory,
    required TResult Function(_DeleteCategory value) deleteCategory,
    required TResult Function(_CategoryTaskChanged value) categoryTaskChanged,
    required TResult Function(_SearchTask value) searchTask,
    required TResult Function(_ClearSearch value) clearSearch,
  }) {
    return deleteCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_CategorySelected value)? categorySelected,
    TResult? Function(InsertNewCategory value)? addCategory,
    TResult? Function(_EditCategory value)? editCategory,
    TResult? Function(_DeleteCategory value)? deleteCategory,
    TResult? Function(_CategoryTaskChanged value)? categoryTaskChanged,
    TResult? Function(_SearchTask value)? searchTask,
    TResult? Function(_ClearSearch value)? clearSearch,
  }) {
    return deleteCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_CategorySelected value)? categorySelected,
    TResult Function(InsertNewCategory value)? addCategory,
    TResult Function(_EditCategory value)? editCategory,
    TResult Function(_DeleteCategory value)? deleteCategory,
    TResult Function(_CategoryTaskChanged value)? categoryTaskChanged,
    TResult Function(_SearchTask value)? searchTask,
    TResult Function(_ClearSearch value)? clearSearch,
    required TResult orElse(),
  }) {
    if (deleteCategory != null) {
      return deleteCategory(this);
    }
    return orElse();
  }
}

abstract class _DeleteCategory implements CategoryTaskEvent {
  const factory _DeleteCategory(final CategoryModel category) =
      _$DeleteCategoryImpl;

  CategoryModel get category;

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteCategoryImplCopyWith<_$DeleteCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CategoryTaskChangedImplCopyWith<$Res> {
  factory _$$CategoryTaskChangedImplCopyWith(_$CategoryTaskChangedImpl value,
          $Res Function(_$CategoryTaskChangedImpl) then) =
      __$$CategoryTaskChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Task task});
}

/// @nodoc
class __$$CategoryTaskChangedImplCopyWithImpl<$Res>
    extends _$CategoryTaskEventCopyWithImpl<$Res, _$CategoryTaskChangedImpl>
    implements _$$CategoryTaskChangedImplCopyWith<$Res> {
  __$$CategoryTaskChangedImplCopyWithImpl(_$CategoryTaskChangedImpl _value,
      $Res Function(_$CategoryTaskChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
  }) {
    return _then(_$CategoryTaskChangedImpl(
      null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as Task,
    ));
  }
}

/// @nodoc

class _$CategoryTaskChangedImpl
    with DiagnosticableTreeMixin
    implements _CategoryTaskChanged {
  const _$CategoryTaskChangedImpl(this.task);

  @override
  final Task task;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CategoryTaskEvent.categoryTaskChanged(task: $task)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty('type', 'CategoryTaskEvent.categoryTaskChanged'))
      ..add(DiagnosticsProperty('task', task));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryTaskChangedImpl &&
            (identical(other.task, task) || other.task == task));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task);

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryTaskChangedImplCopyWith<_$CategoryTaskChangedImpl> get copyWith =>
      __$$CategoryTaskChangedImplCopyWithImpl<_$CategoryTaskChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(CategoryModel categorySelected) categorySelected,
    required TResult Function(CategoryModel category) addCategory,
    required TResult Function(CategoryModel category) editCategory,
    required TResult Function(CategoryModel category) deleteCategory,
    required TResult Function(Task task) categoryTaskChanged,
    required TResult Function(String keyword) searchTask,
    required TResult Function() clearSearch,
  }) {
    return categoryTaskChanged(task);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(CategoryModel categorySelected)? categorySelected,
    TResult? Function(CategoryModel category)? addCategory,
    TResult? Function(CategoryModel category)? editCategory,
    TResult? Function(CategoryModel category)? deleteCategory,
    TResult? Function(Task task)? categoryTaskChanged,
    TResult? Function(String keyword)? searchTask,
    TResult? Function()? clearSearch,
  }) {
    return categoryTaskChanged?.call(task);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(CategoryModel categorySelected)? categorySelected,
    TResult Function(CategoryModel category)? addCategory,
    TResult Function(CategoryModel category)? editCategory,
    TResult Function(CategoryModel category)? deleteCategory,
    TResult Function(Task task)? categoryTaskChanged,
    TResult Function(String keyword)? searchTask,
    TResult Function()? clearSearch,
    required TResult orElse(),
  }) {
    if (categoryTaskChanged != null) {
      return categoryTaskChanged(task);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_CategorySelected value) categorySelected,
    required TResult Function(InsertNewCategory value) addCategory,
    required TResult Function(_EditCategory value) editCategory,
    required TResult Function(_DeleteCategory value) deleteCategory,
    required TResult Function(_CategoryTaskChanged value) categoryTaskChanged,
    required TResult Function(_SearchTask value) searchTask,
    required TResult Function(_ClearSearch value) clearSearch,
  }) {
    return categoryTaskChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_CategorySelected value)? categorySelected,
    TResult? Function(InsertNewCategory value)? addCategory,
    TResult? Function(_EditCategory value)? editCategory,
    TResult? Function(_DeleteCategory value)? deleteCategory,
    TResult? Function(_CategoryTaskChanged value)? categoryTaskChanged,
    TResult? Function(_SearchTask value)? searchTask,
    TResult? Function(_ClearSearch value)? clearSearch,
  }) {
    return categoryTaskChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_CategorySelected value)? categorySelected,
    TResult Function(InsertNewCategory value)? addCategory,
    TResult Function(_EditCategory value)? editCategory,
    TResult Function(_DeleteCategory value)? deleteCategory,
    TResult Function(_CategoryTaskChanged value)? categoryTaskChanged,
    TResult Function(_SearchTask value)? searchTask,
    TResult Function(_ClearSearch value)? clearSearch,
    required TResult orElse(),
  }) {
    if (categoryTaskChanged != null) {
      return categoryTaskChanged(this);
    }
    return orElse();
  }
}

abstract class _CategoryTaskChanged implements CategoryTaskEvent {
  const factory _CategoryTaskChanged(final Task task) =
      _$CategoryTaskChangedImpl;

  Task get task;

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryTaskChangedImplCopyWith<_$CategoryTaskChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchTaskImplCopyWith<$Res> {
  factory _$$SearchTaskImplCopyWith(
          _$SearchTaskImpl value, $Res Function(_$SearchTaskImpl) then) =
      __$$SearchTaskImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String keyword});
}

/// @nodoc
class __$$SearchTaskImplCopyWithImpl<$Res>
    extends _$CategoryTaskEventCopyWithImpl<$Res, _$SearchTaskImpl>
    implements _$$SearchTaskImplCopyWith<$Res> {
  __$$SearchTaskImplCopyWithImpl(
      _$SearchTaskImpl _value, $Res Function(_$SearchTaskImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keyword = null,
  }) {
    return _then(_$SearchTaskImpl(
      null == keyword
          ? _value.keyword
          : keyword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchTaskImpl with DiagnosticableTreeMixin implements _SearchTask {
  const _$SearchTaskImpl(this.keyword);

  @override
  final String keyword;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CategoryTaskEvent.searchTask(keyword: $keyword)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CategoryTaskEvent.searchTask'))
      ..add(DiagnosticsProperty('keyword', keyword));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchTaskImpl &&
            (identical(other.keyword, keyword) || other.keyword == keyword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, keyword);

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchTaskImplCopyWith<_$SearchTaskImpl> get copyWith =>
      __$$SearchTaskImplCopyWithImpl<_$SearchTaskImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(CategoryModel categorySelected) categorySelected,
    required TResult Function(CategoryModel category) addCategory,
    required TResult Function(CategoryModel category) editCategory,
    required TResult Function(CategoryModel category) deleteCategory,
    required TResult Function(Task task) categoryTaskChanged,
    required TResult Function(String keyword) searchTask,
    required TResult Function() clearSearch,
  }) {
    return searchTask(keyword);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(CategoryModel categorySelected)? categorySelected,
    TResult? Function(CategoryModel category)? addCategory,
    TResult? Function(CategoryModel category)? editCategory,
    TResult? Function(CategoryModel category)? deleteCategory,
    TResult? Function(Task task)? categoryTaskChanged,
    TResult? Function(String keyword)? searchTask,
    TResult? Function()? clearSearch,
  }) {
    return searchTask?.call(keyword);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(CategoryModel categorySelected)? categorySelected,
    TResult Function(CategoryModel category)? addCategory,
    TResult Function(CategoryModel category)? editCategory,
    TResult Function(CategoryModel category)? deleteCategory,
    TResult Function(Task task)? categoryTaskChanged,
    TResult Function(String keyword)? searchTask,
    TResult Function()? clearSearch,
    required TResult orElse(),
  }) {
    if (searchTask != null) {
      return searchTask(keyword);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_CategorySelected value) categorySelected,
    required TResult Function(InsertNewCategory value) addCategory,
    required TResult Function(_EditCategory value) editCategory,
    required TResult Function(_DeleteCategory value) deleteCategory,
    required TResult Function(_CategoryTaskChanged value) categoryTaskChanged,
    required TResult Function(_SearchTask value) searchTask,
    required TResult Function(_ClearSearch value) clearSearch,
  }) {
    return searchTask(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_CategorySelected value)? categorySelected,
    TResult? Function(InsertNewCategory value)? addCategory,
    TResult? Function(_EditCategory value)? editCategory,
    TResult? Function(_DeleteCategory value)? deleteCategory,
    TResult? Function(_CategoryTaskChanged value)? categoryTaskChanged,
    TResult? Function(_SearchTask value)? searchTask,
    TResult? Function(_ClearSearch value)? clearSearch,
  }) {
    return searchTask?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_CategorySelected value)? categorySelected,
    TResult Function(InsertNewCategory value)? addCategory,
    TResult Function(_EditCategory value)? editCategory,
    TResult Function(_DeleteCategory value)? deleteCategory,
    TResult Function(_CategoryTaskChanged value)? categoryTaskChanged,
    TResult Function(_SearchTask value)? searchTask,
    TResult Function(_ClearSearch value)? clearSearch,
    required TResult orElse(),
  }) {
    if (searchTask != null) {
      return searchTask(this);
    }
    return orElse();
  }
}

abstract class _SearchTask implements CategoryTaskEvent {
  const factory _SearchTask(final String keyword) = _$SearchTaskImpl;

  String get keyword;

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchTaskImplCopyWith<_$SearchTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearSearchImplCopyWith<$Res> {
  factory _$$ClearSearchImplCopyWith(
          _$ClearSearchImpl value, $Res Function(_$ClearSearchImpl) then) =
      __$$ClearSearchImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearSearchImplCopyWithImpl<$Res>
    extends _$CategoryTaskEventCopyWithImpl<$Res, _$ClearSearchImpl>
    implements _$$ClearSearchImplCopyWith<$Res> {
  __$$ClearSearchImplCopyWithImpl(
      _$ClearSearchImpl _value, $Res Function(_$ClearSearchImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoryTaskEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearSearchImpl with DiagnosticableTreeMixin implements _ClearSearch {
  const _$ClearSearchImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CategoryTaskEvent.clearSearch()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', 'CategoryTaskEvent.clearSearch'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearSearchImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(CategoryModel categorySelected) categorySelected,
    required TResult Function(CategoryModel category) addCategory,
    required TResult Function(CategoryModel category) editCategory,
    required TResult Function(CategoryModel category) deleteCategory,
    required TResult Function(Task task) categoryTaskChanged,
    required TResult Function(String keyword) searchTask,
    required TResult Function() clearSearch,
  }) {
    return clearSearch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(CategoryModel categorySelected)? categorySelected,
    TResult? Function(CategoryModel category)? addCategory,
    TResult? Function(CategoryModel category)? editCategory,
    TResult? Function(CategoryModel category)? deleteCategory,
    TResult? Function(Task task)? categoryTaskChanged,
    TResult? Function(String keyword)? searchTask,
    TResult? Function()? clearSearch,
  }) {
    return clearSearch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(CategoryModel categorySelected)? categorySelected,
    TResult Function(CategoryModel category)? addCategory,
    TResult Function(CategoryModel category)? editCategory,
    TResult Function(CategoryModel category)? deleteCategory,
    TResult Function(Task task)? categoryTaskChanged,
    TResult Function(String keyword)? searchTask,
    TResult Function()? clearSearch,
    required TResult orElse(),
  }) {
    if (clearSearch != null) {
      return clearSearch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_CategorySelected value) categorySelected,
    required TResult Function(InsertNewCategory value) addCategory,
    required TResult Function(_EditCategory value) editCategory,
    required TResult Function(_DeleteCategory value) deleteCategory,
    required TResult Function(_CategoryTaskChanged value) categoryTaskChanged,
    required TResult Function(_SearchTask value) searchTask,
    required TResult Function(_ClearSearch value) clearSearch,
  }) {
    return clearSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_CategorySelected value)? categorySelected,
    TResult? Function(InsertNewCategory value)? addCategory,
    TResult? Function(_EditCategory value)? editCategory,
    TResult? Function(_DeleteCategory value)? deleteCategory,
    TResult? Function(_CategoryTaskChanged value)? categoryTaskChanged,
    TResult? Function(_SearchTask value)? searchTask,
    TResult? Function(_ClearSearch value)? clearSearch,
  }) {
    return clearSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_CategorySelected value)? categorySelected,
    TResult Function(InsertNewCategory value)? addCategory,
    TResult Function(_EditCategory value)? editCategory,
    TResult Function(_DeleteCategory value)? deleteCategory,
    TResult Function(_CategoryTaskChanged value)? categoryTaskChanged,
    TResult Function(_SearchTask value)? searchTask,
    TResult Function(_ClearSearch value)? clearSearch,
    required TResult orElse(),
  }) {
    if (clearSearch != null) {
      return clearSearch(this);
    }
    return orElse();
  }
}

abstract class _ClearSearch implements CategoryTaskEvent {
  const factory _ClearSearch() = _$ClearSearchImpl;
}

/// @nodoc
mixin _$CategoryTaskState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Task> tasks, List<CategoryModel> categories,
            List<Task> categoryTasks, CategoryModel? selectedCategory)
        loaded,
    required TResult Function(String errorMessage) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Task> tasks, List<CategoryModel> categories,
            List<Task> categoryTasks, CategoryModel? selectedCategory)?
        loaded,
    TResult? Function(String errorMessage)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Task> tasks, List<CategoryModel> categories,
            List<Task> categoryTasks, CategoryModel? selectedCategory)?
        loaded,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryTaskStateCopyWith<$Res> {
  factory $CategoryTaskStateCopyWith(
          CategoryTaskState value, $Res Function(CategoryTaskState) then) =
      _$CategoryTaskStateCopyWithImpl<$Res, CategoryTaskState>;
}

/// @nodoc
class _$CategoryTaskStateCopyWithImpl<$Res, $Val extends CategoryTaskState>
    implements $CategoryTaskStateCopyWith<$Res> {
  _$CategoryTaskStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryTaskState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$CategoryTaskStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoryTaskState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl with DiagnosticableTreeMixin implements Initial {
  const _$InitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CategoryTaskState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'CategoryTaskState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Task> tasks, List<CategoryModel> categories,
            List<Task> categoryTasks, CategoryModel? selectedCategory)
        loaded,
    required TResult Function(String errorMessage) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Task> tasks, List<CategoryModel> categories,
            List<Task> categoryTasks, CategoryModel? selectedCategory)?
        loaded,
    TResult? Function(String errorMessage)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Task> tasks, List<CategoryModel> categories,
            List<Task> categoryTasks, CategoryModel? selectedCategory)?
        loaded,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements CategoryTaskState {
  const factory Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$CategoryTaskStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoryTaskState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl with DiagnosticableTreeMixin implements Loading {
  const _$LoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CategoryTaskState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'CategoryTaskState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Task> tasks, List<CategoryModel> categories,
            List<Task> categoryTasks, CategoryModel? selectedCategory)
        loaded,
    required TResult Function(String errorMessage) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Task> tasks, List<CategoryModel> categories,
            List<Task> categoryTasks, CategoryModel? selectedCategory)?
        loaded,
    TResult? Function(String errorMessage)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Task> tasks, List<CategoryModel> categories,
            List<Task> categoryTasks, CategoryModel? selectedCategory)?
        loaded,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements CategoryTaskState {
  const factory Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<Task> tasks,
      List<CategoryModel> categories,
      List<Task> categoryTasks,
      CategoryModel? selectedCategory});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$CategoryTaskStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoryTaskState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? categories = null,
    Object? categoryTasks = null,
    Object? selectedCategory = freezed,
  }) {
    return _then(_$LoadedImpl(
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      categoryTasks: null == categoryTasks
          ? _value._categoryTasks
          : categoryTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      selectedCategory: freezed == selectedCategory
          ? _value.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as CategoryModel?,
    ));
  }
}

/// @nodoc

class _$LoadedImpl with DiagnosticableTreeMixin implements Loaded {
  const _$LoadedImpl(
      {required final List<Task> tasks,
      required final List<CategoryModel> categories,
      required final List<Task> categoryTasks,
      required this.selectedCategory})
      : _tasks = tasks,
        _categories = categories,
        _categoryTasks = categoryTasks;

  final List<Task> _tasks;
  @override
  List<Task> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  final List<CategoryModel> _categories;
  @override
  List<CategoryModel> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<Task> _categoryTasks;
  @override
  List<Task> get categoryTasks {
    if (_categoryTasks is EqualUnmodifiableListView) return _categoryTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoryTasks);
  }

  @override
  final CategoryModel? selectedCategory;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CategoryTaskState.loaded(tasks: $tasks, categories: $categories, categoryTasks: $categoryTasks, selectedCategory: $selectedCategory)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CategoryTaskState.loaded'))
      ..add(DiagnosticsProperty('tasks', tasks))
      ..add(DiagnosticsProperty('categories', categories))
      ..add(DiagnosticsProperty('categoryTasks', categoryTasks))
      ..add(DiagnosticsProperty('selectedCategory', selectedCategory));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._categoryTasks, _categoryTasks) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tasks),
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_categoryTasks),
      selectedCategory);

  /// Create a copy of CategoryTaskState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Task> tasks, List<CategoryModel> categories,
            List<Task> categoryTasks, CategoryModel? selectedCategory)
        loaded,
    required TResult Function(String errorMessage) error,
  }) {
    return loaded(tasks, categories, categoryTasks, selectedCategory);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Task> tasks, List<CategoryModel> categories,
            List<Task> categoryTasks, CategoryModel? selectedCategory)?
        loaded,
    TResult? Function(String errorMessage)? error,
  }) {
    return loaded?.call(tasks, categories, categoryTasks, selectedCategory);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Task> tasks, List<CategoryModel> categories,
            List<Task> categoryTasks, CategoryModel? selectedCategory)?
        loaded,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(tasks, categories, categoryTasks, selectedCategory);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class Loaded implements CategoryTaskState {
  const factory Loaded(
      {required final List<Task> tasks,
      required final List<CategoryModel> categories,
      required final List<Task> categoryTasks,
      required final CategoryModel? selectedCategory}) = _$LoadedImpl;

  List<Task> get tasks;
  List<CategoryModel> get categories;
  List<Task> get categoryTasks;
  CategoryModel? get selectedCategory;

  /// Create a copy of CategoryTaskState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$CategoryTaskStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoryTaskState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(_$ErrorImpl(
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl with DiagnosticableTreeMixin implements Error {
  const _$ErrorImpl({required this.errorMessage});

  @override
  final String errorMessage;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CategoryTaskState.error(errorMessage: $errorMessage)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CategoryTaskState.error'))
      ..add(DiagnosticsProperty('errorMessage', errorMessage));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  /// Create a copy of CategoryTaskState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Task> tasks, List<CategoryModel> categories,
            List<Task> categoryTasks, CategoryModel? selectedCategory)
        loaded,
    required TResult Function(String errorMessage) error,
  }) {
    return error(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Task> tasks, List<CategoryModel> categories,
            List<Task> categoryTasks, CategoryModel? selectedCategory)?
        loaded,
    TResult? Function(String errorMessage)? error,
  }) {
    return error?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Task> tasks, List<CategoryModel> categories,
            List<Task> categoryTasks, CategoryModel? selectedCategory)?
        loaded,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements CategoryTaskState {
  const factory Error({required final String errorMessage}) = _$ErrorImpl;

  String get errorMessage;

  /// Create a copy of CategoryTaskState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
