// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DailyStats {
  final int statId;
  final int userId;
  final DateTime date;
  final int totalTasks;
  final int completedTasks;
  final int overdueTasks;

  DailyStats({
    required this.statId,
    required this.userId,
    required this.date,
    required this.totalTasks,
    required this.completedTasks,
    required this.overdueTasks,
  });

  DailyStats copyWith({
    int? statId,
    int? userId,
    DateTime? date,
    int? totalTasks,
    int? completedTasks,
    int? overdueTasks,
  }) {
    return DailyStats(
      statId: statId ?? this.statId,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      totalTasks: totalTasks ?? this.totalTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      overdueTasks: overdueTasks ?? this.overdueTasks,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statId': statId,
      'userId': userId,
      'date': date.millisecondsSinceEpoch,
      'total_tasks': totalTasks,
      'completed_tasks': completedTasks,
      'overdue_tasks': overdueTasks,
    };
  }

  factory DailyStats.fromMap(Map<String, dynamic> map) {
    return DailyStats(
      statId: map['statId'] as int,
      userId: map['userId'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      totalTasks: map['total_tasks'] as int,
      completedTasks: map['completed_tasks'] as int,
      overdueTasks: map['overdue_tasks'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyStats.fromJson(String source) =>
      DailyStats.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DailyStats(statId: $statId, userId: $userId, date: $date, totalTasks: $totalTasks, completedTasks: $completedTasks, overdueTasks: $overdueTasks)';
  }

  @override
  bool operator ==(covariant DailyStats other) {
    if (identical(this, other)) return true;

    return other.statId == statId &&
        other.userId == userId &&
        other.date == date &&
        other.totalTasks == totalTasks &&
        other.completedTasks == completedTasks &&
        other.overdueTasks == overdueTasks;
  }

  @override
  int get hashCode {
    return statId.hashCode ^
        userId.hashCode ^
        date.hashCode ^
        totalTasks.hashCode ^
        completedTasks.hashCode ^
        overdueTasks.hashCode;
  }
}
