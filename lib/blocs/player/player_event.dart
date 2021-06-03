part of 'player_bloc.dart';

@immutable
abstract class PlayerEvent {
  @override
  String toString() => '$runtimeType';
}

class SelectedPodcastPlayerEvent extends PlayerEvent {
  final PodcastModel podcast;
  final int episodeId;

  SelectedPodcastPlayerEvent(this.podcast, this.episodeId);
}
