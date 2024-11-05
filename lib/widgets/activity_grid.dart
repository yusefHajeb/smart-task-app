import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/service/task_service.dart';

class ActivityGrid extends StatelessWidget {
  const ActivityGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Activity Overview',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemCount: 35,
                itemBuilder: (context, index) {
                  final date =
                      DateTime.now().subtract(Duration(days: 34 - index));
                  final count = TaskService.getTaskCountForDay(date);
                  return _ActivityCell(date: date, count: count);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityCell extends StatelessWidget {
  final DateTime date;
  final int count;

  const _ActivityCell({
    required this.date,
    required this.count,
  });

  Color _getColor() {
    if (count == 0) return Colors.grey[200]!;
    if (count <= 2) return Colors.green[200]!;
    if (count <= 4) return Colors.green[400]!;
    return Colors.green[600]!;
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: '${DateFormat('MMM d').format(date)}: $count tasks',
      child: Container(
        decoration: BoxDecoration(
          color: _getColor(),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
