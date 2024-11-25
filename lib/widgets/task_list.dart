import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/core/constant/proiority_icons.dart';
import 'package:smart_task/core/services/localizations_service.dart';
import 'package:smart_task/features/task/data/models/task.dart';
import 'package:smart_task/features/task/presentation/bloc/task_cubit/task_cubit.dart';
import 'package:smart_task/features/task/presentation/screens/add_task_page.dart';
import 'package:smart_task/features/task/presentation/screens/schedule_task_page.dart';

import '../features/task/presentation/bloc/task_cubit/task_state.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state.maybeWhen(
          initial: () => const Center(child: CircularProgressIndicator()),
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
                        'Tasks'.tr(context),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScheduleScreen(
                              tasksByDate: tasks,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'see all..'.tr(context),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.blue,
                            ),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 1),
                Column(
                  children: tasks
                      .map((task) =>
                          DateFormat('MMM d, y').format(task.dueDate) ==
                                      DateFormat('MMM d, y')
                                          .format(DateTime.now()) ||
                                  (task.dueDate.isBefore(DateTime.now()) &&
                                      task.completed == false)
                              ? TaskItem(
                                  task: task,
                                )
                              : Container())
                      .toList(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// ignore: unused_element
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
                label: task.category!,
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
        onChanged: (_) async =>
            await context.read<TaskCubit>().updateTask(task),
      ),
      title: Text(
        task.title ?? '',
        style: TextStyle(
          decoration: task.completed ? TextDecoration.lineThrough : null,
          color: task.completed ? Colors.grey : null,
        ),
      ),
      subtitle: Wrap(
        children: [
          Icon(Icons.label_outline, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(task.category!),
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
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context, TaskCreationPage.routeName,
          arguments: task, // تمرير المهمة
        ).then((value) {
          if (context.mounted) {
            context.read<TaskCubit>().fetchTasks();
          }
        });
      },
      child: Card(
        surfaceTintColor: (task.dueDate
                .isBefore(DateTime.now().subtract(const Duration(days: 1))))
            ? Colors.red
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      task.title ?? '',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      context.read<TaskCubit>().deleteTask(task.id);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                task.description!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    onChanged: (value) {
                      context.read<TaskCubit>().updateTask(task);
                    },
                    activeColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    value: task.completed,
                  ),
                  const SizedBox(width: 12),
                  PriorityIconWidget(priority: task.priority!),
                  const SizedBox(width: 12),
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '${DateFormat.jm().format(task.startTime!)} - ${DateFormat.jm().format(task.endTime!)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
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
        tooltip: 'Add New Category'.tr(context),
      ),
    );
  }
}
