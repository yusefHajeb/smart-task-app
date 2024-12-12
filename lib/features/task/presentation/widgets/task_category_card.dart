import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/core/constant/size.dart';
import 'package:smart_task/core/services/localizations_service.dart';

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
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(task.title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 15.sp,
                          decoration: task.completed
                              ? TextDecoration.lineThrough
                              : null,
                        )
                    // style: TextStyle(
                    //   decoration:
                    //       task.completed ? TextDecoration.lineThrough : null,
                    // ),
                    ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        task.completed
                            ? Icons.check_circle
                            : Icons.circle_outlined,
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
              ],
            ),
            AppSize.height8(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${"Start:".tr(context)} ${dateFormat.format(task.startTime!)} ${timeFormat.format(task.startTime!)}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.grey[600]),
                ),
                if (task.isDailyReminder ?? false) ...[
                  AppSize.width8(),
                  Chip(
                    label: const Text('Daily'),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  ),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}
