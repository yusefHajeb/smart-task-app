import 'package:smart_task/data/models/task.dart';
import 'package:smart_task/domain/repositories/task_repository.dart';

class InsertTaskUseCase {
  final TaskRepository _taskRepository;

  InsertTaskUseCase(this._taskRepository);

  Future<void> call(Task task) async {
    await _taskRepository.insertTask(task.toMap());
  }
}
