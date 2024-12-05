import '../../../data/models/task.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_state.freezed.dart';

@freezed
class TaskState with _$TaskState {
  const factory TaskState.initial() = _Initial;
  const factory TaskState.success(
    List<Task> tasks,
    int? searchByDay,
  ) = TaskSuccess;

  const factory TaskState.loading() = TaskLoading;
  const factory TaskState.error(String message) = TaskError;
  const TaskState._(); // Private constructor for additional methods
}

extension TaskSuccessCopyWith on TaskSuccess {
  TaskSuccess copyWith({
    List<Task>? tasks,
  }) {
    return TaskSuccess(tasks ?? this.tasks, null);
  }
}
