import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'package:smart_task/features/task/data/models/task.dart';

class TaskService {
  static final ValueNotifier<List<Task>> tasksNotifier =
      ValueNotifier<List<Task>>([]);
  static final ValueNotifier<String?> selectedCategoryNotifier =
      ValueNotifier<String?>(null);

  static List<Task> get tasks => tasksNotifier.value;
  static int get totalTasks => tasks.length;
  static int get completedTasks => tasks.where((task) => task.completed).length;
  static int get overdueTasks => tasks
      .where((task) => !task.completed && task.dueDate.isBefore(DateTime.now()))
      .length;

  static Set<String> get categories =>
      tasks.map((task) => task.category).toSet();

  static void addTask(Task task) {
    //please add task to database
    //add task to user_tasks

    //add task to tasks

    final newTasks = [...tasks, task];
    tasksNotifier.value = newTasks;
    _saveTasks();
  }

  static void toggleTask(int id) {
    final newTasks = tasks.map((task) {
      if (task.id == id) {
        return Task(
          userId: task.userId,
          id: task.id,
          title: task.title,
          description: task.description,
          category: task.category,
          dueDate: task.dueDate,
          priority: task.priority,
          completed: !task.completed,
          completedAt: !task.completed ? DateTime.now() : null,
        );
      }
      return task;
    }).toList();
    tasksNotifier.value = newTasks;
    _saveTasks();
  }

  static void deleteTask(int id) {
    final newTasks = tasks.where((task) => task.id != id).toList();
    tasksNotifier.value = newTasks;
    _saveTasks();
  }

  static void setSelectedCategory(String? category) {
    selectedCategoryNotifier.value = category;
  }

  static int getTaskCountForDay(DateTime date) {
    return tasks
        .where((task) =>
            task.completed &&
            task.completedAt != null &&
            task.completedAt!.year == date.year &&
            task.completedAt!.month == date.month &&
            task.completedAt!.day == date.day)
        .length;
  }

  static Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString('tasks');
    if (tasksJson != null) {
      final List<dynamic> decoded = json.decode(tasksJson);
      tasksNotifier.value = decoded.map((item) => Task.fromMap(item)).toList();
    }
  }

  static Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = json.encode(tasks.map((task) => task.toMap()).toList());
    await prefs.setString('tasks', tasksJson);
  }
}
