import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/core/constant/proiority_icons.dart';
import 'package:smart_task/core/constant/size.dart';
import 'package:smart_task/core/services/localizations_service.dart';
import 'package:smart_task/features/task/data/models/task.dart';
import 'package:smart_task/features/task/presentation/bloc/task_cubit/task_cubit.dart';
import 'package:smart_task/features/task/presentation/bloc/update_task_cubit/update_task_cubit.dart';
import 'package:smart_task/features/task/presentation/screens/schedule_task_page.dart';
import 'package:smart_task/features/task/presentation/screens/update_task.dart';

import '../features/task/presentation/bloc/task_cubit/task_state.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state.maybeWhen(
          initial: () => _buildLoadingState(),
          loading: () => _buildLoadingState(),
          error: (message) => _buildErrorState(message),
          success: (tasks, selectedCategory) =>
              _buildSuccessState(context, tasks),
          orElse: () => _buildErrorState('Unknown error occurred'),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          AppSize.height16(),
          Text(
            'Loading tasks...',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
          AppSize.height16(),
          Text(
            message,
            style: TextStyle(fontSize: 16.sp, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context, List<Task> tasks) {
    final sortedTasks = _getSortedTasks(tasks);
    final today = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        const Divider(height: 1),
        _buildTasksList(context, sortedTasks, today),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.task_alt,
                color: Theme.of(context).colorScheme.primary,
                size: 24.sp,
              ),
              AppSize.width12(),
              Text(
                'Today\'s Tasks'.tr(context),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
              ),
            ],
          ),
          _buildSeeAllButton(context),
        ],
      ),
    );
  }

  Widget _buildSeeAllButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => Navigator.pushNamedAndRemoveUntil(
          context,
          ScheduleScreen.routeName,
          (route) => false,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            children: [
              Text(
                'See all'.tr(context),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14.sp,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTasksList(
      BuildContext context, List<Task> sortedTasks, DateTime today) {
    final todaysTasks = sortedTasks
        .where((task) =>
            DateFormat('MMM d, y').format(task.dueDate) ==
                DateFormat('MMM d, y').format(today) ||
            (task.dueDate.isBefore(today) && !task.completed))
        .toList();

    if (todaysTasks.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: todaysTasks.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: TaskItem(task: todaysTasks[index]),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.task_outlined,
              size: 64.sp,
              color: Colors.grey[400],
            ),
            AppSize.height16(),
            Text(
              'No tasks for today'.tr(context),
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            AppSize.height8(),
            Text(
              'Time to add some new tasks!'.tr(context),
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  List<Task> _getSortedTasks(List<Task> tasks) {
    return List<Task>.from(tasks)
      ..sort((a, b) {
        if (a.completed != b.completed) {
          return a.completed ? 1 : -1;
        }
        return TaskPriority.fromName(b.priority!)
            .index
            .compareTo(TaskPriority.fromName(a.priority!).index);
      });
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
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: _getCardBorderColor(task),
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _handleTaskTap(context),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTaskHeader(context),
              if (task.description?.isNotEmpty ?? false) ...[
                AppSize.height12(),
                _buildDescription(context),
              ],
              AppSize.height16(),
              _buildTaskFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskHeader(BuildContext context) {
    return Row(
      children: [
        _buildCheckbox(context),
        AppSize.width12(),
        Expanded(
          child: Text(
            task.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  decoration:
                      task.completed ? TextDecoration.lineThrough : null,
                  color: task.completed ? Colors.grey : null,
                ),
          ),
        ),
        _buildDeleteButton(context),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      task.description!,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
            height: 1.5,
          ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTaskFooter(BuildContext context) {
    return Row(
      children: [
        // PriorityIconWidget(priority: task.priority!),
        AppSize.width16(),
        Icon(Icons.access_time_rounded, size: 18.sp, color: Colors.grey[600]),
        AppSize.width8(),
        Text(
          '${DateFormat.jm().format(task.startTime!)} - ${DateFormat.jm().format(task.endTime!)}',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 13.sp,
          ),
        ),
        if (task.isDailyReminder ?? false) ...[
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.repeat_rounded,
                  size: 14.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
                AppSize.width4(),
                Text(
                  'Daily',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCheckbox(BuildContext context) {
    return Transform.scale(
      scale: 1.1,
      child: Checkbox(
        value: task.completed,
        onChanged: (_) => context.read<TaskCubit>().updateTask(task),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        activeColor: Colors.green,
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete_outline_rounded,
        color: Colors.red[300],
        size: 24.sp,
      ),
      onPressed: () => _showDeleteConfirmation(context),
    );
  }

  Color _getCardBorderColor(Task task) {
    if (task.dueDate
        .isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      return Colors.red.withOpacity(0.5);
    }
    return Colors.transparent;
  }

  void _handleTaskTap(BuildContext context) {
    showUpdateTaskBottomSheet(context, task);
    context.read<UpdateTaskCubit>().setTaskForUpdate(task);
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Task'.tr(context)),
        content: Text('Are you sure you want to delete this task?'.tr(context)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'.tr(context)),
          ),
          TextButton(
            onPressed: () {
              context.read<TaskCubit>().deleteTask(task.id);
              Navigator.pop(context);
            },
            child: Text(
              'Delete'.tr(context),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
