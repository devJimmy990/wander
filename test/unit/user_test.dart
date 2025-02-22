import 'package:flutter_test/flutter_test.dart';
import 'package:wander/controller/cubit/user/user_cubit.dart';
import 'package:wander/controller/cubit/user/user_state.dart';

void main() {
  group('UserCubit Tests', () {
    late UserCubit userCubit;

    setUp(() {
      userCubit = UserCubit();
    });

    test('Initial state should be UserInitial', () {
      expect(userCubit.state, isA<UserInitial>());
    });
  });
}
