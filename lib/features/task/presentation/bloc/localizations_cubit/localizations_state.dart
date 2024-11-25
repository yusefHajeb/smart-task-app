part of 'localizations_cubit.dart';

@freezed
class LocalizationsState with _$LocalizationsState {
  const factory LocalizationsState({
    @Default(Locale('ar')) Locale locale,
  }) = _LocalizationsState;
}
