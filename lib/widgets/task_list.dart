import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:smart_task/models/task.dart';
import 'package:smart_task/service/task_service.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Tasks',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const _CategoryFilter(),
          const Divider(height: 1),
          ValueListenableBuilder<List<Task>>(
            valueListenable: TaskService.tasksNotifier,
            builder: (context, tasks, _) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) => _TaskItem(task: tasks[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CategoryFilter extends StatelessWidget {
  const _CategoryFilter();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ValueListenableBuilder<String?>(
        valueListenable: TaskService.selectedCategoryNotifier,
        builder: (context, selectedCategory, _) {
          return Row(
            children: [
              _FilterChip(
                label: 'All',
                selected: selectedCategory == null,
                onSelected: (_) => TaskService.setSelectedCategory(null),
              ),
              ...TaskService.categories.map((category) => Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: _FilterChip(
                      label: category,
                      selected: category == selectedCategory,
                      onSelected: (_) =>
                          TaskService.setSelectedCategory(category),
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
    );
  }
}

class _TaskItem extends StatelessWidget {
  final Task task;

  const _TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.completed,
        onChanged: (_) => TaskService.toggleTask(task.id),
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.completed ? TextDecoration.lineThrough : null,
          color: task.completed ? Colors.grey : null,
        ),
      ),
      subtitle: Row(
        children: [
          Icon(Icons.label_outline, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(task.category),
          const SizedBox(width: 16),
          Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(DateFormat('MMM d, y').format(task.dueDate)),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () => TaskService.deleteTask(task.id),
      ),
    );
  }
}
