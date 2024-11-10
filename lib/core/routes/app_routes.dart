import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/core/di/dependence_injection.dart';
import 'package:smart_task/core/routes/routes.dart';
import 'package:smart_task/features/task/presentation/screens/home_page.dart';
import '../../features/task/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import '../../features/task/presentation/bloc/task_creation_cubit/task_creation_cubit.dart';
import '../../features/task/presentation/screens/add_task_page.dart';

class AppRoutes {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homePage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<BottomNavigationBloc>(),
                  child: HomePage(),
                ));
      case Routes.addTaskPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<TasKCreationCubit>(),
            child: const TaskCreationPage(),
          ),
        );

      default:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => sl<BottomNavigationBloc>(),
                  child: HomePage(),
                ));
    }
  }
}
