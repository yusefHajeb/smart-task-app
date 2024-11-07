import 'package:smart_task/data/models/category.dart';
import 'package:smart_task/domain/repositories/category_repository.dart';

class GetCategories {
  final CategoryRepository _repository;
  GetCategories(this._repository);
  Future<List<CategoryModel>> call() async {
    return _repository.getCategories();
  }
}
