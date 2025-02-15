import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/core/shared_preference.dart';
import 'package:wander/controller/cubit/theme/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  bool _isDark = false;

  ThemeCubit() : super(InitThemeState());

  void loadTheme() {
    emit(ThemeLoading());
    try {
      String? theme = SharedPreference.getString(key: "theme");
      _isDark = theme == "dark";
      emit(ThemeLoaded(theme: currentTheme));
    } catch (e) {
      emit(ThemeError(error: e.toString()));
    }
  }

  void toggleTheme() {
    emit(ThemeLoading());
    try {
      _isDark = !_isDark;
      emit(ToggleThemeState(theme: currentTheme));
    } catch (e) {
      emit(ThemeError(error: e.toString()));
    }
  }

  ThemeData get currentTheme => _isDark ? ThemeData.dark() : ThemeData.light();
  bool get isDarkTheme => _isDark;
}
