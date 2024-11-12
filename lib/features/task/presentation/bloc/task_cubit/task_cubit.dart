import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/features/task/domain/usecases/task/add_task.dart';
import 'package:smart_task/features/task/domain/usecases/task/get_task.dart';
import 'package:smart_task/features/task/domain/usecases/task/update_task.dart';

import '../../../data/models/task.dart';
import 'task_creation_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final InsertTaskUseCase insertTask;
  final UpdateTaskUseCase updateTaskUseCase;
  final FetchTaskUseCase fetchTask;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TaskCubit({
    required this.insertTask,
    required this.updateTaskUseCase,
    required this.fetchTask,
  }) : super(const TaskState.initial());

  Future<void> fetchTasks() async {
    emit(const TaskState.loading());
    try {
      final tasks = await fetchTask(1);
      emit(TaskState.success(tasks));
    } catch (e) {
      emit(TaskState.error(e.toString()));
    }
  }

  //update task
  Future<void> updateTask(Task task) async {
    // emit(const TaskState.loading());
    try {
      await updateTaskUseCase(task).whenComplete(
        () async {
          // await fetchTasks().then(
          // (onValue) {
          if (state is TaskSuccess) {
            final newTasks = (state as TaskSuccess).tasks.map((oldTask) {
              if (oldTask.id == task.id) {
                return task.copyWith(completed: true);
              }
              return task;
            }).toList();
            emit(const TaskState.loading());
            emit(TaskState.success(newTasks));
          } else {
            emit(TaskState.loading());
          }
        },
      );
      // });
    } catch (e) {
      emit(TaskState.error(e.toString()));
    }
  }
}
