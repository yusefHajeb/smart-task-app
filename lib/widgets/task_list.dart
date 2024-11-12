import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/features/task/data/models/task.dart';
import 'package:smart_task/features/task/presentation/bloc/task_cubit/task_cubit.dart';
import 'package:smart_task/service/task_service.dart';

import '../features/task/presentation/bloc/task_cubit/task_creation_state.dart';

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
          BlocBuilder<TaskCubit, TaskState>(
            buildWhen: (previous, current) =>
                current is TaskLoading || current is TaskSuccess,
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const Center(child: Text('Error')),
                error: (message) {
                  return Center(
                    child: Text(
                      message,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
                },
                initial: () {
                  return const Center(child: CircularProgressIndicator());
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
                success: (tasks) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tasks.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return _TaskItem(task: task);
                    },
                  );
                },
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
              const _AddNewCategory(),
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
        onChanged: (_) => context.read<TaskCubit>().updateTask(task),
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.completed ? TextDecoration.lineThrough : null,
          color: task.completed ? Colors.grey : null,
        ),
      ),
      subtitle: Wrap(
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

class _AddNewCategory extends StatelessWidget {
  const _AddNewCategory();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      ),
      child: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          // Add new category logic here
        },
        color: Theme.of(context).colorScheme.primary,
        iconSize: 30.0,
        splashRadius: 25.0,
        tooltip: 'Add New Category',
      ),
    );
  }
}
