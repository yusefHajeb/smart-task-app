import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_task/features/task/data/models/task.dart';
import 'package:smart_task/features/task/domain/usecases/category/add_category.dart';
import 'package:smart_task/features/task/domain/usecases/category/get_categories.dart';
import 'package:smart_task/features/task/domain/usecases/task/get_task.dart';

import '../../../data/models/category.dart';
import '../../../domain/usecases/category/delete_category.dart';

part 'category_task_event.dart';
part 'category_task_state.dart';
part 'category_task_bloc.freezed.dart';

class CategoryTaskBloc extends Bloc<CategoryTaskEvent, CategoryTaskState> {
  AddCategoryUseCase insertCategory;
  GetCategoriesUseCase getCategories;
  DeleteCategoryUseCase deleteCategory;
  FetchTaskUseCase getTasks;

  CategoryTaskBloc({
    required this.insertCategory,
    required this.getCategories,
    required this.deleteCategory,
    required this.getTasks,
  }) : super(const CategoryTaskState.initial()) {
    on<_Started>(_started);
    on<_CategorySelected>(_categorySelected);
    on<InsertNewCategory>(_insertCategory);
    on<_DeleteCategory>(_deleteCategory);
    on<_CategoryTaskChanged>(_categoryTaskChanged);
  }
  Future<void> _insertCategory(
      InsertNewCategory event, Emitter<CategoryTaskState> emit) async {
    if (state is Loaded) {
      final oldState = state as Loaded;

      try {
        final category = event.category;
        final result = await insertCategory(category);
        final tasks = await getTasks(1);

        if (!listEquals(oldState.categories, result)) {
          emit(CategoryTaskState.loaded(
            tasks: tasks,
            categories: result,
            categoryTasks:
                tasks.where((task) => task.category == category.name).toList(),
            selectedCategory: category,
          ));
        } else {
          emit(oldState);
        }
      } catch (e) {
        emit(const CategoryTaskState.error(errorMessage: 'Error'));
      }
    }
  }

  Future<void> _categorySelected(
      _CategorySelected event, Emitter<CategoryTaskState> emit) async {
    if (state is Loaded) {
      final currentState = state as Loaded;
      final selectedCategory = event.categorySelected;
      if (selectedCategory == currentState.selectedCategory) return;

      try {
        final tasks = await getTasks.call(1);
        final categoryTasks = tasks
            .where((task) => task.category == selectedCategory.name)
            .toList();
        emit(currentState.copyWith(
          selectedCategory: selectedCategory,
          tasks: tasks,
          categoryTasks: categoryTasks,
        ));
      } catch (e) {
        emit(const CategoryTaskState.loading());
      }
    }
  }

  Future<void> _started(
      CategoryTaskEvent event, Emitter<CategoryTaskState> emit) async {
    emit(const CategoryTaskState.loading());
    try {
      final categories = await getCategories();
      final tasks = await getTasks.call(1);

      final selectedCategory = categories.first;
      final categoryTasks = tasks
          .where((task) => task.category == selectedCategory.name)
          .toList();

      emit(CategoryTaskState.loaded(
        tasks: tasks,
        categories: categories,
        categoryTasks: categoryTasks,
        selectedCategory: selectedCategory,
      ));
    } on Exception catch (e) {
      print('error catch 66');
      print(e.toString());
      // Handle error if necessary
      emit(const CategoryTaskState.error(errorMessage: 'Error'));
    }
  }

  Future<void> _getCategories(
      CategoryTaskEvent event, Emitter<CategoryTaskState> emit) async {
    emit(const CategoryTaskState.loading());
    try {
      final categoryValues = await getCategories();
      final tasks = await getTasks.call(1);
      emit(
        CategoryTaskState.loaded(
          tasks: tasks,
          categories: categoryValues,
          categoryTasks: tasks
              .where((task) => task.category == categoryValues[0].name)
              .toList(),
          selectedCategory: categoryValues[0],
        ),
      );
    } catch (e) {
      emit(const CategoryTaskState.loading());
    }
  }

  Future<void> _deleteCategory(
      _DeleteCategory event, Emitter<CategoryTaskState> emit) async {
    if (state is Loaded) {
      final oldState = state as Loaded;
      final delete = await deleteCategory(event.category.categoryId);
      final newTasks = oldState.tasks
          .where((task) => task.category != event.category.name)
          .toList();
      emit((state as Loaded).copyWith(
        tasks: newTasks,
        categories: delete,
        categoryTasks: oldState.categoryTasks
            .where((task) => task.category != event.category.name)
            .toList(),
      ));
    }
  }

  Future<void> _categoryTaskChanged(
      _CategoryTaskChanged event, Emitter<CategoryTaskState> emit) async {
    if (state is Loaded) {
      final tasks = await getTasks.call(1);
      final categoryTasks =
          tasks.where((task) => task.category == event.task.category).toList();
      emit((state as Loaded)
          .copyWith(categoryTasks: categoryTasks, tasks: tasks));
    }
  }
}
