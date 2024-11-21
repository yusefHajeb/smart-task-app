import 'package:smart_task/features/task/data/models/category.dart';
import 'package:smart_task/features/task/domain/repositories/category_repository.dart';

class DeleteCategoryUseCase {
  final CategoryRepository _repository;
  DeleteCategoryUseCase(this._repository);
  Future<List<CategoryModel>> call(int categoryId) async {
    return _repository.deleteCategory(categoryId);
  }
}
