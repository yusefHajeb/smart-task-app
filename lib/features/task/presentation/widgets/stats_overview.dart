import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/core/constant/size.dart';
import 'package:smart_task/core/services/localizations_service.dart';
import 'package:smart_task/features/task/presentation/bloc/task_cubit/task_state.dart';
import 'package:smart_task/features/task/presentation/bloc/task_cubit/task_cubit.dart';

class StatsOverview extends StatelessWidget {
  const StatsOverview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
      if (state is TaskLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is TaskSuccess) {
        return Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Total Tasks'.tr(context),
                value: state.tasks
                    .where((task) =>
                        !task.completed &&
                        task.dueDate.isBefore(DateTime.now()))
                    .length
                    .toString(),
                icon: Icons.list_alt,
                color: Colors.blue,
              ),
            ),
            AppSize.width12(),
            Expanded(
              child: _StatCard(
                title: 'Completed'.tr(context),
                value: state.tasks
                    .where((context) => context.completed)
                    .length
                    .toString(),
                icon: Icons.check_circle_outline,
                color: Colors.green,
              ),
            ),
            AppSize.width12(),
            Expanded(
              child: _StatCard(
                title: 'Overdue'.tr(context),
                value: state.tasks
                    .where((task) =>
                        !task.completed &&
                        task.dueDate.isBefore(
                            DateTime.now().subtract(const Duration(days: 1))))
                    .length
                    .toString(),
                icon: Icons.warning_amber_rounded,
                color: Colors.red,
              ),
            ),
          ],
        );
      }
      return Container();
    });
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            AppSize.height16(),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            AppSize.height4(),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
