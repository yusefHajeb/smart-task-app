import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/services/sheard_prefrence_service.dart';
part 'app_theme_event.dart';
part 'app_theme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  AppThemeBloc() : super(const AppThemeState(themeMode: ThemeMode.dark)) {
    on<AppThemeChanged>((event, emit) async {
      await SharedPrefrenceHelper.setData(
          "theme", event.themeMode == ThemeMode.dark ? "dark" : "light");
      emit(AppThemeState(themeMode: event.themeMode));
    });
    on<GetSaveTheme>(_getSaveTheme);
  }
  Future<void> _getSaveTheme(
      GetSaveTheme event, Emitter<AppThemeState> emit) async {
    final themeMode = await SharedPrefrenceHelper.getData("theme") ?? "light";
    emit(AppThemeState(
      themeMode: themeMode == "dark" ? ThemeMode.dark : ThemeMode.light,
    ));
  }
}
