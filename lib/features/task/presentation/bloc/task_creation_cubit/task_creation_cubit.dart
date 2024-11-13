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

  void dueDateChanged(DateTime value) {
    emit(state.copyWith(dueDate: value));
  }

  void submit() async {
    if (formKey.currentState?.validate() ?? false) {
      await insertTask(
        Task(
          title: state.taskName ?? '',
          completed: false,
          completedAt: DateTime.now(),
          userId: 1,
          id: DateTime.now().millisecondsSinceEpoch,
          description: state.description ?? '',
          category: state.categoryName ?? '',
          dueDate: state.dueDate ?? DateTime.now(),
          priority: state.priority ?? '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    }
  }
}
