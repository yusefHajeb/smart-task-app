// ignore_for_file: public_member_api_docs, sort_constructors_first

class Task {
  final int id;
  final int userId;
  String? title;
  String? description;
  String? category;
  DateTime dueDate;
  String? priority;
  bool completed;
  DateTime? completedAt;
  DateTime? updatedAt;
  DateTime? createdAt;
  DateTime? startTime;
  DateTime? endTime;
  bool? isDailyReminder;
  int? reminderMinutes;

  Task({
    required this.userId,
    required this.id,
    this.title,
    this.description,
    required this.category,
    required this.dueDate,
    required this.priority,
    this.completed = false,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
    this.startTime,
    this.endTime,
    this.isDailyReminder,
    this.reminderMinutes,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': 1, // temporarily hardcoded
        'title': title,
        'description': description,
        'category': category,
        'due_date': dueDate.toIso8601String(),
        'priority': priority,
        'completed': completed == true ? 1 : 0,
        'completed_at': completedAt?.toIso8601String(),
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'start_time': startTime?.toIso8601String(),
        'end_time': endTime?.toIso8601String(),

        'is_daily_reminder': isDailyReminder == true ? 1 : 0,
        'reminder_minutes': reminderMinutes ?? 0,
      };

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        id: json['id'] ?? 0,
        userId: json['user_id'] ?? 0,
        title: json['title']?.toString() ?? '',
        description: json['description']?.toString() ?? '',
        category: json['category']?.toString() ?? "",
        dueDate: DateTime.parse(json['due_date']),
        priority: json['priority']?.toString() ?? '',
        completed: json['completed'] == 1 ? true : false,
        completedAt: json['completed_at'] != null
            ? DateTime.parse(json['completed_at'])
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
        createdAt: DateTime.parse(json['created_at']),
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        isDailyReminder: json['is_daily_reminder'] == 1 ? true : false,
        reminderMinutes: json['reminder_minutes'],
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
    DateTime? startTime,
    DateTime? endTime,
    bool? isDailyReminder,
    int? reminderMinutes,
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
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isDailyReminder: isDailyReminder ?? this.isDailyReminder,
      reminderMinutes: reminderMinutes ?? this.reminderMinutes,
    );
  }

  factory Task.toEmpty() {
    return Task(
      id: 0,
      userId: 1,
      title: null,
      description: '',
      category: '',
      dueDate: DateTime.now(),
      priority: null,
      completed: false,
      completedAt: null,
      updatedAt: null,
      createdAt: null,
      startTime: null,
      endTime: null,
      isDailyReminder: false,
      reminderMinutes: 0,
    );
  }
}
