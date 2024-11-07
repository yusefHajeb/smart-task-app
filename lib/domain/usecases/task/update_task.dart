import 'package:smart_task/data/models/task.dart';
import 'package:smart_task/domain/repositories/task_repository.dart';

class UpdateTask {
  final TaskRepository _repository;
  UpdateTask(this._repository);
  Future<void> call(Task task) async {
    _repository.updateTask(task);
  }
}
