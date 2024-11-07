import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_task/constant/size.dart';
import 'package:smart_task/common_widgets/responsive_widgets_scrollable.dart';
import 'package:smart_task/widgets/activity_grid.dart';
import 'package:smart_task/widgets/stats_overview.dart';
import 'package:smart_task/widgets/task_list.dart';

import '../widgets/bottom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String string = 'Home Page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Icon(Icons.check_box_outlined, size: 32),
              SizedBox(width: 12),
              Text('TaskMaster'),
            ],
          ),
        ),
        body: ResponsiveCenterScrollable(
          maxContentWidth: 800,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Header(),
                AppSize.h16(),
                const ActivityGrid(),
                AppSize.h24(),

                const StatsOverview(),
                AppSize.h24(),
                const TaskList(),
                // User Information
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBarWidget());
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Task Dashboard',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          'Track and manage your daily tasks efficiently',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }
}
