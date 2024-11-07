import 'package:smart_task/domain/repositories/category_repository.dart';

class DeleteCategory {
  final CategoryRepository _repository;
  DeleteCategory(this._repository);
  Future<void> call(int categoryId) async {
    _repository.deleteCategory(categoryId);
  }
}
