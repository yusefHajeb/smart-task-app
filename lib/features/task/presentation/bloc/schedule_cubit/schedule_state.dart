// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'schedule_cubit.dart';

@freezed
class CalendarState {
  final List<Task> allTasks;
  final List<Task> filteredTasks;
  final int? currentSelectedDay;

  CalendarState(
      {required this.allTasks,
      required this.filteredTasks,
      required this.currentSelectedDay});

  CalendarState copyWith({
    List<Task>? allTasks,
    List<Task>? filteredTasks,
    int? currentSelectedDay,
  }) {
    return CalendarState(
      allTasks: allTasks ?? this.allTasks,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      currentSelectedDay: currentSelectedDay ?? this.currentSelectedDay,
    );
  }
}
