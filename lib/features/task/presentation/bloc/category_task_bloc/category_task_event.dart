part of 'category_task_bloc.dart';

@freezed
class CategoryTaskEvent with _$CategoryTaskEvent {
  /// Started event.
  const factory CategoryTaskEvent.started() = _Started;

  /// Category selected event.
  const factory CategoryTaskEvent.categorySelected(
      CategoryModel categorySelected) = _CategorySelected;

  /// Add category event.
  const factory CategoryTaskEvent.addCategory(CategoryModel category) =
      InsertNewCategory;

  /// Edit category event.
  const factory CategoryTaskEvent.editCategory(CategoryModel category) =
      _EditCategory;

  /// Delete category event.
  const factory CategoryTaskEvent.deleteCategory(CategoryModel category) =
      _DeleteCategory;

  /// Category task changed event.
  const factory CategoryTaskEvent.categoryTaskChanged(Task task) =
      _CategoryTaskChanged;

  /// Search task event.
  const factory CategoryTaskEvent.searchTask(String keyword) = _SearchTask;

  /// Clear search event.
  const factory CategoryTaskEvent.clearSearch() = _ClearSearch;
}
