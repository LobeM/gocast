import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/main.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(InitialPlayerState());

  @override
  Stream<PlayerState> mapEventToState(PlayerEvent event) async* {
    if (event is SelectedPodcastPlayerEvent) {
      yield* _mapSelectedPodcastPlayerEventToState(event);
    }
  }

  Stream<PlayerState> _mapSelectedPodcastPlayerEventToState(
      SelectedPodcastPlayerEvent event) async* {
    getIt.get<AppGlobals>().selectedPodcast = event.podcast;
    getIt.get<AppGlobals>().selectedEpisode = event.episodeId;

    yield SelectedPodcastSuccessPlayerState();
  }
}
