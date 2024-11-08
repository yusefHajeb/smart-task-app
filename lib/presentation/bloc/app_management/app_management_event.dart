part of 'app_management_bloc.dart';

@immutable
sealed class AppManagementEvent {}

class TaskAdded extends AppManagementEvent {
  final Task task;

  TaskAdded(this.task);
}

class TaskUpdated extends AppManagementEvent {
  final Task task;
  TaskUpdated(this.task);
}

class TaskDeleted extends AppManagementEvent {
  final int taskId;
  TaskDeleted(this.taskId);
}

class TasksRetrieved extends AppManagementEvent {
  final int userId;
  TasksRetrieved(this.userId);
}

class TaskDetailsRetrieved extends AppManagementEvent {
  final int taskId;
  TaskDetailsRetrieved(this.taskId);
}

class TaskStatusUpdated extends AppManagementEvent {
  final int taskId;
  final bool completed;
  TaskStatusUpdated(this.taskId, this.completed);
}

class CategoryAdded extends AppManagementEvent {
  final String category;
  CategoryAdded(this.category);
}

class CategoryUpdated extends AppManagementEvent {
  final String category;
  CategoryUpdated(this.category);
}

class CategoryDeleted extends AppManagementEvent {
  final int categoryId;
  CategoryDeleted(this.categoryId);
}
