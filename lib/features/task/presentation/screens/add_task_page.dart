import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/common_widgets/responsive_widgets_scrollable.dart';
import 'package:smart_task/common_widgets/text_input_field.dart';
import 'package:smart_task/features/task/presentation/bloc/task_creation_cubit/task_creation_cubit.dart';

class TaskCreationPage extends StatelessWidget {
  static String routeName = '/create_task';
  const TaskCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = context.watch<TasKCreationCubit>().formKey;

    final readTaskCubit = context.read<TasKCreationCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: ResponsiveCenterScrollable(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: BlocBuilder<TasKCreationCubit, TasKCreationState>(
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
                      hint: 'Enter Task Name',
                      onChange: readTaskCubit.categoryChanged,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a task name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text('Category'),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 8,
                        runSpacing: 8,
                        runAlignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
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
                                category: category,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Due Date'),
                    const SizedBox(height: 8),
                    TextInputField(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        ).then((value) {
                          if (value != null) {
                            readTaskCubit.dueDateChanged(value);
                          }
                        });
                      },
                      readOnly: true,
                      icon: Icons.calendar_today_outlined,
                      hint: state.dueDate == null
                          ? 'Enter Due Date'
                          : DateFormat('MMM d, y')
                              .format(state.dueDate ?? DateTime.now()),
                    ),
                    const SizedBox(height: 16),
                    const Text('Priority'),
                    const SizedBox(height: 8),
                    Wrap(
                      alignment: WrapAlignment.start,
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
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          context.read<TasKCreationCubit>().submit();
                        }
                        // Add your onPressed functionality here
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
}

// ignore: must_be_immutable
class CategoryChip extends StatelessWidget {
  final String category;
  Color? color;
  CategoryChip({required this.category, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    Theme.of(context).colorScheme.primary.withOpacity(0.2);
    return Container(
      height: 35,
      // width: MediaQuery.sizeOf(context).width / 3,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          category,
          // style: AppTextStyles.category,
        ),
      ),
    );
  }
}