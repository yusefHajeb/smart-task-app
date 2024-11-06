import 'package:flutter/material.dart';
import 'package:smart_task/screens/home_screen.dart';
import 'package:smart_task/data/datasources/base_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = SqfliteDatabase();
  await db.init();

  runApp(const TaskTrackerApp());
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
      home: const HomeScreen(),
    );
  }
}
