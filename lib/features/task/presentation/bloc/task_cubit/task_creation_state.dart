import '../../../data/models/task.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_creation_state.freezed.dart';

@freezed
class TaskState with _$TaskState {
  const factory TaskState.initial() = _Initial;
  const factory TaskState.success(
    List<Task> tasks,
    String? selectedCategory,
  ) = TaskSuccess;

  const factory TaskState.loading() = TaskLoading;
  const factory TaskState.error(String message) = TaskError;
  const TaskState._(); // Private constructor for additional methods
}
