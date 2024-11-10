part of 'task_creation_cubit.dart';

class TasKCreationState {
  final String? taskName;
  final String? description;
  final String? categoryName;
  final String? priority;
  final DateTime? dueDate;

  const TasKCreationState({
    this.taskName,
    this.description,
    this.categoryName,
    this.priority,
    this.dueDate,
  });

  TasKCreationState copyWith({
    String? taskName,
    String? description,
    String? categoryName,
    String? priority,
    DateTime? dueDate,
  }) =>
      TasKCreationState(
        taskName: taskName ?? this.taskName,
        description: description ?? this.description,
        categoryName: categoryName ?? this.categoryName,
        priority: priority ?? this.priority,
        dueDate: dueDate ?? this.dueDate,
      );
}
