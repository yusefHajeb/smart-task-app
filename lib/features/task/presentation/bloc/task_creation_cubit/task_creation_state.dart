// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_creation_cubit.dart';

class TaskCreationState {
  String? taskName;
  String? description;
  String? categoryName;
  String? priority;
  DateTime? dueDate;
  TaskCreationState({
    this.taskName,
    this.description,
    this.categoryName,
    this.priority,
    this.dueDate,
  });

  TaskCreationState copyWith({
    String? taskName,
    String? description,
    String? categoryName,
    String? priority,
    DateTime? dueDate,
  }) {
    return TaskCreationState(
      taskName: taskName ?? this.taskName,
      description: description ?? this.description,
      categoryName: categoryName ?? this.categoryName,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
