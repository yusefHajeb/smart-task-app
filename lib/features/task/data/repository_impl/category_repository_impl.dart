import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:smart_task/features/task/data/datasources/base_database.dart';
import 'package:smart_task/features/task/data/models/category.dart';
import 'package:smart_task/features/task/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final SqfliteDatabase database;
  CategoryRepositoryImpl(this.database);
  static final ValueNotifier<List<CategoryModel>> categoryNotifier =
      ValueNotifier<List<CategoryModel>>([]);
  static final ValueNotifier<String?> selectedCategoryNotifier =
      ValueNotifier<String?>(null);
  @override
  Future<List<CategoryModel>> addCategory(CategoryModel category) async {
    database.insert('categories', category.toMap());
    final categories = await database.getAllCategories();

    return Future.value(
        categories.map((map) => CategoryModel.fromMap(map)).toList());
  }

  @override
  Future<List<CategoryModel>> deleteCategory(int categoryId) async {
    await database.delete('categories',
        where: 'category_id = ?', whereArgs: [categoryId]);
    final categories = await database.getAllCategories();
    return Future.value(
        categories.map((category) => CategoryModel.fromMap(category)).toList());
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final categories = await database.getAllCategories();

    return Future.value(
        categories.map((map) => CategoryModel.fromMap(map)).toList());
  }

  @override
  Future<int> getCategoryCount() {
    return Future.value(categoryNotifier.value.length);
  }

  // @override
  // Future<List<CategoryModel>> insertCategoryTasks(Map<String, dynamic> data) {
  //   database.insertCategoryTasks(data);

  //   return Future.value();
  // }

  // @override
  // Future<List<CategoryModel>> insertUserCategory(
  //     Map<String, dynamic> data) async {
  //   await database.insertUserCategories(data);
  //   return Future.value();
  // }

  // @override
  // Future<List<CategoryModel>> updateCategory(CategoryModel category) async {
  //   database.update('categories', category.toMap());
  //   return Future.value();
  // }
}

extension on List<CategoryModel> {
  FutureOr<CategoryModel?> firstWhereOrNull(
      bool Function(CategoryModel element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
