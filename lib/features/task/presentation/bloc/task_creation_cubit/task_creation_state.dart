// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_creation_cubit.dart';

class TaskCreationState {
  String? taskName;
  String? description;
  String? categoryName;
  String? priority;
  DateTime? dueDate;
  DateTime? startTime;
  DateTime? endTime;
  bool? isDailyReminder;
  List<CategoryModel> categories;
  bool? isUpdateState;

  TaskCreationState({
    this.taskName,
    this.description,
    this.categoryName,
    this.priority,
    this.dueDate,
    this.startTime,
    this.endTime,
    this.isDailyReminder,
    this.isUpdateState,
    this.categories = const [],
  });

  TaskCreationState copyWith({
    String? taskName,
    String? description,
    String? categoryName,
    String? priority,
    DateTime? dueDate,
    DateTime? startTime,
    DateTime? endTime,
    bool? isDailyReminder,
    List<CategoryModel>? categories,
    bool? isUpdateState,
  }) {
    return TaskCreationState(
      taskName: taskName ?? this.taskName,
      description: description ?? this.description,
      categoryName: categoryName ?? this.categoryName,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isDailyReminder: isDailyReminder ?? this.isDailyReminder,
      categories: categories ?? this.categories,
      isUpdateState: isUpdateState ?? this.isUpdateState,
    );
  }
}
