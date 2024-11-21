import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_task/features/task/data/models/category.dart';
import 'package:smart_task/features/task/data/models/task.dart';

import '../../../../../core/services/notifications.dart';
import '../../../domain/usecases/task/add_task.dart';
import '../../../domain/usecases/task/change_task_status.dart';
part 'task_creation_state.dart';

class TaskCreationCubit extends Cubit<TaskCreationState> {
  final InsertTaskUseCase insertTask;
  final ChangeTaskStatusUseCase update;

  NotificationService notificationService;

  TaskCreationCubit(
      {required this.insertTask,
      required this.notificationService,
      required this.update})
      : super(TaskCreationState());
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

  void initialize(Task? task) {
    if (task != null) {
      emit(state.copyWith(
        categoryName: task.category,
        description: task.description,

        /// and whether it is a daily reminder. This sets the state flag
        /// [isUpdateState] to true, indicating that the task is being
        /// updated rather than created.
        dueDate: task.dueDate,
        priority: task.priority,
        taskName: task.title,
        endTime: task.endTime,
        isUpdateState: true,
        startTime: task.startTime,
        isDailyReminder: task.isDailyReminder,
        // endTime: task.endTime,
        // startTime: task.startTime?.toTimeOfDay(),
      ));
    }
  }

  void startTimeChanged(TimeOfDay value) {
    emit(state.copyWith(
      startTime:
          DateTime.now().copyWith(hour: value.hour, minute: value.minute),
    ));
  }

  void endTimeChanged(TimeOfDay value) {
    emit(state.copyWith(
      endTime: state.dueDate?.copyWith(hour: value.hour, minute: value.minute),
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
        startTime: state.startTime ?? DateTime.now(),
        endTime: state.endTime,
        isDailyReminder: state.isDailyReminder,
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

      await notificationService.scheduleTaskReminder(task);

      if (state.isUpdateState ?? false) {
        await update(task);
        emit(state.copyWith(isUpdateState: false));
      } else {
        await insertTask(task);
        emit(state.copyWith(isUpdateState: false));
      }
    }
  }
}
