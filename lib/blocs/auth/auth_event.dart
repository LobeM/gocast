part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  @override
  String toString() => '$runtimeType';
}

class ProfileLoadedAuthEvent extends AuthEvent {}

class UserLoggedOutAuthEvent extends AuthEvent {}

class UserClearedAuthEvent extends AuthEvent {}

class NewPasswordRequestedAuthEvent extends AuthEvent {
  NewPasswordRequestedAuthEvent(this.email);

  final String email;
}

class LoginRequestedAuthEvent extends AuthEvent {
  LoginRequestedAuthEvent({this.email, this.password});

  final String email;
  final String password;
}

class UserRegisteredAuthEvent extends AuthEvent {
  UserRegisteredAuthEvent({
    this.fullName,
    this.email,
    this.password,
  });

  final String fullName;
  final String email;
  final String password;
}

class UserSavedAuthEvent extends AuthEvent {
  UserSavedAuthEvent(this.user);

  final UserModel user;
}
