import 'package:smart_task/domain/repositories/category_repository.dart';

class DeleteCategoryUseCase {
  final CategoryRepository _repository;
  DeleteCategoryUseCase(this._repository);
  Future<void> call(int categoryId) async {
    _repository.deleteCategory(categoryId);
  }
}
