import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
part 'app_theme_event.dart';
part 'app_theme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  AppThemeBloc() : super(const AppThemeState(themeMode: ThemeMode.dark)) {
    on<AppThemeChanged>((event, emit) {
      emit(AppThemeState(themeMode: event.themeMode));
    });
  }
}
