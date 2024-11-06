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
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ElevatedButton.icon(
                //   onPressed: () {},
                //   icon: const Icon(Icons.arrow_forward_ios_rounded),
                //   label: const Text('Next'),
                //   style: ElevatedButton.styleFrom(
                //     shape: const RoundedRectangleBorder(
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(8),
                //       ),
                //     ),
                //     backgroundColor: Theme.of(context).primaryColor,
                //     foregroundColor: Colors.white,
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 16,
                //       vertical: 8,
                //     ),
                //   ),
                // ),
                // Text(
                //   DateFormat('MMMM yyyy').format(DateTime.now()),
                //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                //         color: Colors.grey[600],
                //       ),
                // ),
                // ElevatedButton.icon(
                //   onPressed: () {},
                //   label: const Text('Previous'),
                //   icon: const Icon(Icons.arrow_back_ios_new_rounded),
                //   style: ElevatedButton.styleFrom(
                //     shape: const RoundedRectangleBorder(
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(8),
                //       ),
                //     ),
                //     backgroundColor: Theme.of(context).primaryColor,
                //     foregroundColor: Colors.white,
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 16,
                //       vertical: 8,
                //     ),
                //   ),
                // ),
              ],
            ),
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
                  return _ActivityCell(
                    date: date,
                    count: count,
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              // mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                7,
                (index) {
                  final date =
                      DateTime.now().subtract(Duration(days: 6 - index));
                  return Text(
                    DateFormat('E').format(date),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey.shade600),
                  );
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
    return LayoutBuilder(builder: (context, constraints) {
      final size = constraints.biggest.shortestSide / 7;
      return Tooltip(
        message: '${DateFormat('MMM d').format(date)}: $count tasks',
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: _getColor(),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );
    });
  }
}
