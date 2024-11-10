import 'package:smart_task/features/task/data/models/category.dart';
import 'package:smart_task/features/task/domain/repositories/category_repository.dart';

class AddCategoryUseCase {
  final CategoryRepository _repository;
  AddCategoryUseCase(this._repository);
  Future<void> call(CategoryModel category) async {
    _repository.addCategory(category);
  }
}
