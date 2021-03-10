part of 'application_bloc.dart';

@immutable
abstract class ApplicationState {
  @override
  String toString() => '$runtimeType';
}

class InitialApplicationState extends ApplicationState {}

class SetupInProgressApplicationState extends ApplicationState {}

class SetupSuccessApplicationState extends ApplicationState {}

class OnboardingInProgressApplicationState extends ApplicationState {}

class LoadSettingsInProgressApplicationState extends ApplicationState {}

class LoadSettingsSuccessApplicationState extends ApplicationState {}

class LifecycleChangeInProgressApplicationState extends ApplicationState {
  LifecycleChangeInProgressApplicationState(this.state);

  final AppLifecycleState state;

  @override
  String toString() => '$runtimeType ($state)';
}

class UpdateLanguageInProgressApplicationState extends ApplicationState {}

class UpdateLanguageSuccessApplicationState extends ApplicationState {}
