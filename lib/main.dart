import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/di/dependence_injection.dart';
import 'package:smart_task/core/routes/app_routes.dart';
import 'package:smart_task/core/routes/routes.dart';
import 'package:smart_task/core/theme/app_theme_data.dart';

import 'package:smart_task/features/task/data/datasources/base_database.dart';

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
  AppRoutes appRoutes;

  TaskTrackerApp({required this.appRoutes, super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 689));

    return ScreenUtilInit(
      minTextAdapt: false,
      splitScreenMode: true,
      child: MaterialApp(
        initialRoute: Routes.homePage,
        title: 'TaskMaster',
        onGenerateRoute: appRoutes.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: GlobalThemData.lightThemeData,
        darkTheme: GlobalThemData.darkThemeData,
      ),
    );
  }
}
