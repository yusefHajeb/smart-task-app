import 'package:flutter/material.dart';
import 'package:smart_task/widgets/task_list.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.all(24),
      child: const TaskList(),
    );
  }
}
