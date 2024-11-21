enum ReminderMinutes {
  none,
  tenMinutes,
  thirtyMinutes,
  oneHour,
}

extension ReminderMinutesExtension on ReminderMinutes {
  String get string {
    switch (this) {
      case ReminderMinutes.none:
        return 'None';
      case ReminderMinutes.tenMinutes:
        return '10 minutes';
      case ReminderMinutes.thirtyMinutes:
        return '30 minutes';
      case ReminderMinutes.oneHour:
        return '1 hour';
    }
  }

  int get valueMinutes {
    switch (this) {
      case ReminderMinutes.none:
        return 0;
      case ReminderMinutes.tenMinutes:
        return 10;
      case ReminderMinutes.thirtyMinutes:
        return 30;
      case ReminderMinutes.oneHour:
        return 60;
    }
  }

  static ReminderMinutes fromString(String string) {
    switch (string) {
      case 'None':
        return ReminderMinutes.none;
      case '10 minutes':
        return ReminderMinutes.tenMinutes;
      case '30 minutes':
        return ReminderMinutes.thirtyMinutes;
      case '1 hour':
        return ReminderMinutes.oneHour;
      default:
        return ReminderMinutes.none;
    }
  }

  static List<String> values = ['None', '10 minutes', '30 minutes', '1 hour'];
}
