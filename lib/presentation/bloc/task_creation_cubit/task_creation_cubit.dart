import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:smart_task/data/models/task.dart';
import 'package:smart_task/domain/usecases/task/add_task.dart';
import 'package:smart_task/domain/usecases/task/update_task.dart';

part 'task_creation_state.dart ';

class TasKCreationCubit extends Cubit<TasKCreationState> {
  final InsertTaskUseCase insertTask;
  final UpdateTaskUseCase updateTask;

  TasKCreationCubit({required this.insertTask, required this.updateTask})
      : super(TasKCreationInitial());
  TextEditingController taskNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String categoryName = 'Work';
  String priority = 'Medium';
  DateTime dueDate = DateTime.now();
  void updateTaskName(String value) {
    taskNameController.text = value;
  }

  void updateDescription(String value) {
    descriptionController.text = value;
  }

  void updateCategory(String value) {
    categoryName = value;
  }

  void updatePriority(String value) {
    priority = value;
  }

  void updateDueDate(DateTime value) {
    dueDate = value;
  }

  void update(int id) async {
    if (taskNameController.text.isEmpty) {
      return;
    }
    await updateTask(
      Task(
        userId: 1,
        id: id,
        title: taskNameController.text,
        description: descriptionController.text,
        category: categoryName,
        dueDate: dueDate,
        priority: priority,
      ),
    );
  }

  void submit() async {
    if (taskNameController.text.isEmpty) {
      return;
    }
    await insertTask(
      Task(
        userId: 1,
        id: DateTime.now().millisecondsSinceEpoch,
        title: taskNameController.text,
        description: descriptionController.text,
        category: categoryName,
        dueDate: dueDate,
        priority: priority,
      ),
    );
  }
}
