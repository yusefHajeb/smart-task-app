import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class OnboardingEvent {}

class CompleteOnboarding extends OnboardingEvent {}

// States
abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingCompleted extends OnboardingState {}

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial()) {
    on<CompleteOnboarding>(_onCompleteOnboarding);
  }

  Future<void> _onCompleteOnboarding(
    CompleteOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasCompletedOnboarding', true);
    emit(OnboardingCompleted());
  }
}
