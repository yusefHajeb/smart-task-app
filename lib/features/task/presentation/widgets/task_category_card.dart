import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/task.dart';

class TaskCategoryCard extends StatelessWidget {
  final Task task;
  final Function(Task)? onComplete;
  final Function(Task)? onEdit;
  final Function(String)? onDelete;

  const TaskCategoryCard({
    super.key,
    required this.task,
    this.onComplete,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat.jm();
    final dateFormat = DateFormat('dd MMM, yyyy');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              task.title ?? "",
              style: TextStyle(
                decoration: task.completed ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(task.description ?? ""),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start: ${dateFormat.format(task.startTime!)} ${timeFormat.format(task.startTime!)}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  'End: ${dateFormat.format(task.endTime!)} ${timeFormat.format(task.endTime!)}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                if (task.isDailyReminder ?? false)
                  if (task.isDailyReminder ?? false) ...[
                    const SizedBox(height: 8),
                    Chip(
                      label: const Text('Daily'),
                      backgroundColor: Theme.of(context).colorScheme.surface,
                    ),
                  ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
