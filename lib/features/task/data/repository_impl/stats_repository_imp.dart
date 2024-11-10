import 'package:smart_task/features/task/data/datasources/base_database.dart';
import 'package:smart_task/features/task/data/models/daily_stats.dart';

import '../../domain/repositories/daily_stats_repository.dart';

class StatsRepositoryImp implements DailyStatsRepository {
  final SqfliteDatabase database;
  StatsRepositoryImp(this.database);
  @override
  Future<int> getCompletedTasks(DateTime date) {
    throw UnimplementedError();
  }

  @override
  Future<DailyStats?> getDayStats(int userId, DateTime date) async {
    // return await _database.getAllUserTasks(userId).then((onValue) {
    //   final tasks = onValue.map((e) => Task.fromMap(e)).toList();
    //   return tasks.where((test) => test.dueDate == date).toList();
    // });
    throw UnimplementedError();
  }

  @override
  Future<int> getTodayOverdueTasks() {
    throw UnimplementedError();
  }

  @override
  Future<void> getStatsRange(int userId, DateTime startDate, DateTime endDate) {
    // TODO: implement getStatsRange
    throw UnimplementedError();
  }

  @override
  Future<int> getTotalDays(DateTime startDate) {
    // TODO: implement getTotalDays
    throw UnimplementedError();
  }

  @override
  Future<int> getTotalTasks() {
    // TODO: implement getTotalTasks
    throw UnimplementedError();
  }

  @override
  Future<List<DailyStats>> getUserStats(int userId) {
    // TODO: implement getUserStats
    throw UnimplementedError();
  }

  @override
  Future<void> insertDailyStats(DailyStats dailyStats) {
    // TODO: implement insertDailyStats
    throw UnimplementedError();
  }

  @override
  Future<void> updateDailyStats(DailyStats dailyStats) {
    // TODO: implement updateDailyStats
    throw UnimplementedError();
  }
}
