import 'package:smart_task/features/task/data/models/task.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository _repository;
  UpdateTaskUseCase(this._repository);
  Future<void> call(Task task) async {
    _repository.updateTask(task);
  }
}
