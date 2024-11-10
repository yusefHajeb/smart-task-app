import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/features/task/data/models/task.dart';
import 'package:smart_task/features/task/domain/usecases/task/add_task.dart';
import 'package:smart_task/features/task/domain/usecases/task/update_task.dart';

part 'task_creation_state.dart';

class TasKCreationCubit extends Cubit<TasKCreationState> {
  final InsertTaskUseCase insertTask;
  final UpdateTaskUseCase updateTask;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TasKCreationCubit({required this.insertTask, required this.updateTask})
      : super(TasKCreationState());

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
          completed: false,
          completedAt: DateTime.now(),
          userId: 1,
          id: DateTime.now().millisecondsSinceEpoch,
          title: state.taskName ?? '',
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
