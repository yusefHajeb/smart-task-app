import '../../data/models/daily_stats.dart';

abstract class DailyStatsRepository {
  Future<List<DailyStats>> getUserStats(int userId);
  Future<void> insertDailyStats(DailyStats dailyStats);
  Future<DailyStats?> getDayStats(int userId, DateTime date);
  Future<void> updateDailyStats(DailyStats dailyStats);
  Future<void> getStatsRange(int userId, DateTime startDate, DateTime endDate);
  Future<int> getTotalTasks();
  Future<int> getCompletedTasks(DateTime date);
  Future<int> getTodayOverdueTasks();
  Future<int> getTotalDays(DateTime startDate);
}
