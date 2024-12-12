import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smart_task/features/task/data/datasources/base_database.dart';
import 'package:smart_task/features/task/data/models/task.dart';
import '../../domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final SqfliteDatabase database;

  static final ValueNotifier<String?> selectedCategoryNotifier =
      ValueNotifier<String?>(null);

  TaskRepositoryImpl(this.database);

  @override
  Future<List<Task>> getTasks(int userId) async {
    final tasks = await database.getTasks(userId);

    return tasks.map((task) => Task.fromMap(task)).toList();
  }

  @override
  Future<void> insertTask(Task task) async {
    print('task to Map');
    print(task.toMap());
    database.insert('tasks', task.toMap());

    database.insertUserTasks({'task_id': task.id, 'user_id': 1});

    return Future.value();
  }

  @override
  Future<Task> updateTask(Task task) async {
    log(task.toMap().toString());
    try {
      await database.update('tasks', task.toMap(), where: 'id = ${task.id}');
      return task;
    } catch (e, s) {
      print('\x1B[31mError: ${e.toString()}\n$s\x1B[0m');
      return task;
    }
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

  @override
  Future<Task> changeTaskStatus(Task task) async {
    database.update(
        'tasks',
        task
            .copyWith(
                completed: !task.completed,
                completedAt:
                    !task.completed ? DateTime.now() : task.completedAt)
            .toMap(),
        where: 'id = ${task.id}');
    return Future.value(task);
  }
}
