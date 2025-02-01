import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());
  void changeTheme() {
    if (state is DarkTheme) {
      emit(LightTheme());
    } else {
      emit(DarkTheme());
    }
  }
}
