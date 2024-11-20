import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_task/features/task/data/models/task.dart';

import '../../../domain/usecases/task/add_task.dart';
part 'task_creation_state.dart';

class TaskCreationCubit extends Cubit<TaskCreationState> {
  final InsertTaskUseCase insertTask;
  TaskCreationCubit(
    this.insertTask,
  ) : super(TaskCreationState());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void taskNameChanged(String value) {
    emit(state.copyWith(taskName: value));
  }

  void descriptionChanged(String value) {
    emit(state.copyWith(description: value));
  }

  void categoryChanged(String value) {
    emit(state.copyWith(categoryName: value));
  }

  void priorityChanged(String value) {
    emit(state.copyWith(priority: value));
  }

  void dueDateChanged(value) {
    emit(state.copyWith(
      dueDate: value,
    ));
  }

  void updateTask(Task task) {
    emit(state.copyWith(
      categoryName: task.category,
      description: task.description,
      dueDate: task.dueDate,
      priority: task.priority,
      taskName: task.title,
      // endTime: task.endTime,
      // startTime: task.startTime?.toTimeOfDay(),
    ));
  }

  void startTimeChanged(TimeOfDay value) {
    emit(state.copyWith(
      startTime: value,
    ));
  }

  void endTimeChanged(TimeOfDay value) {
    emit(state.copyWith(
      endTime: value,
    ));
  }

  void isDailyReminderChanged(bool value) {
    emit(state.copyWith(isDailyReminder: value));
  }

  void submit() async {
    if (formKey.currentState?.validate() ?? false) {
      final task = Task(
        title: state.taskName ?? '',
        completed: false,
        startTime: DateTime.now().copyWith(
            hour: state.startTime?.hour, minute: state.startTime?.minute),
        endTime: state.dueDate?.copyWith(
            hour: state.endTime?.hour, minute: state.endTime?.minute),
        isDailyReminder: true,
        completedAt: DateTime.now(),
        userId: 1,
        id: DateTime.now().millisecondsSinceEpoch,
        description: state.description ?? '',
        category: state.categoryName ?? '',
        dueDate: state.dueDate ?? DateTime.now(),
        priority: state.priority ?? '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      // await NotificationService().scheduleTaskReminder(task);

      await insertTask(task);
    }
  }
}
