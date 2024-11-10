import 'package:smart_task/features/task/data/models/category.dart';

import '../../repositories/category_repository.dart';

class GetCategoryUseCase {
  final CategoryRepository _repository;
  GetCategoryUseCase(this._repository);
  Future<List<CategoryModel>> call() async {
    return _repository.getCategories();
  }
}
