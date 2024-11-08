import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/task.dart';

part 'app_management_event.dart';
part 'app_management_state.dart';

class AppManagementBloc extends Bloc<AppManagementEvent, AppManagementState> {
  AppManagementBloc() : super(AppManagementInitial()) {
    on<AppManagementEvent>((event, emit) {});
  }
}
