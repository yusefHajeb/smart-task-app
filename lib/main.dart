import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/di/dependence_injection.dart';
import 'package:smart_task/core/routes/app_routes.dart';
import 'package:smart_task/core/routes/routes.dart';
import 'package:smart_task/core/services/permission_service.dart';
import 'package:smart_task/core/theme/app_theme_data.dart';

import 'package:smart_task/features/task/data/datasources/base_database.dart';
import 'package:smart_task/features/task/presentation/bloc/app_theme/app_theme_bloc.dart';
import 'package:smart_task/features/task/presentation/bloc/task_cubit/task_cubit.dart';

import 'core/services/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  setupGetIt();
  final db = sl<SqfliteDatabase>();

  await db.init();
  await GlobalThemData.initialize();
  PermissionService.requestExactAlarmPermission();
  final notificationService = sl<NotificationService>();
  await notificationService.initialize();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AppThemeBloc>(
        create: (context) => AppThemeBloc(),
      ),
      BlocProvider(create: (context) => sl<TaskCubit>()..fetchTasks()),
    ],
    child: TaskTrackerApp(
      appRoutes: AppRoutes(),
    ),
  ));
}

// ignore: must_be_immutable
class TaskTrackerApp extends StatelessWidget {
  static const String initialRoute = '/';
  final AppRoutes appRoutes;

  const TaskTrackerApp({required this.appRoutes, super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 689));

    return ScreenUtilInit(
      minTextAdapt: false,
      splitScreenMode: true,
      child: BlocBuilder<AppThemeBloc, AppThemeState>(
        buildWhen: (previous, current) =>
            previous.themeMode != current.themeMode,
        builder: (context, state) {
          return MaterialApp(
            initialRoute: Routes.homePage,
            title: 'TaskMaster',
            onGenerateRoute: appRoutes.generateRoute,
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: GlobalThemData.themeDataSelect(state.themeMode),
            darkTheme: GlobalThemData.darkThemeData,
          );
        },
      ),
    );
  }
}
