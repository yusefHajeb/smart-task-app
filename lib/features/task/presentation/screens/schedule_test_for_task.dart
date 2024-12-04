import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/features/task/data/models/task.dart';

class ScheduleTestForTask extends StatelessWidget {
  const ScheduleTestForTask({
    super.key,
    required this.tasks,
    required this.day,
  });

  final int day;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: DataTable(
          border: TableBorder(
            verticalInside: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
            top: BorderSide.none,
            horizontalInside: BorderSide.none,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          showCheckboxColumn: false,
          showBottomBorder: false,
          headingRowHeight: 0,
          columnSpacing: 0,
          horizontalMargin: 0,
          dataRowHeight: 80,
          columns: const [
            DataColumn(label: Text('Time')),
            DataColumn(label: Text('Task')),
            DataColumn(label: Text('Status')),
          ],
          rows: [
            for (int i = 7; i <= 6 + 24; i++) _buildDataRow(context, i % 24)
          ]),
    );
  }

  DataRow _buildDataRow(BuildContext context, int hour) {
    return DataRow(
      mouseCursor: WidgetStateMouseCursor.clickable,
      cells: [
        DataCell(
          Text(
            _formatTime(hour),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.3,
            child: _taskContent(hour),
          ),
        ),
        DataCell(_taskStatus(hour)),
      ],
    );
  }

  String _formatTime(int hour) {
    if (hour == 0) return '12 AM';
    if (hour > 12) return '${hour - 12} PM';
    return '$hour AM';
  }

  Widget _taskContent(int hour) {
    final task = _findTask(hour);
    return task.id != 0 ? _buildTaskCard(task) : const SizedBox();
  }

  Widget _taskStatus(int hour) {
    final task = _findTask(hour);
    return task.completed
        ? const Icon(Icons.done, color: Colors.green)
        : const SizedBox();
  }

  Task _findTask(int hour) {
    return tasks.firstWhere(
      (task) =>
          task.startTime?.hour == hour || task.startTime?.hour == hour + 1,
      orElse: Task.toEmpty,
    );
  }

  Widget _buildTaskCard(Task task) {
    final color = _getTaskColor(task);
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: TaskSchedule(
            task: task,
          ),
        ),
      ),
    );
  }

  Color _getTaskColor(Task task) {
    final colors = {
      'Work': Colors.purple[200],
      'Marketing': Colors.orange[200],
      'Personal': Colors.pink[200],
      'Study': Colors.purple[200],
      'Other': Colors.blue[200],
    };

    return colors[task.category] ??
        Color.fromARGB(
          255,
          Random().nextInt(255),
          Random().nextInt(255),
          Random().nextInt(255),
        ).withOpacity(0.1);
  }

  Widget _taskCard(List<Task> tasks, int i) {
    final task = tasks.firstWhere((test) => test.startTime?.hour == i,
        orElse: Task.toEmpty);
    return task.completed
        ? const Icon(Icons.done, color: Colors.green)
        : const SizedBox();
  }
}

class TaskSchedule extends StatelessWidget {
  const TaskSchedule({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Text(
          task.title ?? '',
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Wrap(
          direction: Axis.horizontal,
          children: [
            const SizedBox(width: 12),
            Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              '${DateFormat('HH:mm').format(task.startTime!)} - ${DateFormat('HH:mm').format(task.endTime!)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(width: 12),
            const Icon(Icons.done, size: 16, color: Colors.green),
            const SizedBox(width: 4),
            Text(
              DateFormat('MMM d, y').format(task.dueDate),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        // const SizedBox(height: 8),
      ],
    );
  }
}
