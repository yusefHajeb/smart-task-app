import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/constant/size.dart';
import 'package:smart_task/features/task/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:smart_task/common_widgets/responsive_widgets_scrollable.dart';
import 'package:smart_task/features/task/presentation/screens/category_page.dart';
import 'package:smart_task/features/task/presentation/screens/schedule_task_page.dart';
import 'package:smart_task/features/task/presentation/widgets/activity_grid.dart';
import 'package:smart_task/features/task/presentation/widgets/stats_overview.dart';
import 'package:smart_task/widgets/task_list.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'profile_page.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<Widget> content = [
    const HomePageBody(),
    const ScheduleScreen(),
    const CategoryTaskPage(),
    const ProfilePage(),
  ];
  static const String routeName = '/home-page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Icon(Icons.check_box_outlined, size: 32),
              AppSize.width12(),
              const Text('TaskSmart'),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<BottomNavigationBloc, BottomNavigationState>(
                listener: (context, state) {
                  if (state.index == 0) {}
                },
                builder: (context, state) {
                  return content[state.index];
                },
              ),
            ),
          ],
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
    return ResponsiveCenterScrollable(
      // maxContentWidth: 800,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppSize.height16(),
            const ActivityGrid(),
            AppSize.height24(),
            const StatsOverview(),
            AppSize.height24(),
            const TaskList(),
          ],
        ),
      ),
    );
  }
}
