import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/core/constant/size.dart';
import 'package:smart_task/features/task/data/models/task.dart';
import 'package:smart_task/features/task/presentation/bloc/category_task_bloc/category_task_bloc.dart';
import 'package:smart_task/features/task/presentation/bloc/update_task_cubit/update_task_cubit.dart';

import '../bloc/task_cubit/task_cubit.dart';

Future<void> showUpdateTaskBottomSheet(BuildContext context, Task task,
    {bool? isEditFromCategory}) async {
  final TextEditingController titleController =
      TextEditingController(text: task.title);
  final TextEditingController descriptionController =
      TextEditingController(text: task.description);
  bool isDailyReminder = task.isDailyReminder ?? false;
  int? reminderMinutes = task.reminderMinutes;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    isScrollControlled: true,
    builder: (BuildContext context) {
      return BlocBuilder<UpdateTaskCubit, UpdateTaskState>(
        builder: (context, state) {
          return Padding(
            padding: MediaQuery.of(context)
                .viewInsets
                .add(const EdgeInsets.all(16.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Update Task',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<TaskCubit>().deleteTask(task.id);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                AppSize.height16(),
                _buildTextField(
                  controller: titleController,
                  label: 'Task Title',
                  icon: Icons.title,
                ),
                AppSize.height16(),
                _buildTextField(
                  controller: descriptionController,
                  label: 'Task Description',
                  icon: Icons.description,
                  maxLines: 3,
                ),
                AppSize.height16(),
                // _buildCategoryDropdown(context, state),
                AppSize.height16(),
                SwitchListTile(
                  title: const Row(
                    children: [
                      Text('Daily Reminder'),
                      // SizedBox(width: 8),
                      // IconButton(
                      //   icon: Icon(task.isDailyReminder ?? false
                      //       ? Icons.check_circle
                      //       : Icons.cancel),
                      //   onPressed: () {
                      //     context.read<TaskCubit>().updateTask(task.copyWith(
                      //           isDailyReminder:
                      //               !(task.isDailyReminder ?? false),
                      //         ));
                      //   },
                      // ),
                    ],
                  ),
                  value: isDailyReminder,
                  onChanged: (value) {
                    context.read<UpdateTaskCubit>().changeDailyReminder(value);
                    isDailyReminder = value;
                  },
                ),
                AppSize.height16(),
                if (isDailyReminder)
                  _buildReminderDropdown(state.task?.reminderMinutes ?? 0,
                      (value) {
                    return context
                        .read<UpdateTaskCubit>()
                        .changeReminderMinutes(value ?? 10);
                  }),
                AppSize.height16(),
                ElevatedButton(
                  child: Text(
                    'Update ${task.id}',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  onPressed: () {
                    context
                        .read<UpdateTaskCubit>()
                        .updateTask(state.task!.copyWith(
                          title: titleController.text,
                          description: descriptionController.text,
                          reminderMinutes: reminderMinutes,
                          isDailyReminder: state.task?.isDailyReminder ?? false,
                        ));
                    context.read<TaskCubit>().fetchTasks();
                    if (isEditFromCategory ?? false) {
                      context.read<CategoryTaskBloc>().add(
                          CategoryTaskEvent.categoryTaskChanged(state.task!));
                    }
                    Navigator.pop(context);
                  },
                ),
                AppSize.height16(),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  int maxLines = 1,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: const OutlineInputBorder(),
    ),
    maxLines: maxLines,
  );
}

// Widget _buildCategoryDropdown(BuildContext context, UpdateTaskState state) {
//   return DropdownButtonFormField<CategoryModel>(
//     decoration: const InputDecoration(
//       labelText: 'Category',
//       border: OutlineInputBorder(),
//     ),
//     items: state.categories.map<DropdownMenuItem<CategoryModel>>((category) {
//       return DropdownMenuItem<CategoryModel>(
//         value: category,
//         child: Text(category.name),
//       );
//     }).toList(),
//     onChanged: (value) {
//       // handle category change
//     },
//   );
// }

Widget _buildReminderDropdown(int reminderMinutes, Function(int?)? onChanged) {
  return DropdownButtonFormField<int>(
      value: reminderMinutes,
      decoration: const InputDecoration(
        labelText: 'Remind me before',
        border: OutlineInputBorder(),
      ),
      items: [10, 30, 60].map<DropdownMenuItem<int>>((int time) {
        return DropdownMenuItem<int>(
          value: time,
          child: Text('$time minutes'),
        );
      }).toList(),
      onChanged: (value) => onChanged);
}
