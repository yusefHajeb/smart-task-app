import 'package:smart_task/features/task/data/models/category.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> getCategories();
  Future<List<CategoryModel>> addCategory(CategoryModel category);
  // Future<List<CategoryModel>> updateCategory(CategoryModel category);
  Future<List<CategoryModel>> deleteCategory(int categoryId);
  Future<int> getCategoryCount();
  // Future<void> insertCategoryTasks(Map<String, dynamic> data);
  //uses when user add new category

  // Future<void> insertUserCategory(Map<String, dynamic> data);
}
