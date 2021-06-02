import 'package:audio_session/audio_session.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gocast/data/models/audio_metadata.dart';
import 'package:gocast/data/models/episode_model.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/data/models/position_data.dart';
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
  AudioPlayer _player;
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
      builder: (context) => PlayerScreen(_player),
    );
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    _playlist = ConcatenatingAudioSource(
      children: widget.podcast.episodes
          .map((episode) => AudioSource.uri(Uri.parse(episode.url),
              tag: AudioMetadata(
                album: widget.podcast.title,
                title: episode.title,
                artwork: widget.podcast.imageUrl,
              )))
          .toList(),
    );

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await _player.setAudioSource(_playlist);
    } catch (e) {
      // Catch load errors: 404, invalid url ...
      print("Error loading playlist: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EpisodeModel episode =
        widget.podcast.episodes.firstWhere((e) => e.id == widget.episodeId);
    if (episode == null || _player == null) {
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
                    stream: _player.sequenceStateStream,
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
                    stream: _player.playerStateStream,
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
                          onPressed: _player.play,
                        );
                      } else if (processingState != ProcessingState.completed) {
                        return IconButton(
                          icon: Icon(Icons.pause),
                          onPressed: _player.pause,
                        );
                      } else {
                        return IconButton(
                          icon: Icon(Icons.replay),
                          onPressed: () => _player.seek(Duration.zero,
                              index: _player.effectiveIndices.first),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder<Duration>(
            stream: _player.durationStream,
            builder: (context, snapshot) {
              final duration = snapshot.data ?? Duration.zero;
              return StreamBuilder<PositionData>(
                stream: Rx.combineLatest2<Duration, Duration, PositionData>(
                    _player.positionStream,
                    _player.bufferedPositionStream,
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
                      value: 0,
                    );
                  }
                  return LinearProgressIndicator(
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
