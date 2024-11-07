import 'package:smart_task/data/models/category.dart';

import '../../repositories/category_repository.dart';

class GetCategory {
  final CategoryRepository _repository;
  GetCategory(this._repository);
  Future<CategoryModel?> call(int categoryId) async {
    return _repository.getCategory(categoryId);
  }
}
