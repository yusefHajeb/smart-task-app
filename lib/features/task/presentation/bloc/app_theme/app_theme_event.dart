part of 'app_theme_bloc.dart';

class AppThemeEvent {}

class AppThemeChanged extends AppThemeEvent {
  final ThemeMode themeMode;
  AppThemeChanged({required this.themeMode});
}

class GetSaveTheme extends AppThemeEvent {}
