import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_task/features/task/data/models/category.dart';
import 'package:smart_task/features/task/data/models/task.dart';
import 'package:smart_task/features/task/domain/usecases/task/update_task.dart';

import '../../../../../core/services/notifications.dart';
import '../../../domain/usecases/category/get_categories.dart';
import '../../../domain/usecases/task/add_task.dart';
import '../../../domain/usecases/task/change_task_status.dart';
part 'task_creation_state.dart';

class TaskCreationCubit extends Cubit<TaskCreationState> {
  final InsertTaskUseCase insertTask;
  final ChangeTaskStatusUseCase changeStatus;
  final UpdateTaskUseCase updateTaskUseCase;
  final NotificationService notificationService;
  GetCategoriesUseCase getCategories;

  TaskCreationCubit({
    required this.insertTask,
    required this.notificationService,
    required this.changeStatus,
    required this.getCategories,
    required this.updateTaskUseCase,
  }) : super(TaskCreationState());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void taskNameChanged(String value) {
    final task = state.task?.copyWith(title: value);
    emit(state.copyWith(task: task));
  }

  void descriptionChanged(String value) {
    final task = state.task?.copyWith(description: value);
    emit(state.copyWith(task: task));
  }

  void categoryChanged(String value) {
    final task = state.task?.copyWith(category: value);
    emit(state.copyWith(task: task));
  }

  void priorityChanged(String value) {
    final task = state.task?.copyWith(priority: value);
    emit(state.copyWith(task: task));
  }

  void dueDateChanged(DateTime value) {
    final task = state.task?.copyWith(dueDate: value);
    emit(state.copyWith(
      task: task,
    ));
  }

  void reminderMinutes(int minutes) {
    final task = state.task?.copyWith(reminderMinutes: minutes);
    emit(state.copyWith(
      task: task,
    ));
  }

  Future<void> initialize(Task? task) async {
    final categories = await getCategories();
    if (task != null) {
      print(task.toMap());
      emit(state.copyWith(
        categories: categories,
        task: task,
        isUpdateState: true,
      ));
    } else {
      emit(state.copyWith(categories: categories, task: Task.toEmpty()));
    }
  }

  void startTimeChanged(TimeOfDay value) {
    final task = state.task?.copyWith(
        startTime: state.task?.dueDate
            .copyWith(hour: value.hour, minute: value.minute));
    emit(state.copyWith(
      task: task,
    ));
  }

  void endTimeChanged(TimeOfDay value) {
    final task = state.task?.copyWith(
        endTime: state.task?.dueDate
            .copyWith(hour: value.hour, minute: value.minute));
    emit(
      state.copyWith(task: task),
    );
  }

  void isDailyReminderChanged(bool value) {
    final task = state.task?.copyWith(isDailyReminder: value);
    emit(state.copyWith(task: task));
  }

  Future<void> submit() async {
    if (formKey.currentState!.validate() && state.task != null) {
      if (state.isUpdateState ?? false) {
        final task = state.task?.copyWith(
          updatedAt: DateTime.now(),
        );
        await updateTaskUseCase(task!);
        emit(state.copyWith(isUpdateState: false, task: Task.toEmpty()));
      } else {
        try {
          final task = state.task?.copyWith(
              createdAt: DateTime.now(),
              id: DateTime.now().millisecondsSinceEpoch);
          await notificationService.scheduleTaskReminder(task!);
          await insertTask(task);
          emit(state.copyWith(isUpdateState: false, task: Task.toEmpty()));
        } catch (e) {
          print("catch e");
          print(e.toString());
        }
      }
    }
  }
}
