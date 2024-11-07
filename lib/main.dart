import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:smart_task/presentation/screens/home_page.dart';
import 'package:smart_task/data/datasources/base_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = SqfliteDatabase();
  await db.init();

  runApp(
    BlocProvider(
      create: (_) => BottomNavigationBloc(),
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
