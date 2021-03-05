part of 'theme_bloc.dart';

abstract class ThemeState {
  @override
  String toString() => '$runtimeType';
}

class InitialThemeState extends ThemeState {}

class UpdateInProgressThemeState extends ThemeState {}

class UpdateSuccessThemeState extends ThemeState {}
