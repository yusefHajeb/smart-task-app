import 'package:smart_task/data/models/task.dart';
import 'package:smart_task/domain/repositories/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository _repository;
  UpdateTaskUseCase(this._repository);
  Future<void> call(Task task) async {
    _repository.updateTask(task);
  }
}
