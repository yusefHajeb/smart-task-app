import 'package:smart_task/domain/repositories/task_repository.dart';

class DeleteTask {
  final TaskRepository _repository;
  DeleteTask(this._repository);
  Future<void> call(int taskId) async {
    _repository.deleteTask(taskId);
  }
}
