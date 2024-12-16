import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_task/core/di/dependence_injection.dart';
import 'package:smart_task/core/routes/animation_navigation.dart';
import 'package:smart_task/core/routes/routes.dart';
import 'package:smart_task/features/task/data/models/task.dart';
import 'package:smart_task/features/task/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:smart_task/features/task/presentation/bloc/schedule_cubit/schedule_cubit.dart';
import 'package:smart_task/features/task/presentation/bloc/task_creation_cubit/task_creation_cubit.dart';
import 'package:smart_task/features/task/presentation/bloc/task_cubit/task_cubit.dart';
import 'package:smart_task/features/task/presentation/bloc/task_cubit/task_state.dart';
import 'package:smart_task/features/task/presentation/screens/add_task_page.dart';
import 'package:smart_task/features/task/presentation/screens/home_page.dart';
import 'package:smart_task/features/task/presentation/screens/on_boarding.dart/on_barding_bloc.dart';
import 'package:smart_task/features/task/presentation/screens/on_boarding.dart/onboarding_screen.dart';
import 'package:smart_task/features/task/presentation/screens/schedule_task_page.dart';

class AppRoutes {
  Route generateRoute(RouteSettings settings) {
    // Log navigation for debugging
    log('Navigating to: ${settings.name}');

    // Handle null routes
    if (settings.name == null) {
      return _errorRoute();
    }

    switch (settings.name) {
      case Routes.homePage:
        return _buildHomePageRoute();

      case Routes.addTaskPage:
        return _buildAddTaskRoute(settings.arguments);

      case Routes.onboardingPage:
        return _buildOnboardingRoute();

      case Routes.schedulePage:
        return _buildScheduleRoute();

      default:
        return _errorRoute();
    }
  }

  Route _buildHomePageRoute() {
    return MaterialPageRoute(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider<BottomNavigationBloc>(
            create: (context) => sl<BottomNavigationBloc>(),
          ),
          BlocProvider<CalendarCubit>(
            create: (context) => sl<CalendarCubit>(),
          ),
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

  Route _buildAddTaskRoute(Object? arguments) {
    final task = arguments as Task?;
    return SlideRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => sl<TaskCreationCubit>()..initialize(task),
        child: const TaskCreationPage(),
      ),
    );
  }

  Route _buildOnboardingRoute() {
    final hasCompletedOnboarding =
        sl<SharedPreferences>().getBool('hasCompletedOnboarding') ?? false;

    if (hasCompletedOnboarding) {
      // Instead of calling homePageSlidRoute, return a direct route
      return _buildHomePageRoute();
    }

    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => sl<OnboardingBloc>(),
        child: const OnboardingScreen(),
      ),
    );
  }

  Route _buildScheduleRoute() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => sl<CalendarCubit>(),
        child: const ScheduleScreen(),
      ),
    );
  }

  Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('Route not found'),
        ),
      ),
    );
  }
}
