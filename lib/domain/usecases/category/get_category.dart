import 'package:smart_task/data/models/category.dart';

import '../../repositories/category_repository.dart';

class GetCategory {
  final CategoryRepository _repository;
  GetCategory(this._repository);
  Future<List<CategoryModel>> call() async {
    return _repository.getCategories();
  }
}
