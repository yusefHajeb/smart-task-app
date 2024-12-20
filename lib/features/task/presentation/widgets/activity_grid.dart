import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/core/constant/size.dart';
import 'package:smart_task/core/services/localizations_service.dart';
import 'package:smart_task/core/services/sheard_prefrence_service.dart';
import 'package:smart_task/features/task/data/models/task.dart';
import 'package:smart_task/features/task/presentation/bloc/task_cubit/task_cubit.dart';
import 'package:smart_task/features/task/presentation/bloc/task_cubit/task_state.dart';
import 'package:smart_task/service/task_service.dart';
import 'package:smart_task/common_widgets/responsive_widgets_scrollable.dart';

class ActivityGrid extends StatelessWidget {
  const ActivityGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      // elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ResponsiveCenterScrollable(
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) => state.maybeMap(
              orElse: () => const SizedBox(),
              error: (message) => Text(message.message),
              initial: (_) => const InitialActivity(),
              loading: (_) => const SizedBox(
                child: Text('fdfdfd'),
              ),
              success: (tasks) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Activity Overview'.tr(context),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    AppSize.height16(),
                    SizedBox(
                      height: 160.h,
                      child: _AnimatedActivityGrid(tasks: tasks.tasks),
                    ),
                    AppSize.height16(),
                    _WeekdayLabels(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedActivityGrid extends StatelessWidget {
  final List<Task> tasks;

  const _AnimatedActivityGrid({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 28,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final date = DateTime.now().subtract(Duration(days: 27 - index));
        final count = TaskService.getTaskCountForDay(date, tasks);
        final completion = tasks.isNotEmpty ? count / tasks.length : 0.3;

        final delay = Duration(milliseconds: index * 50 + 100);

        return FadeInActivityCell(
          date: date,
          count: count,
          completion: double.parse(completion.toStringAsFixed(2)),
          delay: delay,
        );
      },
    );
  }
}

class FadeInActivityCell extends StatelessWidget {
  final DateTime date;
  final double completion;
  final int count;
  final Duration delay;

  const FadeInActivityCell({
    required this.date,
    required this.completion,
    required this.count,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(delay),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: completion + 0.5),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: child,
              );
            },
            child: _ActivityCell(
              date: date,
              count: count,
              completion: completion,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
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
    if (completion >= 0.95) return const Color.fromARGB(82, 47, 112, 25);

    if (completion >= 0.9) return const Color.fromARGB(255, 32, 114, 36);

    if (completion >= 0.8) return Colors.green[800]!;
    if (completion >= 0.5) return const Color.fromARGB(255, 109, 202, 114);
    if (completion >= 0.3) return const Color.fromARGB(255, 141, 222, 145);
    if (completion > 0) return const Color.fromARGB(255, 171, 227, 173);
    return Colors.grey[600]!.withOpacity(0.5);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: _getColorForCompletion(completion),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Tooltip(
        message: '${DateFormat('MMM d').format(date)}: $count tasks',
        child: const SizedBox(),
      ),
    );
  }
}

class _WeekdayLabels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: SharedPrefrenceHelper.getData("language")
          .then((value) => value ?? 'en'),
      builder: (context, snapshot) {
        final locale = snapshot.data ?? 'en';
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            final date = DateTime.now().subtract(Duration(days: 6 - index));
            return Text(
              DateFormat('E', locale).format(date),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey.shade600),
            );
          }),
        );
      },
    );
  }
}

class InitialActivity extends StatelessWidget {
  const InitialActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SizedBox(
            height: 160.h,
            child: GridView.builder(
              itemCount: 28,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final delay = Duration(milliseconds: index * 50);
                return FadeInActivityCell(
                  date: DateTime.now(),
                  count: 0,
                  completion: 0,
                  delay: delay,
                );
              },
            ),
          ),
        ),
        AppSize.height16(),
        _WeekdayLabels(),
      ],
    );
  }
}
