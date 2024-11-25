import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_task/core/services/sheard_prefrence_service.dart';

part 'localizations_state.dart';
part 'localizations_cubit.freezed.dart';

class LocalizationsCubit extends Cubit<LocalizationsState> {
  LocalizationsCubit() : super(const LocalizationsState());

  Future<void> changeLanguage(String languageCode) async {
    await SharedPrefrenceHelper.setData("language", languageCode);
    emit(state.copyWith(locale: Locale(languageCode)));
  }

  Future<void> getSavedLanguage() async {
    String? language = await SharedPrefrenceHelper.getData("language");
    emit(state.copyWith(locale: Locale(language ?? "en")));
  }
}
