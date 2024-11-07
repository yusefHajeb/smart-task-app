import 'package:smart_task/data/models/task.dart';
import 'package:smart_task/domain/repositories/task_repository.dart';

class GetTask {
  final TaskRepository _repository;
  GetTask(this._repository);
  Future<List<Task>> call(int taskId) async {
    return _repository.getTasks(taskId);
  }
}
