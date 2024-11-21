import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<void> requestExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.request();

    if (status != PermissionStatus.granted) {
      await _showPermissionRequiredDialog();
      await openAppSettings();
    }
  }

  static Future<void> _showPermissionRequiredDialog() async {
    final navigatorKey = GlobalKey<NavigatorState>();
    await showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Permission required'),
          content: const Text(
            'This app needs permission to schedule exact alarms in order to work properly.'
            ' Please grant permission in the app settings.',
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
