part of 'application_bloc.dart';

@immutable
abstract class ApplicationEvent {
  @override
  String toString() => '$runtimeType';
}

class SetupApplicationEvent extends ApplicationEvent {}

class SettingsLoadedApplicaionEvent extends ApplicationEvent {}

class LifecycleChangedApplicaionEvent extends ApplicationEvent {
  LifecycleChangedApplicaionEvent({this.state});

  final AppLifecycleState state;
}

class ChangeRequestedLanguageApplicationEvent extends ApplicationEvent {
  ChangeRequestedLanguageApplicationEvent(this.locale);

  @override
  String toString() => '$runtimeType ($locale)';

  final Locale locale;
}
