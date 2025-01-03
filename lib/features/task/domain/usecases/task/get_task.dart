import 'package:smart_task/features/task/data/models/task.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';

class FetchTaskUseCase {
  final TaskRepository _repository;
  FetchTaskUseCase(this._repository);
  Future<List<Task>> call(int taskId) async {
    return _repository.getTasks(taskId);
  }
}
