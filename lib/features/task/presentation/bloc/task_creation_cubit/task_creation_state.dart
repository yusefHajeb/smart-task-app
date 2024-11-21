// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_creation_cubit.dart';

class TaskCreationState {
  bool? isDailyReminder;
  List<CategoryModel> categories;
  bool? isUpdateState;
  Task? task;
  TaskCreationState({
    this.task,
    this.isDailyReminder,
    this.isUpdateState,
    this.categories = const [],
  });

  TaskCreationState copyWith({
    bool? isDailyReminder,
    List<CategoryModel>? categories,
    bool? isUpdateState,
    Task? task,
  }) {
    return TaskCreationState(
      isDailyReminder: isDailyReminder ?? this.isDailyReminder,
      categories: categories ?? this.categories,
      isUpdateState: isUpdateState ?? this.isUpdateState,
      task: task ?? this.task,
    );
  }
}
