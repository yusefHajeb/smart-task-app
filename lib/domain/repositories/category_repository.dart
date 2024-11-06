import 'package:smart_task/data/models/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<Category?> getCategory(int categoryId);
  Future<void> addCategory(Category category);
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(int categoryId);
  Future<int> getCategoryCount();
  Future<void> insertCategoryTasks(Map<String, dynamic> data);
  //uses when user add new category

  Future<void> insertUserCategory(Map<String, dynamic> data);
}
