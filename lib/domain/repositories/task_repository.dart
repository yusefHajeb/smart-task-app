import 'package:smart_task/data/models/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();

  Future<void> insertTask(Map<String, dynamic> data);
  Future<void> updateTask(Map<String, dynamic> data);
}

// Future<void> insertTask(Map<String, dynamic> data);
//   Future<void> updateTask(Map<String, dynamic> data);
//   Future<void> deleteTask(String id);
//   Future<List<Map<String, dynamic>>> getTasks();
//   Future<List<Map<String, dynamic>>> getTasksByCategory(String category);
//   Future<List<Map<String, dynamic>>> getTasksByPriority(String priority);
//   Future<List<Map<String, dynamic>>> getTasksByDate(DateTime date);
//   Future<List<Map<String, dynamic>>> getTasksByDateAndCategory(
//       DateTime date, String category);
//   Future<List<Map<String, dynamic>>> getTasksByDateAndPriority(
//       DateTime date, String priority);
//   Future<List<Map<String, dynamic>>> getTasksByDateAndCategoryAndPriority(
//       DateTime date, String category, String priority);
//   Future<List<Map<String, dynamic>>> getOverdueTasks();
//   Future<List<Map<String, dynamic>>> getCompletedTasks();
//   Future<int> getTotalTasks();
//   Future<int> getTasksByDateAndCategoryCount(DateTime date, String category);
//   Future<int> getTasksByDateAndPriorityCount(DateTime date, String priority);