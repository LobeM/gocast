part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  @override
  String toString() => '$runtimeType';
}

class InitialAuthState extends AuthState {}

class LoginSuccessAuthState extends AuthState {}

class ProcessInProgressAuthState extends AuthState {}

class ForgetPasswordSuccessAuthState extends AuthState {}

class PreferenceSaveSuccessAuthState extends AuthState {}

class AuthenticationFailureAuthState extends AuthState {}

class LogoutSuccessAuthState extends AuthState {}

abstract class ApiFailureAuthState extends AuthState {
  ApiFailureAuthState(this.message);

  final String message;
}

class LoginFailureAuthState extends ApiFailureAuthState {
  LoginFailureAuthState(String message) : super(message);
}

class RegistrationFailureAuthState extends ApiFailureAuthState {
  RegistrationFailureAuthState(String message) : super(message);
}

class LogoutFailureAuthState extends ApiFailureAuthState {
  LogoutFailureAuthState(String message) : super(message);
}
