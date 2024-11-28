import 'package:flutter/material.dart';

enum TaskPriority {
  low,
  medium,
  high;

  static TaskPriority fromName(String name) {
    switch (name) {
      case 'Low':
        return TaskPriority.low;
      case 'Medium':
        return TaskPriority.medium;
      case 'High':
        return TaskPriority.high;
      default:
        return TaskPriority.high;
    }
  }
}

extension PriorityIcons on TaskPriority {
  IconData get icon {
    switch (this) {
      case TaskPriority.low:
        return Icons.flag_rounded;
      case TaskPriority.medium:
        return Icons.flag_outlined;
      case TaskPriority.high:
        return Icons.flag_outlined;
      default:
        return Icons.error;
    }
  }

  Color get color {
    switch (this) {
      case TaskPriority.low:
        return Colors.green;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.high:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  int get index {
    switch (this) {
      case TaskPriority.low:
        return 0;
      case TaskPriority.medium:
        return 1;
      case TaskPriority.high:
        return 2;
      default:
        return 2;
    }
  }

  String get txt {
    switch (this) {
      case TaskPriority.low:
        return 'Low';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.high:
        return 'High';
      default:
        return 'High';
    }
  }
}
