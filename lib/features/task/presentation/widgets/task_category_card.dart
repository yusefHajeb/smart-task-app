import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/core/constant/size.dart';
import '../../data/models/task.dart';

class TaskCategoryCard extends StatelessWidget {
  final Task task;
  final Function(Task)? onComplete;
  final Function(Task)? onEdit;
  final Function(String)? onDelete;

  const TaskCategoryCard({
    super.key,
    required this.task,
    this.onComplete,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
/*************  ✨ Codeium Command ⭐  *************/
    /// Builds the TaskCategoryCard widget displaying task information.
    ///
    /// The widget is styled as a card with rounded corners and a border that changes
    /// based on the task's completion status. It includes an InkWell to handle tap
    /// interactions for editing. The card contains the task title, description,
    /// start time, and an optional daily reminder indicator. The appearance is
    /// adjusted according to the theme's color scheme.

/******  08155675-2895-4407-9f5d-f4bd2b904f41  *******/
    final timeFormat = DateFormat.jm();
    final dateFormat = DateFormat('dd MMM, yyyy');
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: task.completed
              ? colorScheme.primary.withOpacity(0.2)
              : Colors.transparent,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => onEdit?.call(task),
        child: Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontSize: 18.sp,
                                decoration: task.completed
                                    ? TextDecoration.lineThrough
                                    : null,
                                color:
                                    task.completed ? colorScheme.primary : null,
                                fontWeight: FontWeight.bold,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (task.description?.isNotEmpty ?? false) ...[
                          AppSize.height8(),
                          Text(
                            task.description!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey[600],
                                  fontSize: 14.sp,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  _buildActionButtons(context),
                ],
              ),
              AppSize.height16(),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 20.w,
                          color: colorScheme.primary,
                        ),
                        AppSize.width8(),
                        Text(
                          '${dateFormat.format(task.startTime!)} ${timeFormat.format(task.startTime!)}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurface,
                                    fontSize: 13.sp,
                                  ),
                        ),
                      ],
                    ),
                    if (task.isDailyReminder ?? false)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.repeat_rounded,
                              size: 16.w,
                              color: colorScheme.primary,
                            ),
                            AppSize.width4(),
                            Text(
                              'Daily',
                              style: TextStyle(
                                color: colorScheme.primary,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            task.completed ? Icons.check_circle : Icons.circle_outlined,
            color: task.completed ? Colors.green : Colors.grey,
            size: 28.w,
          ),
          onPressed: () => onComplete?.call(task),
        ),
        IconButton(
          icon: Icon(
            Icons.delete_outline_rounded,
            color: Colors.red[300],
            size: 24.w,
          ),
          onPressed: () => onDelete?.call(task.id.toString()),
        ),
      ],
    );
  }
}
