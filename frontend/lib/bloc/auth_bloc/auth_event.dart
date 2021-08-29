part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class ResetAuthEvent extends AuthEvent {}

class LoginUserEvent extends AuthEvent {
  LoginUserEvent({required this.email, required this.password});
  final String email;
  final String password;
}

class SignOutEvent extends AuthEvent {}

class SignInUserEvent extends AuthEvent {
  SignInUserEvent({required this.email, required this.password});
  final String email;
  final String password;
}
