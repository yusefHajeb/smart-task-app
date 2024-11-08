import 'package:flutter/material.dart';
import 'package:smart_task/data/datasources/base_database.dart';
import 'package:smart_task/data/models/task.dart';

import '../../domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final SqfliteDatabase database;
  static final ValueNotifier<List<Task>> tasksNotifier =
      ValueNotifier<List<Task>>([]);
  static final ValueNotifier<String?> selectedCategoryNotifier =
      ValueNotifier<String?>(null);

  TaskRepositoryImpl(this.database);

  @override
  Future<List<Task>> getTasks(int userId) async {
    final tasks = await database.getTasks(userId);

    tasksNotifier.value = tasks.map((task) => Task.fromMap(task)).toList();
    // return tasks.map((task) => Task.fromMap(task)).toList();
    return tasksNotifier.value;
  }

  @override
  Future<void> insertTask(Map<String, dynamic> data) {
    final task = Task.fromMap(data);
    database.insert('tasks', task.toMap());
    tasksNotifier.value = [...tasksNotifier.value, task];
    return Future.value();
  }

  @override
  Future<void> updateTask(Task task) {
    database.update('tasks', task.toMap());
    tasksNotifier.value = tasksNotifier.value.map((task) {
      if (task.id == task.id) {
        return task;
      }
      return task;
    }).toList();
    return Future.value();
  }

  @override
  Future<List<Task>> getTasksByCategory(String category) async {
    final tasks = await database
        .query('tasks', where: 'category = ?', whereArgs: [category]);

    return tasks.map((task) => Task.fromMap(task)).toList();
  }

  @override
  Future<void> deleteTask(int taskId) {
    database.delete('tasks', where: 'id = ?', whereArgs: [taskId]);
    return Future.value();
  }

  @override
  Future<List<Task>> getTodayTask(DateTime date) async {
    return await getTasks(2).then((onValue) {
      return onValue.where((task) => task.dueDate == date).toList();
    });
  }
}
