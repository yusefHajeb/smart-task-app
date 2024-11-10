import 'package:smart_task/features/task/domain/repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;
  DeleteTaskUseCase(this.repository);
  Future<void> call(int taskId) async {
    repository.deleteTask(taskId);
  }
}
