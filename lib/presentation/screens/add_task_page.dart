import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/common_widgets/responsive_widgets_scrollable.dart';
import 'package:smart_task/common_widgets/text_input_field.dart';
import 'package:smart_task/presentation/bloc/app_management/app_management_bloc.dart';
import 'package:smart_task/core/theme/app_colors.dart';

class TaskCreationPage extends StatelessWidget {
  static String routeName = '/create_task';
  const TaskCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: ResponsiveCenterScrollable(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: BlocBuilder<AppManagementBloc, AppManagementState>(
            builder: (context, state) {
              return Column(
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
                          CategoryChip(
                            category: category,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Due Date'),
                  const SizedBox(height: 8),
                  TextInputField(
                    hint: 'Enter Due Date',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a due date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text('Priority'),
                  const SizedBox(height: 8),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final priority in ['Low', 'Medium', 'High'])
                        CategoryChip(category: priority),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Description'),
                  const SizedBox(height: 8),
                  const TextInputField(
                    hint: 'Enter Description',
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: AppColors.primary,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // Add your onPressed functionality here
                    },
                    child: const Text(
                      'Create Task',

                      // style: AppTextStyles.button,
                    ),
                  ),
                ],
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
