import 'package:smart_task/features/task/data/models/category.dart';
import 'package:smart_task/features/task/domain/repositories/category_repository.dart';

class AddCategoryUseCase {
  final CategoryRepository _repository;
  AddCategoryUseCase(this._repository);
  Future<List<CategoryModel>> call(CategoryModel category) async {
    return _repository.addCategory(category);
  }
}
