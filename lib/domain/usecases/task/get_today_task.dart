import 'package:smart_task/data/models/task.dart';

import '../../repositories/task_repository.dart';

class GetTodayTasks {
  final TaskRepository _repository;
  GetTodayTasks(this._repository);
  Future<List<Task>> call(DateTime date) async {
    return _repository.getTodayTask(date);
  }
}
