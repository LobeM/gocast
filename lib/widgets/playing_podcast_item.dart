import 'package:audio_session/audio_session.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/data/models/audio_metadata.dart';
import 'package:gocast/data/models/episode_model.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/data/models/position_data.dart';
import 'package:gocast/main.dart';
import 'package:gocast/screens/player/player.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class PlayingItem extends StatefulWidget {
  final PodcastModel podcast;
  final int episodeId;

  const PlayingItem({this.podcast, this.episodeId, Key key}) : super(key: key);

  @override
  _PlayingItemState createState() => _PlayingItemState();
}

class _PlayingItemState extends State<PlayingItem> {
  ConcatenatingAudioSource _playlist;

  void _playingTapped(
    BuildContext context,
    PodcastModel podcast,
    int episodeId,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PlayerScreen(getIt.get<AppGlobals>().player),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
  }

  Future<void> _init() async {
    // Start playing from selected podcast
    int initialIndex = 0;
    List<AudioSource> episodes = [];
    if (widget.podcast != null) {
      for (var i = 0; i < widget.podcast.episodes.length; i++) {
        episodes.add(AudioSource.uri(Uri.parse(widget.podcast.episodes[i].url),
            tag: AudioMetadata(
              album: widget.podcast.title,
              title: widget.podcast.episodes[i].title,
              artwork: widget.podcast.imageUrl,
            )));
        if (widget.podcast.episodes[i].id == widget.episodeId) {
          initialIndex = i;
        }
      }
    }

    _playlist = ConcatenatingAudioSource(children: episodes);

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
  }

  @override
  Widget build(BuildContext context) {
    _init();
    if (widget.podcast == null) {
      return Container();
    }
    EpisodeModel episode =
        widget.podcast.episodes.firstWhere((e) => e.id == widget.episodeId);
    if (episode == null || getIt.get<AppGlobals>().player == null) {
      return Container();
    }
    return Material(
      elevation: 8,
      child: Column(
        children: [
          InkWell(
            onTap: () =>
                _playingTapped(context, widget.podcast, widget.episodeId),
            child: Container(
              height: 60,
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  StreamBuilder<SequenceState>(
                    stream: getIt.get<AppGlobals>().player.sequenceStateStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<SequenceState> snapshot) {
                      final state = snapshot.data;
                      if (state == null || state.sequence.isEmpty ?? true)
                        return SizedBox();
                      final metadata = state.currentSource.tag as AudioMetadata;
                      return Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: metadata.artwork,
                              fit: BoxFit.cover,
                              width: 60,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                metadata.title,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  StreamBuilder<PlayerState>(
                    stream: getIt.get<AppGlobals>().player.playerStateStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<PlayerState> snapshot) {
                      final PlayerState playerState = snapshot.data;
                      final ProcessingState processingState =
                          playerState?.processingState;
                      final bool playing = playerState?.playing;
                      if (processingState == ProcessingState.loading ||
                          processingState == ProcessingState.buffering) {
                        return Container();
                      } else if (playing != true) {
                        return IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: getIt.get<AppGlobals>().player.play,
                        );
                      } else if (processingState != ProcessingState.completed) {
                        return IconButton(
                          icon: Icon(Icons.pause),
                          onPressed: getIt.get<AppGlobals>().player.pause,
                        );
                      } else {
                        return IconButton(
                          icon: Icon(Icons.replay),
                          onPressed: () => getIt.get<AppGlobals>().player.seek(
                              Duration.zero,
                              index: getIt
                                  .get<AppGlobals>()
                                  .player
                                  .effectiveIndices
                                  .first),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder<Duration>(
            stream: getIt.get<AppGlobals>().player.durationStream,
            builder: (context, snapshot) {
              final duration = snapshot.data ?? Duration.zero;
              return StreamBuilder<PositionData>(
                stream: Rx.combineLatest2<Duration, Duration, PositionData>(
                    getIt.get<AppGlobals>().player.positionStream,
                    getIt.get<AppGlobals>().player.bufferedPositionStream,
                    (position, bufferedPosition) =>
                        PositionData(position, bufferedPosition)),
                builder: (context, snapshot) {
                  final positionData = snapshot.data ??
                      PositionData(Duration.zero, Duration.zero);
                  var position = positionData.position;
                  if (position > duration) {
                    position = duration;
                  }
                  var bufferedPosition = positionData.bufferedPosition;
                  if (bufferedPosition > duration) {
                    bufferedPosition = duration;
                  }
                  if (duration.inMilliseconds.toDouble() == 0) {
                    return LinearProgressIndicator(
                      backgroundColor: Colors.grey[300],
                      value: 0,
                    );
                  }
                  return LinearProgressIndicator(
                    backgroundColor: Colors.grey[300],
                    value: (position.inMilliseconds.toDouble() /
                        duration.inMilliseconds.toDouble()),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
