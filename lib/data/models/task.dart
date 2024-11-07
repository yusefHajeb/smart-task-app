class Task {
  final int id;
  final int userId;
  final String title;
  final String description;
  final String category;
  final DateTime dueDate;
  final String priority;
  bool completed;
  DateTime? completedAt;

  Task({
    required this.userId,
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.dueDate,
    required this.priority,
    this.completed = false,
    this.completedAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'title': title,
        'description': description,
        'category': category,
        'dueDate': dueDate.toIso8601String(),
        'priority': priority,
        'completed': completed,
        'completed_at': completedAt?.toIso8601String(),
      };

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        id: json['id'],
        userId: json['user_id'],
        title: json['title'],
        description: json['description'],
        category: json['category'],
        dueDate: DateTime.parse(json['dueDate']),
        priority: json['priority'],
        completed: json['completed'],
        completedAt: json['completed_at'] != null
            ? DateTime.parse(json['completed_at'])
            : null,
      );
}
