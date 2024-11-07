import 'package:smart_task/data/models/task.dart';
import 'package:smart_task/domain/repositories/task_repository.dart';

class InsertTask {
  final TaskRepository _taskRepository;

  InsertTask(this._taskRepository);

  Future<void> call(Task task) async {
    await _taskRepository.insertTask(task.toMap());
  }
}
