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
  Future<void> addCategory(CategoryModel category) {
    database.insert('categories', category.toMap());
    return Future.value();
  }

  @override
  Future<void> deleteCategory(int categoryId) {
    categoryNotifier.value = categoryNotifier.value.where((category) {
      return category.categoryId != categoryId;
    }).toList();
    database
        .delete('categories', where: 'categoryId = ?', whereArgs: [categoryId]);
    return Future.value();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final maps = await database.query('categories');
    categoryNotifier.value =
        maps.map((map) => CategoryModel.fromMap(map)).toList();
    return categoryNotifier.value;
  }

  @override
  Future<int> getCategoryCount() {
    return Future.value(categoryNotifier.value.length);
  }

  @override
  Future<void> insertCategoryTasks(Map<String, dynamic> data) {
    database.insertCategoryTasks(data);
    return Future.value();
  }

  @override
  Future<void> insertUserCategory(Map<String, dynamic> data) async {
    await database.insertUserCategories(data);
    return Future.value();
  }

  @override
  Future<void> updateCategory(CategoryModel category) async {
    database.update('categories', category.toMap());
    return Future.value();
  }
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
