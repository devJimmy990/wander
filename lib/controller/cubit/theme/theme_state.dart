import 'package:flutter/material.dart';

sealed class ThemeState {}

class InitThemeState extends ThemeState {}

class ToggleThemeState extends ThemeState {
  final ThemeData theme;
  ToggleThemeState({required this.theme});
}

class ThemeLoading extends ThemeState {}

class ThemeError extends ThemeState {
  final String error;
  ThemeError({required this.error});
}

class ThemeLoaded extends ThemeState {
  final ThemeData theme;
  ThemeLoaded({required this.theme});
}
