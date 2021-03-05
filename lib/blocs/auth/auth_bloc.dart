import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gocast/blocs/base_bloc.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/data/models/user_model.dart';
import 'package:gocast/main.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is NewPasswordRequestedAuthEvent) {
      yield* _mapRequestedNewPasswordRequestedAuthEventToState(event);
    } else if (event is UserRegisteredAuthEvent) {
      yield* _mapOnUserRegisteredAuthEventToState(event);
    } else if (event is LoginRequestedAuthEvent) {
      yield* _mapLoginAuthEventToState(event);
    } else if (event is UserSavedAuthEvent) {
      yield* _mapSaveUserAuthEventToState(event);
    } else if (event is ProfileLoadedAuthEvent) {
      yield* _mapGetProfileAuthEventToState();
    } else if (event is UserLoggedOutAuthEvent) {
      yield* _mapLogoutAuthEventToState();
    } else if (event is UserClearedAuthEvent) {
      yield* _mapClearUserAuthEventToState();
    }
  }

  Stream<AuthState> _mapRequestedNewPasswordRequestedAuthEventToState(
      NewPasswordRequestedAuthEvent event) async* {
    yield ProcessInProgressAuthState();

    // Wait for some random time. Simulate net activity ;)
    await Future<int>.delayed(Duration(seconds: Random().nextInt(2)));

    yield ForgetPasswordSuccessAuthState();
  }

  Stream<AuthState> _mapOnUserRegisteredAuthEventToState(
      UserRegisteredAuthEvent event) async* {
    yield ProcessInProgressAuthState();

    // Wait for some random time. Simulate net activity ;)
    await Future<int>.delayed(Duration(seconds: Random().nextInt(2)));

    add(UserSavedAuthEvent(getIt.get<AppGlobals>().user));
    yield LoginSuccessAuthState();
  }

  Stream<AuthState> _mapLoginAuthEventToState(
      LoginRequestedAuthEvent event) async* {
    yield ProcessInProgressAuthState();

    // Wait for some random time. Simulate net activity ;)
    await Future<int>.delayed(Duration(seconds: Random().nextInt(2)));

    add(UserSavedAuthEvent(getIt.get<AppGlobals>().user));
    yield LoginSuccessAuthState();
  }

  Stream<AuthState> _mapSaveUserAuthEventToState(
      UserSavedAuthEvent event) async* {
    yield ProcessInProgressAuthState();

    // Wait for some random time. Simulate net activity ;)
    // await Future<int>.delayed(Duration(seconds: Random().nextInt(2)));

    yield PreferenceSaveSuccessAuthState();
  }

  Stream<AuthState> _mapGetProfileAuthEventToState() async* {
    yield ProcessInProgressAuthState();

    // Wait for some random time. Simulate net activity ;)
    await Future<int>.delayed(Duration(seconds: Random().nextInt(2)));

    add(UserSavedAuthEvent(getIt.get<AppGlobals>().user));
  }

  Stream<AuthState> _mapLogoutAuthEventToState() async* {
    yield ProcessInProgressAuthState();

    add(UserClearedAuthEvent());
  }

  Stream<AuthState> _mapClearUserAuthEventToState() async* {}
}
