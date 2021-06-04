import 'package:audio_session/audio_session.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/data/models/audio_metadata.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/main.dart';
import 'package:just_audio/just_audio.dart';

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

    yield InProgressPlayerState();

    // Stops any playing that was happening before
    getIt.get<AppGlobals>().player.stop();

    // Start playing from selected podcast
    int initialIndex = 0;
    List<AudioSource> episodes = [];
    if (event.podcast != null) {
      for (var i = 0; i < event.podcast.episodes.length; i++) {
        episodes.add(AudioSource.uri(Uri.parse(event.podcast.episodes[i].url),
            tag: AudioMetadata(
              album: event.podcast.title,
              title: event.podcast.episodes[i].title,
              artwork: event.podcast.imageUrl,
            )));
        if (event.podcast.episodes[i].id == event.episodeId) {
          initialIndex = i;
        }
      }
    }

    ConcatenatingAudioSource _playlist =
        ConcatenatingAudioSource(children: episodes);

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    getIt.get<AppGlobals>().player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await getIt
          .get<AppGlobals>()
          .player
          .setAudioSource(_playlist, initialIndex: initialIndex);

      // Start playing audio imediately ready
      getIt.get<AppGlobals>().player.play();
    } catch (e) {
      // Catch load errors: 404, invalid url ...
      print("Error loading playlist: $e");
    }

    yield SelectedPodcastSuccessPlayerState();
  }
}
