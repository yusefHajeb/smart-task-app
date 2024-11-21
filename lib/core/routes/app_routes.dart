import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/core/di/dependence_injection.dart';
import 'package:smart_task/core/routes/animation_navigation.dart';
import 'package:smart_task/core/routes/routes.dart';
import 'package:smart_task/features/task/presentation/bloc/app_theme/app_theme_bloc.dart';
import 'package:smart_task/features/task/presentation/bloc/category_task_bloc/category_task_bloc.dart';
import 'package:smart_task/features/task/presentation/bloc/task_creation_cubit/task_creation_cubit.dart';
import 'package:smart_task/features/task/presentation/bloc/task_cubit/task_cubit.dart';
import 'package:smart_task/features/task/presentation/screens/category_page.dart';
import 'package:smart_task/features/task/presentation/screens/home_page.dart';
import '../../features/task/data/models/task.dart';
import '../../features/task/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import '../../features/task/presentation/bloc/task_cubit/task_creation_state.dart';
import '../../features/task/presentation/screens/add_task_page.dart';

class AppRoutes {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homePage:
        return SlideRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<BottomNavigationBloc>(
                create: (context) => sl<BottomNavigationBloc>(),
              ),
              BlocProvider<CategoryTaskBloc>(
                create: (context) => sl<CategoryTaskBloc>()
                  ..add(const CategoryTaskEvent.started()),
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
                BlocListener<AppThemeBloc, AppThemeState>(
                  listener: (context, state) {
                    if (state.themeMode == ThemeMode.dark) {
                      SystemChrome.setSystemUIOverlayStyle(
                        const SystemUiOverlayStyle(
                          statusBarColor: Colors.transparent,
                          statusBarIconBrightness: Brightness.light,
                          statusBarBrightness: Brightness.dark,
                        ),
                      );
                    } else {
                      SystemChrome.setSystemUIOverlayStyle(
                        const SystemUiOverlayStyle(
                          statusBarColor: Colors.transparent,
                          statusBarIconBrightness: Brightness.dark,
                          statusBarBrightness: Brightness.light,
                        ),
                      );
                    }
                  },
                  listenWhen: (previous, current) =>
                      previous.themeMode != current.themeMode,
                ),
              ],
              child: HomePage(), // صفحة الرئيسية
            ),
          ),
        );
      case Routes.addTaskPage:
        {
          final Task? task = settings.arguments != null
              ? settings.arguments as Task
              : null; // استقبل المهمة

          return SlideRoute(
            fullscreenDialog: true,
            builder: (context) => BlocProvider(
              create: (context) {
                return sl<TaskCreationCubit>()..initialize(task);
              },
              child: const TaskCreationPage(),
            ),
          );
        }
      case Routes.categoryPage:
        return MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => BlocProvider(
            create: (context) =>
                sl<CategoryTaskBloc>()..add(CategoryTaskEvent.started()),
            child: const CategoryTaskPage(),
          ),
        );
      // case Routes.schedulePage:
      //   return SlideRoute(
      //     fullscreenDialog: true,
      //     builder: (context) => ScheduleScreen(
      //       tasksByDate: {
      //         DateTime.now():
      //       },
      //     ),
      //   );

      default:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<BottomNavigationBloc>(),
            child: HomePage(),
          ),
        );
    }
  }
}
