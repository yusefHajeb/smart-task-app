import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/features/task/domain/usecases/task/add_task.dart';
import 'package:smart_task/features/task/domain/usecases/task/change_task_status.dart';
import 'package:smart_task/features/task/domain/usecases/task/get_task.dart';

import '../../../data/models/task.dart';
import '../../../domain/usecases/task/delete_task.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final InsertTaskUseCase insertTask;
  final ChangeTaskStatusUseCase changeTaskStatus;
  final FetchTaskUseCase fetchTask;
  final DeleteTaskUseCase delete;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TaskCubit({
    required this.insertTask,
    required this.changeTaskStatus,
    required this.fetchTask,
    required this.delete,
  }) : super(const TaskState.initial());

  Future<void> fetchTasks({String? selectCategory}) async {
    if (state is TaskSuccess) {
      try {
        final tasks = await fetchTask(1);
        emit((state as TaskSuccess).copyWith(tasks: tasks));
      } catch (e) {
        emit(TaskState.error(e.toString()));
      }
    } else {
      emit(const TaskState.loading());
      try {
        await Future.delayed(const Duration(milliseconds: 10))
            .whenComplete(() async {
          final tasks = await fetchTask(1);
          emit(TaskState.success(tasks, DateTime.now().day));
        });
      } catch (e) {
        emit(TaskState.error(e.toString()));
      }
    }
  }

  Future<void> updateTask(Task task) async {
    if (state is TaskSuccess) {
      await changeTaskStatus(task);
      try {
        final tasks = await fetchTask(1);
        emit((state as TaskSuccess).copyWith(tasks: tasks));
      } catch (e) {
        emit(TaskState.error(e.toString()));
      }
    }
  }

  Future<void> changeTaskStatuss(Task task) async {
    if (state is TaskSuccess) {
      await changeTaskStatus(task);
      try {
        final tasks = await fetchTask(1);
        emit((state as TaskSuccess).copyWith(tasks: tasks));
      } catch (e) {
        emit(TaskState.error(e.toString()));
      }
    }
  }

  Future<void> deleteTask(int taskId) async {
    if (state is TaskSuccess) {
      try {
        await delete(taskId);
        final tasks = await fetchTask(1);
        emit((state as TaskSuccess).copyWith(tasks: tasks));
      } catch (e) {
        emit(TaskState.error(e.toString()));
      }
    } else {
      try {
        await delete(taskId);
        await fetchTasks();
      } catch (e) {
        emit(TaskState.error(e.toString()));
      }
    }
  }

  Future<void> setSelectedCategory(String? category) async {
    emit(const TaskState.loading());
    try {
      await fetchTasks(selectCategory: category);
    } catch (e) {
      emit(TaskState.error(e.toString()));
    }
  }

  Future<void> updateTasksForSelectedDay(int day) async {
    emit(const TaskState.loading());
    try {
      final tasks = await fetchTask(day);
      emit((state as TaskSuccess).copyWith(tasks: tasks, searchByDay: day));
    } catch (e) {
      emit(TaskState.error(e.toString()));
    }
  }
}
