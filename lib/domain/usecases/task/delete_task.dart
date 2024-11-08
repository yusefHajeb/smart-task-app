import 'package:smart_task/domain/repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository _repository;
  DeleteTaskUseCase(this._repository);
  Future<void> call(int taskId) async {
    _repository.deleteTask(taskId);
  }
}
