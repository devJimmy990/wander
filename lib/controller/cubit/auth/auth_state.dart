import 'package:wander/data/model/user.dart';

sealed class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationLoggedIn extends AuthenticationState {}

class AccountCreated extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final User user;
  Authenticated(this.user);
}

class UnAuthenticated extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final String message;
  AuthenticationError(this.message);
}
