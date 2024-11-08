import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/presentation/bloc/app_management/app_management_bloc.dart';
import 'package:smart_task/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:smart_task/presentation/screens/add_task_page.dart';
import 'package:smart_task/presentation/screens/home_page.dart';
import 'package:smart_task/data/datasources/base_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = SqfliteDatabase();
  await db.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavigationBloc>(
          create: (_) => BottomNavigationBloc(),
        ),
        BlocProvider<AppManagementBloc>(
          create: (_) => AppManagementBloc(),
        ),
      ],
      child: const TaskTrackerApp(),
    ),
  );
}

class TaskTrackerApp extends StatelessWidget {
  @override
  const TaskTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.routeName,
      routes: {
        '/home-page': (context) => HomePage(),
        '/create_task': (context) => const TaskCreationPage(),
      },
      title: 'TaskMaster',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
          primary: const Color(0xFF4F46E5),
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: HomePage(),
    );
  }
}
