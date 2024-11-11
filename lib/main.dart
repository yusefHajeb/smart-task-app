import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/di/dependence_injection.dart';
import 'package:smart_task/core/routes/app_routes.dart';
import 'package:smart_task/core/routes/routes.dart';
import 'package:smart_task/core/theme/app_theme_data.dart';

import 'package:smart_task/features/task/data/datasources/base_database.dart';
import 'package:smart_task/features/task/presentation/bloc/app_theme/app_theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();
  final db = SqfliteDatabase();

  await db.init();
  await GlobalThemData.initialize();
  setupGetIt();
  runApp(
    TaskTrackerApp(
      appRoutes: AppRoutes(),
    ),
  );
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
      child: BlocProvider(
        create: (context) => AppThemeBloc()
          ..add(AppThemeChanged(
            themeMode: ThemeMode.dark,
          )),
        child: BlocBuilder<AppThemeBloc, AppThemeState>(
          builder: (context, state) {
            return MaterialApp(
              initialRoute: Routes.homePage,
              title: 'TaskMaster',
              onGenerateRoute: appRoutes.generateRoute,
              debugShowCheckedModeBanner: false,
              themeMode: state.themeMode == ThemeMode.dark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              theme: state.themeMode == ThemeMode.dark
                  ? GlobalThemData.darkThemeData
                  : GlobalThemData.lightThemeData,
              darkTheme: GlobalThemData.darkThemeData,
            );
          },
        ),
      ),
    );
  }
}
