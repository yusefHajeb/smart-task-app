import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/core/di/dependence_injection.dart';
import 'package:smart_task/core/routes/animation_navigation.dart';
import 'package:smart_task/core/routes/routes.dart';
import 'package:smart_task/features/task/presentation/bloc/app_theme/app_theme_bloc.dart';
import 'package:smart_task/features/task/presentation/screens/home_page.dart';
import '../../features/task/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import '../../features/task/presentation/bloc/task_creation_cubit/task_creation_cubit.dart';
import '../../features/task/presentation/screens/add_task_page.dart';

class AppRoutes {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homePage:
        return SlideRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<AppThemeBloc>(
                create: (context) => sl<AppThemeBloc>(),
              ),
              BlocProvider<BottomNavigationBloc>(
                create: (context) => sl<BottomNavigationBloc>(),
              ),
            ],
            child: MultiBlocListener(
              listeners: [
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
        return SlideRoute(
          fullscreenDialog: true,
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
          ),
        );
    }
  }
}
