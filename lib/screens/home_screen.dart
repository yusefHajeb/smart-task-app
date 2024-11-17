import 'package:flutter/material.dart';
import 'package:smart_task/widgets/activity_grid.dart';
import 'package:smart_task/widgets/stats_overview.dart';
import 'package:smart_task/widgets/task_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.check_box_outlined, size: 32),
            SizedBox(width: 12),
            Text('TaskMaster'),
          ],
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(),
            SizedBox(height: 24),
            ActivityGrid(),
            SizedBox(height: 24),
            StatsOverview(),
            SizedBox(height: 24),
            TaskList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showModalBottomSheet(
          //   context: context,
          //   isScrollControlled: true,
          //   builder: (context) => const AddTaskModal(),
          // );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Task Dashboard',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          'Track and manage your daily tasks efficiently',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }
}
