part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSuccessfulState extends AuthState {}

class LoginFailedState extends AuthState {
  LoginFailedState({required this.error});
  final String error;
}

class LoginInProcessState extends AuthState {}

class SignOutSuccessfulState extends AuthState {}

class SignOutFailedState extends AuthState {
  SignOutFailedState({required this.error});
  final String error;
}

class SignOutInProcessState extends AuthState {}

class SignInFailedState extends AuthState {
  SignInFailedState({required this.error});
  final String error;
}

class SignInProcessState extends AuthState {}
