import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/core/constant/size.dart';
import 'package:smart_task/features/task/presentation/bloc/app_theme/app_theme_bloc.dart';
import 'package:smart_task/features/task/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:smart_task/common_widgets/responsive_widgets_scrollable.dart';
import 'package:smart_task/widgets/activity_grid.dart';
import 'package:smart_task/widgets/stats_overview.dart';
import 'package:smart_task/widgets/task_list.dart';

import '../widgets/bottom_navigation_bar.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<Widget> content = [const HomePageBody(), const Text('search')];
  static const String routeName = '/home-page';
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
        body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
          builder: (context, state) {
            return content[state.index];
          },
        ),
        bottomNavigationBar: const BottomNavigationBarWidget());
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppThemeBloc(),
      child: ResponsiveCenterScrollable(
        maxContentWidth: 800,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<AppThemeBloc, AppThemeState>(
                builder: (context, state) {
                  return IconButton(
                      onPressed: () {
                        context.read<AppThemeBloc>().add(AppThemeChanged(
                            themeMode: state.themeMode == ThemeMode.light
                                ? ThemeMode.dark
                                : ThemeMode.light));
                      },
                      icon: state.themeMode == ThemeMode.light
                          ? const Icon(Icons.light_mode)
                          : const Icon(Icons.dark_mode));
                },
              ),

              // BlocProvider(
              //   create: (context) => AppThemeBloc(),
              //   child: IconButton(
              //       onPressed: () {
              //         final state = context.watch<AppThemeBloc>().state.themeMode;
              //         context.read<AppThemeBloc>().add(AppThemeChanged(
              //               themeMode: state == ThemeMode.dark
              //                   ? ThemeMode.light
              //                   : ThemeMode.dark,
              //             ));
              //       },
              //       icon:
              //           //  const Icon(Icons.light_mode)
              //           const Icon(Icons.dark_mode)),
              // ),
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
    );
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
          // style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          //       color: Colors.grey[600],
          //     ),
        ),
      ],
    );
  }
}
