import 'package:flutter/material.dart';

enum PriorityType {
  low,
  medium,
  high;

  static PriorityType fromName(String name) {
    switch (name) {
      case 'Low':
        return PriorityType.low;
      case 'Medium':
        return PriorityType.medium;
      case 'High':
        return PriorityType.high;
      default:
        return PriorityType.high;
    }
  }
}

extension PriorityIcons on PriorityType {
  IconData get icon {
    switch (this) {
      case PriorityType.low:
        return Icons.low_priority;
      case PriorityType.medium:
        return Icons.priority_high;
      case PriorityType.high:
        return Icons.warning;
      default:
        return Icons.error;
    }
  }

  Color get color {
    switch (this) {
      case PriorityType.low:
        return Colors.green;
      case PriorityType.medium:
        return Colors.orange;
      case PriorityType.high:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
