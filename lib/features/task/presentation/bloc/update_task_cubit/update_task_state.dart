// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'update_task_cubit.dart';

@freezed
class UpdateTaskState {
  final Task? task;
  final String? error;
  final List<CategoryModel>? categories;
  const UpdateTaskState({this.task, this.error, this.categories});

  UpdateTaskState copyWith({
    Task? task,
    String? error,
    List<CategoryModel>? categories,
  }) {
    return UpdateTaskState(
      categories: categories ?? this.categories,
      task: task ?? this.task,
      error: error ?? this.error,
    );
  }
}
