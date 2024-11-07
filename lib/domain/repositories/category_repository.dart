import 'package:smart_task/data/models/category.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> getCategories();
  Future<CategoryModel?> getCategory(int categoryId);
  Future<void> addCategory(CategoryModel category);
  Future<void> updateCategory(CategoryModel category);
  Future<void> deleteCategory(int categoryId);
  Future<int> getCategoryCount();
  Future<void> insertCategoryTasks(Map<String, dynamic> data);
  //uses when user add new category

  Future<void> insertUserCategory(Map<String, dynamic> data);
}
