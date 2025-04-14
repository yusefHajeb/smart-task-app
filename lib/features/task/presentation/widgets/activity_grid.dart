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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ResponsiveCenterScrollable(
          child: BlocBuilder<TaskCubit, TaskState>(
            // Only rebuild when the task list changes in a meaningful way
            buildWhen: (previous, current) {
              final previousTasks =
                  previous is TaskSuccess ? previous.tasks : [];
              final currentTasks = current is TaskSuccess ? current.tasks : [];
              return previousTasks.length != currentTasks.length;
            },
            builder: (context, state) => state.maybeMap(
              orElse: () => const SizedBox(),
              error: (message) => Center(
                child: Text(
                  message.message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.red,
                      ),
                ),
              ),
              initial: (_) => const InitialActivity(),
              loading: (_) => const Center(
                child: InitialActivity(),
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
                    FutureBuilder<String>(
                        future: SharedPrefrenceHelper.getData("language")
                            .then((value) => value ?? 'en'),
                        builder: (context, snapshot) {
                          // Show loading indicator while fetching locale
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: LinearProgressIndicator());
                          }

                          // Handle errors
                          if (snapshot.hasError) {
                            return Text(
                              'Error loading language',
                              style: Theme.of(context).textTheme.bodySmall,
                            );
                          }

                          final locale = snapshot.data ?? 'en';
                          return SizedBox(
                            height: 160.h,
                            child: _AnimatedActivityGrid(
                                tasks: tasks.tasks, local: locale),
                          );
                        }),
                    AppSize.height16(),
                    const _WeekdayLabels(),
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

/// Constants for the activity grid
class _ActivityGridConstants {
  static const int daysToShow = 28;
  static const int crossAxisCount = 7;
  static const double spacing = 4.0;
  static const double animationDelayPerCell = 50.0;
  static const double animationBaseDelay = 100.0;
  // static const double animationDuration = 900.0;
  static const double defaultCompletion = 0.3;
  static const double cellAspectRatio = 1.0;
}

/// A grid that displays animated activity cells
class _AnimatedActivityGrid extends StatelessWidget {
  final String local;
  final List<Task> tasks;

  const _AnimatedActivityGrid({required this.tasks, required this.local});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _ActivityGridConstants.daysToShow,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _ActivityGridConstants.crossAxisCount,
        mainAxisSpacing: _ActivityGridConstants.spacing,
        crossAxisSpacing: _ActivityGridConstants.spacing,
        childAspectRatio: _ActivityGridConstants.cellAspectRatio,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final date = DateTime.now()
            .subtract(Duration(days: local == 'ar' ? 1 - index : 1 - index));
        final count = TaskService.getTaskCountForDay(date, tasks);

        // Calculate completion rate with a fallback for empty task lists
        final completion = tasks.isNotEmpty
            ? count / tasks.length
            : _ActivityGridConstants.defaultCompletion;

        final delay = Duration(
            milliseconds:
                (index * _ActivityGridConstants.animationDelayPerCell +
                        _ActivityGridConstants.animationBaseDelay)
                    .toInt());

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

/// A widget that fades in an activity cell with a delay
class FadeInActivityCell extends StatefulWidget {
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
  State<FadeInActivityCell> createState() => _FadeInActivityCellState();
}

class _FadeInActivityCellState extends State<FadeInActivityCell> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  Future<void> _startAnimation() async {
    await Future.delayed(widget.delay);
    if (mounted) {
      setState(() {
        _isVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      return const SizedBox.shrink();
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.1, end: 1.0),
      duration: const Duration(
          milliseconds:
              900), // Using the value directly instead of calling toInt()
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: _ActivityCell(
        date: widget.date,
        count: widget.count,
        completion: widget.completion,
      ),
    );
  }
}

/// A single cell in the activity grid that represents task completion for a day
class _ActivityCell extends StatelessWidget {
  final DateTime date;
  final double completion;
  final int count;

  const _ActivityCell({
    required this.date,
    required this.completion,
    required this.count,
  });

  /// Returns a color based on the completion percentage
  Color _getColorForCompletion(double completion) {
    // Fixed color mapping with proper progression
    if (completion >= 0.3) return const Color.fromARGB(255, 16, 176, 24);
    if (completion >= 0.2) return const Color.fromARGB(237, 67, 160, 72);
    if (completion >= 0.16) return const Color.fromARGB(245, 61, 151, 86);
    if (completion >= 0.14) return const Color.fromARGB(245, 81, 181, 104);
    if (completion >= 0.11) return const Color.fromARGB(255, 109, 202, 114);
    if (completion >= 0.10) return const Color.fromARGB(255, 121, 212, 126);
    if (completion >= 0.09) return const Color.fromARGB(255, 141, 222, 145);
    if (completion >= 0.08) return const Color.fromARGB(255, 161, 227, 166);
    if (completion >= 0.07) return const Color.fromARGB(255, 171, 227, 173);
    if (completion >= 0.05) return const Color.fromARGB(255, 191, 232, 191);
    if (completion >= 0.03) return const Color.fromARGB(255, 211, 242, 211);
    if (completion >= 0.01) return const Color.fromARGB(255, 221, 252, 221);

    // Default color for no activity
    return Colors.grey[600]!.withOpacity(0.5);
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMM d').format(date);
    final taskText = count == 1 ? 'task' : 'tasks';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: _getColorForCompletion(completion),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Tooltip(
        message: '$formattedDate: $count $taskText',
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              // Could add functionality to show tasks for this day
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$count $taskText on $formattedDate'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const SizedBox(),
          ),
        ),
      ),
    );
  }
}

/// A widget that displays the weekday labels below the activity grid
class _WeekdayLabels extends StatelessWidget {
  const _WeekdayLabels();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: SharedPrefrenceHelper.getData("language")
          .then((value) => value ?? 'en'),
      builder: (context, snapshot) {
        // Show loading indicator while fetching locale
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LinearProgressIndicator());
        }

        // Handle errors
        if (snapshot.hasError) {
          return Text(
            'Error loading language',
            style: Theme.of(context).textTheme.bodySmall,
          );
        }

        final locale = snapshot.data ?? 'en';
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            final date = DateTime.now().subtract(
                Duration(days: snapshot.data == 'en' ? 1 - index : 1 - index));
            return Semantics(
              label: 'Weekday ${DateFormat('EEEE', locale).format(date)}',
              child: Text(
                DateFormat('E', locale).format(date),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey.shade600),
              ),
            );
          }),
        );
      },
    );
  }
}

/// A widget that displays the initial state of the activity grid when no data is available
class InitialActivity extends StatelessWidget {
  const InitialActivity({super.key});

  @override
  Widget build(BuildContext context) {
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
        Center(
          child: SizedBox(
            height: 160.h,
            child: GridView.builder(
              itemCount: _ActivityGridConstants.daysToShow,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _ActivityGridConstants.crossAxisCount,
                mainAxisSpacing: _ActivityGridConstants.spacing,
                crossAxisSpacing: _ActivityGridConstants.spacing,
                childAspectRatio: _ActivityGridConstants.cellAspectRatio,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final delay = Duration(
                    milliseconds:
                        (index * _ActivityGridConstants.animationDelayPerCell)
                            .toInt());
                return FadeInActivityCell(
                  date: DateTime.now().subtract(Duration(
                      days: _ActivityGridConstants.daysToShow - 1 - index)),
                  count: 0,
                  completion: 0,
                  delay: delay,
                );
              },
            ),
          ),
        ),
        AppSize.height16(),
        const _WeekdayLabels(),
      ],
    );
  }
}
