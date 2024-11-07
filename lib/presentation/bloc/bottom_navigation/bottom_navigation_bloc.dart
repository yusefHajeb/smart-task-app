import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavigationState(index: 0)) {
    on<BottomNavigationTabChanged>((event, emit) {
      emit(BottomNavigationState(index: event.index));
    });
  }
}
