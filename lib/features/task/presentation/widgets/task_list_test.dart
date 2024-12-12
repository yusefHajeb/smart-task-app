import 'package:flutter/material.dart';
import 'package:smart_task/core/constant/proiority_icons.dart';
import 'package:smart_task/core/constant/size.dart';
import 'package:smart_task/features/task/data/models/task.dart';
import 'package:intl/intl.dart';

class TaskListTest extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task)? onTaskComplete;
  final Function(Task)? onTaskEdit;
  final Function(String)? onTaskDelete;

  const TaskListTest({
    super.key,
    required this.tasks,
    this.onTaskComplete,
    this.onTaskEdit,
    this.onTaskDelete,
  });

  @override
  Widget build(BuildContext context) {
    final sortedTasks = List<Task>.from(tasks)
      ..sort((a, b) {
        if (a.completed != b.completed) {
          return a.completed ? 1 : -1;
        }
        return TaskPriority.fromName(b.priority!)
            .index
            .compareTo(TaskPriority.fromName(a.priority!).index);
      });

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemCount: sortedTasks.length,
      itemBuilder: (context, index) {
        return TaskCard(
          task: sortedTasks[index],
          onComplete: onTaskComplete,
          onEdit: onTaskEdit,
          onDelete: onTaskDelete,
        );
      },
    );
  }
}

class TaskCard extends StatelessWidget {
  final Task task;
  final Function(Task)? onComplete;
  final Function(Task)? onEdit;
  final Function(String)? onDelete;

  const TaskCard({
    super.key,
    required this.task,
    this.onComplete,
    this.onEdit,
    this.onDelete,
  });

  Color _getPriorityColor() {
    switch (TaskPriority.fromName(task.priority!)) {
      case TaskPriority.high:
        return Colors.red.shade300;
      case TaskPriority.medium:
        return Colors.orange.shade200;
      case TaskPriority.low:
        return Colors.green.shade100;
    }
  }

  IconData _getPriorityIcon() {
    switch (TaskPriority.fromName(task.priority!)) {
      case TaskPriority.high:
        return Icons.priority_high;
      case TaskPriority.medium:
        return Icons.remove;
      case TaskPriority.low:
        return Icons.arrow_downward;
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('HH:mm');
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: _getPriorityColor(),
      child: Column(
        children: [
          ListTile(
            leading: Icon(_getPriorityIcon()),
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.completed ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(task.description ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    task.completed ? Icons.check_circle : Icons.circle_outlined,
                    color: task.completed ? Colors.green : null,
                  ),
                  onPressed: () {
                    if (onComplete != null) {
                      onComplete!(task);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    if (onEdit != null) {
                      onEdit!(task);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    if (onDelete != null) {
                      onDelete!(task.id.toString());
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start: ${dateFormat.format(task.startTime!)} ${timeFormat.format(task.startTime!)}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    AppSize.height4(),
                    Text(
                      'End: ${dateFormat.format(task.endTime!)} ${timeFormat.format(task.endTime!)}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                if (task.isDailyReminder!)
                  Chip(
                    label: const Text('Daily'),
                    backgroundColor: Colors.blue[100],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
