import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/core/constant/proiority_icons.dart';
import 'package:smart_task/features/task/data/models/task.dart';
import 'package:smart_task/features/task/presentation/bloc/task_cubit/task_cubit.dart';

import '../features/task/presentation/bloc/task_cubit/task_creation_state.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      buildWhen: (previous, current) =>
          current is TaskLoading || current is TaskSuccess,
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const Center(child: Text('Error')),
          error: (message) {
            return Center(child: Text(message));
          },
          loading: () {
            return const SizedBox(
                height: 200, child: Center(child: CircularProgressIndicator()));
          },
          success: (tasks, selectedCategory) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Tasks',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Text(
                      'for today ... ${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),

                // _CategoryFilter(
                //   tasks: tasks,
                //   selectedCategory: selectedCategory,
                // ),
                const Divider(height: 1),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tasks
                      .where(
                        (task) =>
                            DateFormat('MMM d, y').format(task.dueDate) ==
                            DateFormat('MMM d, y').format(DateTime.now()),
                      )
                      .length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskItem(task: task);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _CategoryFilter extends StatelessWidget {
  const _CategoryFilter({required this.tasks, this.selectedCategory});
  final List<Task> tasks;
  final String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const _AddNewCategory(),
          _FilterChip(
            label: 'All',
            selected: selectedCategory != null,
            onSelected: (_) {
              context.read<TaskCubit>().fetchTasks();
            },
          ),
          ...tasks.map((task) => Padding(
              padding: const EdgeInsets.only(left: 8),
              child: _FilterChip(
                label: task.category,
                selected: task.category == selectedCategory,
                onSelected: (_) => context
                    .read<TaskCubit>()
                    .setSelectedCategory(task.category),
              ))),
        ],
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
        onPressed: () {
          context.read<TaskCubit>().deleteTask(task.id);
        },
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    context.read<TaskCubit>().deleteTask(task.id);
                  },
                ),
                Text(
                  task.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<TaskCubit>().updateTask(task);
                  },
                  child: task.completed == true
                      ? const Icon(
                          Icons.check_box,
                          size: 24,
                        )
                      : const Icon(
                          Icons.check_box_outline_blank,
                          size: 24,
                        ),
                ),
                const SizedBox(width: 12),
                PriorityIconWidget(priority: task.priority),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PriorityIconWidget extends StatelessWidget {
  const PriorityIconWidget({
    Key? key,
    required this.priority,
  }) : super(key: key);

  final String priority;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Icon(
        PriorityType.fromName(priority).icon,
        size: 32,
        color: PriorityType.fromName(priority).color,
      ),
    );
  }
}

// please build priorityIcons

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
