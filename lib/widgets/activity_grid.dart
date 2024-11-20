import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/features/task/presentation/bloc/task_cubit/task_creation_state.dart';
import 'package:smart_task/service/task_service.dart';
import 'package:smart_task/common_widgets/responsive_widgets_scrollable.dart';

import '../features/task/presentation/bloc/task_cubit/task_cubit.dart';

class ActivityGrid extends StatelessWidget {
  const ActivityGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: ResponsiveCenterScrollable(
              child: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) => state.when(
                  error: (message) => Text(message),
                  initial: () => Column(children: [
                    Center(
                      child: SizedBox(
                        height: 120,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                          ),
                          itemCount: 35,
                          itemBuilder: (context, index) {
                            final date = DateTime.now()
                                .subtract(Duration(days: 34 - index));

                            final count =
                                TaskService.getTaskCountForDay(date, []);
                            print(count);
                            return _ActivityCell(
                              date: DateTime.now(),
                              count: 0,
                            );
                          },
                        ),
                      ),
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.max,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        7,
                        (index) {
                          final date = DateTime.now()
                              .subtract(Duration(days: 6 - index));
                          return Text(
                            DateFormat('E').format(date),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey.shade600),
                          );
                        },
                      ),
                    ),
                    // const SizedBox(height: 8),
                  ]),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  success: (tasks, selectedCategory) {
                    return ListView(
                      // reverse: true,
                      shrinkWrap: true,
                      // mainAxisSize: MainAxisSize.max,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Activity Overview',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 120.h,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 2,
                              childAspectRatio: 1,
                            ),
                            itemCount: 35,
                            itemBuilder: (context, index) {
                              final date = DateTime.now()
                                  .subtract(Duration(days: 34 - index));

                              final count =
                                  TaskService.getTaskCountForDay(date, tasks);
                              print(count);
                              return _ActivityCell(
                                date: date,
                                count: count,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          // mainAxisSize: MainAxisSize.max,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            7,
                            (index) {
                              final date = DateTime.now()
                                  .subtract(Duration(days: 6 - index));
                              return Text(
                                DateFormat('E').format(date),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.grey.shade600),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            )));
  }
}

class _ActivityCell extends StatelessWidget {
  final DateTime date;
  final int count;

  const _ActivityCell({
    required this.date,
    required this.count,
  });

  Color _getColor() {
    if (count == 0) return Colors.grey[200]!;
    if (count <= 2) return Colors.green[200]!;
    if (count <= 4) return Colors.green[400]!;
    return Colors.green[600]!;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = constraints.maxWidth / 7;
      return Tooltip(
        message: '${DateFormat('MMM d').format(date)}: $count tasks',
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: count == 0
                ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.1)
                : _getColor(),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );
    });
  }
}
