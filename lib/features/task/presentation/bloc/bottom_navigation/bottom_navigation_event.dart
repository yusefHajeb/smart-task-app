part of 'bottom_navigation_bloc.dart';

@immutable
sealed class BottomNavigationEvent {}

class BottomNavigationInitial extends BottomNavigationEvent {}

class BottomNavigationTabChanged extends BottomNavigationEvent {
  final int index;

  BottomNavigationTabChanged(this.index);
}
