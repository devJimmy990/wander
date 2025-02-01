part of 'theme_cubit.dart';

@immutable
abstract class ThemeState {
  final ThemeData themeData;
  const ThemeState(this.themeData);
}

class ThemeInitial extends ThemeState {
  ThemeInitial() : super(ThemeData.light());
}

class LightTheme extends ThemeState {
  LightTheme() : super(ThemeData.light());
}

class DarkTheme extends ThemeState {
  DarkTheme() : super(ThemeData.dark());
}