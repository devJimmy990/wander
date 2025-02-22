import 'package:flutter_test/flutter_test.dart';
import 'package:wander/controller/cubit/theme/theme_cubit.dart';
import 'package:wander/controller/cubit/theme/theme_state.dart';

void main() {
  group('ThemeCubit Tests', () {
    late ThemeCubit themeCubit;

    setUp(() {
      themeCubit = ThemeCubit();
    });

    test('Initial state should be InitThemeState', () {
      expect(themeCubit.state, isA<InitThemeState>());
    });

    test('Toggling theme should emit ToggleThemeState', () {
      themeCubit.toggleTheme();
      expect(themeCubit.state, isA<ToggleThemeState>());
    });
  });
}
