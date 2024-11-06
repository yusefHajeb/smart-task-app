class Task {
  final int id;
  final String title;
  final String description;
  final String category;
  final DateTime dueDate;
  final String priority;
  bool completed;
  DateTime? completedAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.dueDate,
    required this.priority,
    this.completed = false,
    this.completedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'dueDate': dueDate.toIso8601String(),
        'priority': priority,
        'completed': completed,
        'completedAt': completedAt?.toIso8601String(),
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        category: json['category'],
        dueDate: DateTime.parse(json['dueDate']),
        priority: json['priority'],
        completed: json['completed'],
        completedAt: json['completedAt'] != null
            ? DateTime.parse(json['completedAt'])
            : null,
      );
}
