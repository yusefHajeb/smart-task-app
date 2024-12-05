import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_task/features/task/domain/usecases/task/get_task.dart';

import '../../../data/models/task.dart';

part 'schedule_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit({required FetchTaskUseCase fetchTasks})
      : super(CalendarState(
            allTasks: [],
            filteredTasks: [],
            currentSelectedDay: DateTime.now().day)) {
    initTasks(fetchTasks);
  }

  void initTasks(FetchTaskUseCase fetchTasks) async {
    print('initTasks');
    final tasks = await fetchTasks.call(1);
    emit(state.copyWith(
        allTasks: tasks,
        filteredTasks: getTasksByDay(
            state.currentSelectedDay ?? DateTime.now().day, tasks)));
  }

  void selectDay(int day) {
    final filteredTasks = getTasksByDay(day, state.allTasks);
    emit(state.copyWith(filteredTasks: filteredTasks, currentSelectedDay: day));
  }

  List<Task> getTasksByDay(int day, List<Task> tasks) {
    return tasks.where((element) => element.dueDate.day == day).toList();
  }
}
