import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_task/features/task/data/models/category.dart';
import 'package:smart_task/features/task/data/models/task.dart';
import 'package:smart_task/features/task/domain/usecases/category/get_categories.dart';
import 'package:smart_task/features/task/domain/usecases/task/update_task.dart';

part 'update_task_state.dart';

class UpdateTaskCubit extends Cubit<UpdateTaskState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  UpdateTaskCubit(
    this.getCategoriesUseCase,
    this.updateTaskUseCase,
  ) : super(const UpdateTaskState());
  void updateTask(Task task) async {
    try {
      await updateTaskUseCase.call(task);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> setTaskForUpdate(Task task) async {
    try {
      emit(state.copyWith(task: task));
      // emit(state.copyWith(task: tasks));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
      ));
    }
  }

  //  ChangeisDailyReminder
  void changeDailyReminder(bool value) {
    emit(state.copyWith(
      task: state.task?.copyWith(isDailyReminder: value),
    ));
  }
}
