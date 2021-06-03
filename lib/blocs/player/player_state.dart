part of 'player_bloc.dart';

@immutable
abstract class PlayerState {
  @override
  String toString() => '$runtimeType';
}

class InitialPlayerState extends PlayerState {}

class SelectedPodcastSuccessPlayerState extends PlayerState {}
