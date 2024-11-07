import 'package:smart_task/data/models/category.dart';
import 'package:smart_task/domain/repositories/category_repository.dart';

class AddCategory {
  final CategoryRepository _repository;
  AddCategory(this._repository);
  Future<void> call(CategoryModel category) async {
    _repository.addCategory(category);
  }
}
