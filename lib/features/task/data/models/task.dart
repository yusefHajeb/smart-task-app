// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  DateTime? updatedAt;
  DateTime? createdAt;

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
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'title': title,
        'description': description,
        'category': category,
        'due_date': dueDate.toIso8601String(),
        'priority': priority,
        'completed': completed == true ? 1 : 0,
        'completed_at': completedAt?.toIso8601String(),
        'created_at': updatedAt?.toIso8601String(),
        'updated_at': createdAt?.toIso8601String(),
      };

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        id: json['id'] ?? 0,
        userId: json['user_id'] ?? 0,
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        category: json['category'],
        dueDate: DateTime.parse(json['due_date']),
        priority: json['priority'],
        completed: json['completed'] == 1 ? true : false,
        completedAt: json['completed_at'] != null
            ? DateTime.parse(json['completed_at'])
            : null,
        updatedAt: DateTime.parse(json['updated_at']),
        createdAt: DateTime.parse(json['created_at']),
      );

  Task copyWith({
    int? id,
    int? userId,
    String? title,
    String? description,
    String? category,
    DateTime? dueDate,
    String? priority,
    bool? completed,
    DateTime? completedAt,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      completed: completed ?? this.completed,
      completedAt: completedAt ?? this.completedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
