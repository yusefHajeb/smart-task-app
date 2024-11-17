import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/common_widgets/responsive_widgets_scrollable.dart';
import 'package:smart_task/common_widgets/text_input_field.dart';
import 'package:smart_task/features/task/presentation/bloc/task_creation_cubit/task_creation_cubit.dart';

import '../bloc/task_cubit/task_cubit.dart';

class TaskCreationPage extends StatelessWidget {
  static String routeName = '/create_task';
  const TaskCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = context.watch<TaskCreationCubit>().formKey;

    final readTaskCubit = context.read<TaskCreationCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: ResponsiveCenterScrollable(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: BlocBuilder<TaskCreationCubit, TaskCreationState>(
            builder: (context, state) {
              return Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create Task',
                    ),
                    const SizedBox(height: 16),
                    const Text('Task Name'),
                    const SizedBox(height: 8),
                    TextInputField(
                      onChange: readTaskCubit.taskNameChanged,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      hint: 'Enter Name',
                    ),
                    const SizedBox(height: 16),
                    const Text('Category'),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (final category in [
                            'Work',
                            'Personal',
                            'Shopping',
                            'Health',
                            'Study'
                          ])
                            GestureDetector(
                              onTap: () {
                                readTaskCubit.categoryChanged(category);
                              },
                              child: CategoryChip(
                                color: state.categoryName == category
                                    ? Theme.of(context).colorScheme.primary
                                    : null,
                                isSelected: state.categoryName == category,
                                category: category.toString(),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Due Date'),
                    const SizedBox(height: 8),
                    TextInputField(
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );

                        if (selectedDate != null) {
                          readTaskCubit.dueDateChanged(selectedDate);
                          final startTime = await showTimePicker(
                            context: context,
                            helpText: 'Start Time',
                            initialTime: TimeOfDay.now(),
                          );

                          if (startTime != null) {
                            readTaskCubit.startTimeChanged(startTime);
                          }
                          final selectedTime = await showTimePicker(
                            context: context,
                            helpText: 'End Time',
                            initialTime: TimeOfDay.now(),
                          );

                          if (selectedTime != null) {
                            readTaskCubit.endTimeChanged(selectedTime);
                          }
                        }
                      },
                      readOnly: true,
                      icon: Icons.calendar_today_outlined,
                      hint: state.dueDate == null
                          ? 'Enter Due Date'
                          : DateFormat('MMM d, y')
                              .format(state.dueDate ?? DateTime.now()),
                    ),
                    const SizedBox(height: 16),
                    if (state.dueDate != null &&
                        state.startTime != null &&
                        state.endTime != null)
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text('Start Time'),
                                const SizedBox(height: 8),
                                _buildTimeSelector(
                                  label: 'Start Time',
                                  value: state.startTime,
                                  onSelect: (TimeOfDay time) {
                                    readTaskCubit.startTimeChanged(time);
                                  },
                                  context: context,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text('End Time'),
                                const SizedBox(height: 8),
                                _buildTimeSelector(
                                  label: 'End Time ',
                                  value: state.endTime,
                                  onSelect: (TimeOfDay time) {
                                    readTaskCubit.endTimeChanged(time);
                                  },
                                  context: context,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 16),
                    const Text('Priority'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        for (final priority in ['Low', 'Medium', 'High'])
                          GestureDetector(
                              onTap: () {
                                readTaskCubit.priorityChanged(priority);
                              },
                              child: CategoryChip(
                                  category: priority,
                                  color: state.priority == priority
                                      ? Theme.of(context).colorScheme.primary
                                      : null)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Description'),
                    const SizedBox(height: 8),
                    TextInputField(
                      keyBoardType: TextInputType.multiline,
                      onChange: readTaskCubit.descriptionChanged,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      hint: 'Enter Description',
                    ),
                    const SizedBox(height: 16),
                    _buildReminderSettings(state.isDailyReminder, (value) {
                      readTaskCubit.isDailyReminderChanged(value);
                    }),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          context.read<TaskCreationCubit>().submit();
                          context.read<TaskCubit>().fetchTasks();
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Create Task',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildReminderSettings(
      bool? isDailyReminder, Function(bool)? onChanged) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reminder Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(
                labelText: 'Remind me before',
                border: OutlineInputBorder(),
              ),
              // value: ,
              items: const [
                DropdownMenuItem(value: 10, child: Text('10 minutes')),
                DropdownMenuItem(value: 30, child: Text('30 minutes')),
                DropdownMenuItem(value: 60, child: Text('1 hour')),
              ],
              onChanged: (value) {
                if (value != null) {}
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Daily Reminder'),
              subtitle: const Text('Remind me every day at the start time'),
              value: isDailyReminder ?? false,
              onChanged: (value) => onChanged?.call(value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelector({
    required String label,
    required TimeOfDay? value,
    required Function(TimeOfDay) onSelect,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () async {},
      child: TextInputField(
        icon: Icons.access_time,
        hint: value?.format(context),
        readOnly: true,
        onTap: () async {
          final time = await showTimePicker(
            context: context,
            initialTime: value ?? TimeOfDay.fromDateTime(DateTime.now()),
          );

          if (time != null) {
            onSelect(time);
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class CategoryChip extends StatelessWidget {
  final String category;
  Color? color;
  bool isSelected;
  CategoryChip({
    required this.category,
    this.color,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Theme.of(context).colorScheme.primary.withOpacity(0.2);
    return Container(
      height: isSelected ? 35 : null,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          category,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
