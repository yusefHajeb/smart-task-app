import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../features/task/data/models/task.dart';

// ignore: depend_on_referenced_packages
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  Future<void> initialize() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation('Asia/Riyadh')); // set your local time zone here

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: androidSettings,
    );

    await _notifications.initialize(
      initSettings,
    );
  }

  Future<void> scheduleTaskReminder(Task task) async {
    final reminderTime = task.endTime?.subtract(
      Duration(
        minutes: task.isDailyReminder ?? false ? task.endTime?.minute ?? 0 : 0,
      ),
    );

    if (task.isDailyReminder ?? false) {
      await _scheduleDailyReminder(task);
    } else {
      await _scheduleOneTimeReminder(task, reminderTime);
    }
  }

  Future<void> _scheduleOneTimeReminder(
      Task task, DateTime? reminderTime) async {
    if (reminderTime == null) return;

    await _notifications.zonedSchedule(
      task.id.hashCode,
      'Task Reminder',
      'Reminder: ${task.title} will end at ${_formatTime(task.endTime!)}',
      tz.TZDateTime.from(reminderTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'task_reminders',
          'Task Reminders',
          enableVibration: true,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }

  Future<void> _scheduleDailyReminder(Task task) async {
    final now = DateTime.now();
    var scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      task.startTime?.hour ?? 0,
      task.startTime?.minute ?? 0,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _notifications.zonedSchedule(
        task.id.hashCode,
        'Daily Task Reminder',
        'Daily reminder: ${task.title}',
        tz.TZDateTime.from(scheduledDate, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'daily_reminders',
            'Daily Reminders',
            channelDescription: 'Daily task reminder notifications',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        androidScheduleMode: AndroidScheduleMode.exact);
  }

  Future<void> cancelTaskReminder(String taskId) async {
    await _notifications.cancel(taskId.hashCode);
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
