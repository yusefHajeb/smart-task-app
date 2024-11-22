import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class OnboardingEvent {}

class CheckOnboarding extends OnboardingEvent {}

class CompleteOnboarding extends OnboardingEvent {}

// States
abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingCompleted extends OnboardingState {}

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial()) {
    on<CheckOnboarding>(_checkOnboarding);
    on<CompleteOnboarding>(_onCompleteOnboarding);
  }

  Future<void> _onCompleteOnboarding(
    CompleteOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('hasCompletedOnboarding') ?? false) {
      emit(OnboardingCompleted());
    } else {
      await prefs.setBool('hasCompletedOnboarding', true);
      emit(OnboardingCompleted());
    }
  }

  Future<void> _checkOnboarding(
    CheckOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('hasCompletedOnboarding') ?? false) {
      emit(OnboardingCompleted());
    } else {
      emit(OnboardingInitial());
    }
  }
}
