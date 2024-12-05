import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_task/core/di/dependence_injection.dart';
import 'package:smart_task/core/routes/animation_navigation.dart';
import 'package:smart_task/core/routes/routes.dart';
import 'package:smart_task/features/task/presentation/bloc/schedule_cubit/schedule_cubit.dart';
import 'package:smart_task/features/task/presentation/bloc/task_creation_cubit/task_creation_cubit.dart';
import 'package:smart_task/features/task/presentation/bloc/task_cubit/task_cubit.dart';
import 'package:smart_task/features/task/presentation/screens/home_page.dart';
import '../../features/task/data/models/task.dart';
import '../../features/task/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import '../../features/task/presentation/bloc/task_cubit/task_state.dart';
import '../../features/task/presentation/screens/add_task_page.dart';
import '../../features/task/presentation/screens/on_boarding.dart/on_barding_bloc.dart';
import '../../features/task/presentation/screens/on_boarding.dart/onboarding_screen.dart';
import '../../features/task/presentation/screens/schedule_task_page.dart';

class AppRoutes {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homePage:
        return homePageSlidRoute();
      case Routes.addTaskPage:
        final task = settings.arguments as Task?;
        return SlideRoute(
          fullscreenDialog: true,
          builder: (context) => BlocProvider(
            create: (context) => sl<TaskCreationCubit>()..initialize(task),
            child: const TaskCreationPage(),
          ),
        );
      // case Routes.categoryPage:
      //   return MaterialPageRoute(
      //     fullscreenDialog: true,
      //     builder: (context) => BlocProvider(
      //       create: (context) =>
      //           sl<CategoryTaskBloc>()..add(const CategoryTaskEvent.started()),
      //       child: const CategoryTaskPage(),
      //     ),
      //   );
      case Routes.onboardingPage:
        return sl<SharedPreferences>().getBool('hasCompletedOnboarding') ??
                false
            ? homePageSlidRoute()
            : MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => BlocProvider(
                      create: (context) => sl<OnboardingBloc>(),
                      child: const OnboardingScreen(),
                    ));
      case Routes.schedulePage:
        return MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => BlocProvider(
            create: (context) => sl<CalendarCubit>(),
            child: const ScheduleScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<BottomNavigationBloc>(),
            child: HomePage(),
          ),
        );
    }
  }

  MaterialPageRoute homePageSlidRoute() {
    return MaterialPageRoute(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider<BottomNavigationBloc>(
            create: (context) => sl<BottomNavigationBloc>(),
          ),
          BlocProvider<CalendarCubit>(
            create: (context) => sl<CalendarCubit>(),
          ),
          // BlocProvider<CategoryTaskBloc>(
          //   create: (context) =>
          //       sl<CategoryTaskBloc>()..add(const CategoryTaskEvent.started()),
          // ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<TaskCubit, TaskState>(
              listener: (context, state) {
                context.read<TaskCubit>().fetchTasks();
              },
              listenWhen: (previous, current) =>
                  previous is TaskSuccess && current is TaskSuccess,
            ),
          ],
          child: HomePage(), // صفحة الرئيسية
        ),
      ),
    );
  }
}
