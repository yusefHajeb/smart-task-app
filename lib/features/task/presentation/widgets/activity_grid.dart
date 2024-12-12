import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/core/constant/size.dart';
import 'package:smart_task/core/services/localizations_service.dart';
import 'package:smart_task/core/services/sheard_prefrence_service.dart';
import 'package:smart_task/features/task/presentation/bloc/task_cubit/task_state.dart';
import 'package:smart_task/service/task_service.dart';
import 'package:smart_task/common_widgets/responsive_widgets_scrollable.dart';

import '../bloc/task_cubit/task_cubit.dart';

class ActivityGrid extends StatelessWidget {
  const ActivityGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: ResponsiveCenterScrollable(
              child: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) => state.maybeMap(
                  orElse: () => Container(),
                  error: (message) => Text(message.message),
                  initial: (_) => const InitialActivity(),
                  loading: (_) => const InitialActivity(),
                  success: (tasks) {
                    return ListView(
                      // reverse: true,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Text(
                          'Activity Overview'.tr(context),
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        AppSize.height16(),
                        SizedBox(
                          height: 160.h,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 2,
                              childAspectRatio: 1,
                            ),
                            itemCount: 28,
                            itemBuilder: (context, index) {
                              final date = DateTime.now()
                                  .subtract(Duration(days: 27 - index));

                              final count = TaskService.getTaskCountForDay(
                                  date, tasks.tasks);

                              return _ActivityCell(
                                date: date,
                                count: count,
                                completion: count / tasks.tasks.length,
                              );
                            },
                          ),
                        ),
                        AppSize.height16(),
                        FutureBuilder<String>(
                            future: SharedPrefrenceHelper.getData("language")
                                .then((value) => value ?? 'en'),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final locale = snapshot.data ?? 'en';
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    7,
                                    (index) {
                                      final date = DateTime.now()
                                          .subtract(Duration(days: 6 - index));
                                      return Text(
                                        DateFormat(
                                          'E',
                                          locale,
                                        ).format(date),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color: Colors.grey.shade600),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            }),
                      ],
                    );
                  },
                ),
              ),
            )));
  }
}

class InitialActivity extends StatelessWidget {
  const InitialActivity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
        child: SizedBox(
          height: 120.h,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemCount: 35,
            itemBuilder: (context, index) {
              return _ActivityCell(
                date: DateTime.now(),
                count: 0,
                completion: 1,
              );
            },
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          7,
          (index) {
            final date = DateTime.now().subtract(Duration(days: 6 - index));
            return Text(
              DateFormat(
                'E',
              ).format(date),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey.shade600),
            );
          },
        ),
      ),
      // AppSize.height16(),
    ]);
  }
}

class _ActivityCell extends StatelessWidget {
  final DateTime date;
  final double completion;
  final int count;

  const _ActivityCell({
    required this.date,
    required this.completion,
    required this.count,
  });

  Color _getColorForCompletion(double completion) {
    if (completion >= 0.8) return Colors.green[700]!;
    if (completion >= 0.5) return Colors.green[500]!;
    if (completion >= 0.3) return Colors.green[300]!;
    if (completion > 0) return Colors.green[100]!;
    return Colors.grey[200]!;
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
                : _getColorForCompletion(completion),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );
    });
  }
}
