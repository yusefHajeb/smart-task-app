import '../../../data/models/task.dart';
import '../../repositories/task_repository.dart';

class ChangeTaskStatusUseCase {
  final TaskRepository _repository;
  ChangeTaskStatusUseCase(this._repository);

  Future<Task> call(Task task) async {
    return _repository.changeTaskStatus(task);
  }
}
