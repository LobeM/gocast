part of 'theme_bloc.dart';

abstract class ThemeEvent {
  @override
  String toString() => '$runtimeType';
}

class ChangeRequestedThemeEvent extends ThemeEvent {
  ChangeRequestedThemeEvent({this.darkOption});

  final DarkOption darkOption;
}
