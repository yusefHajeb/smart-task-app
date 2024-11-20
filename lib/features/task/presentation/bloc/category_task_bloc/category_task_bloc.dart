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
  }) : super(CategoryTaskState.initial()) {
    on<_Started>(_started);
    on<_CategorySelected>(_categorySelected);
    on<InsertNewCategory>(_insertCategory);
    // on<_EditCategory>(_editCategory);
    // on<InsertNewCategory>(_addCategory);
  }
  Future<void> _insertCategory(
      InsertNewCategory event, Emitter<CategoryTaskState> emit) async {
    if (state is Loaded) {
      final categoryValues = state.selectedCategory;
      emit(const CategoryTaskState.loading());
      try {
        try {
          final category = event.category;
          final result = await insertCategory.call(category);
          // final categories = await insertCategory(event.category);
          final tasks = await getTasks.call(1);

          emit(CategoryTaskState.loaded(
            tasks: tasks,
            categories: result,
            categoryTasks:
                tasks.where((task) => task.category == category.name).toList(),
            selectedCategory: category,
          ));
        } catch (e) {}
      } catch (e) {}
    }
  }

  Future<void> _categorySelected(
      _CategorySelected event, Emitter<CategoryTaskState> emit) async {
    emit(const CategoryTaskState.loading());
    try {
      final categoryValues = await getCategories();
      final tasks = await getTasks.call(1);
      print('get categories');
      print(tasks);
      emit(CategoryTaskState.loaded(
        tasks: tasks,
        categories: categoryValues,
        categoryTasks: tasks
            .where((task) => task.category == event.categorySelected.name)
            .toList(),
        selectedCategory: event.categorySelected,
      ));
    } catch (e) {
      print('error catch 66');
      print(e.toString());
      // Handle error if necessary
      emit(const CategoryTaskState.loading());
    }
  }

  Future<void> _started(
      CategoryTaskEvent event, Emitter<CategoryTaskState> emit) async {
    emit(const CategoryTaskState.loading());
    try {
      final categoryValues = await getCategories();
      final tasks = await getTasks.call(1);
      print('get categories');
      print(tasks);
      emit(CategoryTaskState.loaded(
        tasks: tasks,
        categories: categoryValues,
        categoryTasks: tasks
            .where((task) => task.category == categoryValues[0].name)
            .toList(),
        selectedCategory: categoryValues[0],
      ));
    } catch (e) {
      print('error catch 66');
      print(e.toString());
      // Handle error if necessary
      emit(const CategoryTaskState.loading());
    }
    // await _getCategories(event, emit);
  }

  // Future<void> _addCategory(
  //     InsertNewCategory event, Emitter<CategoryTaskState> emit) async {
  //   emit(const CategoryTaskState.loading());
  //   final category = event.category;
  //   final result = await insertCategory.call(category);

  //   try {
  //     final categories = await insertCategory(event.category);
  //     // emit(const CategoryTaskState.success());
  //   } catch (e) {}
  // }

  Future<void> _getCategories(
      CategoryTaskEvent event, Emitter<CategoryTaskState> emit) async {
    print('get categories');
    emit(const CategoryTaskState.loading());
    try {
      final categoryValues = await getCategories();
      final tasks = await getTasks.call(1);
      print('get categories');
      print(tasks);
      emit(CategoryTaskState.loaded(
        tasks: tasks,
        categories: categoryValues,
        categoryTasks: tasks
            .where((task) => task.category == categoryValues[0].name)
            .toList(),
        selectedCategory: categoryValues[0],
      ));
    } catch (e) {
      print('error catch 66');
      print(e.toString());
      // Handle error if necessary
      emit(const CategoryTaskState.loading());
    }
  }
}
