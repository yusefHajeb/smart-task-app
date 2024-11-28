import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/common_widgets/responsive_widgets_scrollable.dart';
import 'package:smart_task/common_widgets/text_input_field.dart';
import 'package:smart_task/core/constant/proiority_icons.dart';
import 'package:smart_task/core/constant/size.dart';
import 'package:smart_task/core/services/localizations_service.dart';
import 'package:smart_task/features/task/presentation/bloc/task_creation_cubit/task_creation_cubit.dart';

import '../bloc/task_cubit/task_cubit.dart';

class TaskCreationPage extends StatelessWidget {
  static String routeName = '/create_task';
  const TaskCreationPage({super.key});

  @override
/*************  ✨ Codeium Command ⭐  *************/
/******  e984910b-1234-42b2-bcb6-5597eec79ac3  *******/ Widget build(
      BuildContext context) {
    final formKey = context.watch<TaskCreationCubit>().formKey;

    final readTaskCubit = context.read<TaskCreationCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task'.tr(context)),
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
                    const SizedBox(height: 16),
                    Text('Task Name'.tr(context)),
                    const SizedBox(height: 8),
                    TextInputField(
                      initialValue: state.task?.title,
                      onChange: readTaskCubit.taskNameChanged,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name'.tr(context);
                        }
                        return null;
                      },
                      hint: 'Enter Name'.tr(context),
                    ),
                    const SizedBox(height: 16),
                    Text('Category'.tr(context)),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (final category in state.categories)
                            GestureDetector(
                              onTap: () {
                                readTaskCubit.categoryChanged(category.name);
                              },
                              child: CategoryChip(
                                color: state.task?.category == category.name
                                    ? Theme.of(context).colorScheme.primary
                                    : null,
                                isSelected:
                                    state.task?.category == category.name,
                                category: category.name.toString(),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Due Date'.tr(context)),
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
                          if (context.mounted) {
                            final startTime = await showTimePicker(
                              context: context,
                              helpText: 'Start Time'.tr(context),
                              initialTime: TimeOfDay.now(),
                            );

                            if (startTime != null) {
                              readTaskCubit.startTimeChanged(startTime);
                            }
                          }
                          if (context.mounted) {
                            final selectedTime = await showTimePicker(
                              context: context,
                              helpText: 'End Time'.tr(context),
                              initialTime: TimeOfDay.now(),
                            );

                            if (selectedTime != null) {
                              readTaskCubit.endTimeChanged(selectedTime);
                            }
                          }
                        }
                      },
                      readOnly: true,
                      icon: Icons.calendar_today_outlined,
                      hint: state.task?.dueDate == null
                          ? 'Enter Due Date'.tr(context)
                          : DateFormat('MMM d, y')
                              .format(state.task?.dueDate ?? DateTime.now()),
                    ),
                    const SizedBox(height: 16),
                    if (state.task?.dueDate != null &&
                        state.task?.startTime != null &&
                        state.task?.endTime != null)
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Start Time'.tr(context)),
                                const SizedBox(height: 8),
                                _buildTimeSelector(
                                  label: 'Start Time',
                                  value: TimeOfDay.fromDateTime(
                                      state.task?.startTime ?? DateTime.now()),
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
                                Text('End Time'.tr(context)),
                                const SizedBox(height: 8),
                                _buildTimeSelector(
                                  label: 'End Time'.tr(context),
                                  value: TimeOfDay.fromDateTime(
                                      state.task?.endTime ?? DateTime.now()),
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
                    Text('Priority'.tr(context)),
                    const SizedBox(height: 8),
                    _buildPrioritySelector(
                      context,
                      TaskPriority.fromName(state.task?.priority ?? 'Medium'),
                    ),
                    Row(
                      children: [
                        for (final priority in [
                          'Low'.tr(context),
                          'Medium'.tr(context),
                          'High'.tr(context)
                        ])
                          GestureDetector(
                              onTap: () {
                                readTaskCubit.priorityChanged(priority);
                              },
                              child: CategoryChip(
                                  category: priority,
                                  color: state.task?.priority == priority
                                      ? Theme.of(context).colorScheme.primary
                                      : null)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('Description'.tr(context)),
                    const SizedBox(height: 8),
                    TextInputField(
                      initialValue: state.task?.description,
                      keyBoardType: TextInputType.multiline,
                      onChange: readTaskCubit.descriptionChanged,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description'.tr(context);
                        }
                        return null;
                      },
                      hint: 'Enter Description'.tr(context),
                    ),
                    const SizedBox(height: 16),
                    _buildReminderSettings(state.task?.isDailyReminder,
                        (value) {
                      readTaskCubit.reminderMinutes(value);
                    }, (value) {
                      readTaskCubit.isDailyReminderChanged(value);
                    }, context),
                    AppSize.h16(),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          context.read<TaskCreationCubit>().submit().then((_) {
                            if (context.mounted) {
                              context.read<TaskCubit>().fetchTasks();
                              Navigator.pop(context);
                            }
                          });
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

  Widget _buildPrioritySelector(BuildContext context, TaskPriority priority) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Priority'.tr(context),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SegmentedButton<TaskPriority>(
            style: SegmentedButton.styleFrom(
              foregroundColor: Colors.black,
              selectedForegroundColor: Colors.white,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.2),
              selectedBackgroundColor: Theme.of(context).colorScheme.primary,
            ),
            segments: [
              ButtonSegment(
                value: TaskPriority.high,
                label: Text('High'.tr(context)),
                icon: const Icon(Icons.priority_high),
              ),
              ButtonSegment(
                value: TaskPriority.medium,
                label: Text('Medium'.tr(context)),
                icon: const Icon(Icons.remove),
              ),
              ButtonSegment(
                value: TaskPriority.low,
                label: Text('Low'.tr(context)),
                icon: const Icon(Icons.arrow_downward),
              ),
            ],
            selected: {priority},
            onSelectionChanged: (Set<TaskPriority> newSelection) {
              context
                  .read<TaskCreationCubit>()
                  .priorityChanged(newSelection.first.txt);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReminderSettings(
      bool? isDailyReminder,
      Function(int)? reminderMinutes,
      Function(bool)? onChanged,
      BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reminder Settings'.tr(context),
        ),
        if (isDailyReminder ?? false) ...[
          const SizedBox(height: 16),
          DropdownButtonFormField<int>(
            hint: Text('Remind me before'.tr(context)),
            items: [
              DropdownMenuItem(
                  value: 10, child: Text('10 minutes'.tr(context))),
              DropdownMenuItem(
                  value: 30, child: Text('30 minutes'.tr(context))),
              DropdownMenuItem(value: 60, child: Text('1 hour'.tr(context))),
            ],
            onChanged: (value) {
              if (value != null) {
                reminderMinutes?.call(value);
              }
            },
          ),
        ],
        const SizedBox(height: 16),
        SwitchListTile(
          title: Text(
            'Daily Reminder'.tr(context),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          subtitle: Text('Remind me every day at the start time'.tr(context),
              style: Theme.of(context).textTheme.headlineSmall),
          value: isDailyReminder ?? false,
          onChanged: (value) => onChanged?.call(value),
        ),
      ],
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
  final Color? color;
  final bool isSelected;

  const CategoryChip({
    required this.category,
    this.color,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      height: isSelected ? 34.h : null,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: color ?? colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 1,
            color: colorScheme.primary.withOpacity(0.2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          category,
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
