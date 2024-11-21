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
    emit(const TaskState.loading());
    try {
      await Future.delayed(const Duration(milliseconds: 10))
          .whenComplete(() async {
        final tasks = await fetchTask(1);
        emit(TaskState.success(tasks, selectCategory));
      });
    } catch (e) {
      emit(TaskState.error(e.toString()));
    }
  }

  Future<void> updateTask(Task task) async {
    emit(const TaskState.loading());
    try {
      await changeTaskStatus(task);
      await Future.delayed(const Duration(milliseconds: 10))
          .whenComplete(() async {
        await fetchTasks();
      });
    } catch (e) {
      emit(TaskState.error(e.toString()));
    }
  }

  Future<void> deleteTask(int taskId) async {
    emit(const TaskState.loading());
    try {
      await delete(taskId);
      await fetchTasks();
    } catch (e) {
      emit(TaskState.error(e.toString()));
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
}
