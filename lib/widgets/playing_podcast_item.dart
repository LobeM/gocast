import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gocast/data/models/episode_model.dart';
import 'package:gocast/data/models/podcast_model.dart';

class PlayingItem extends StatefulWidget {
  final PodcastModel podcast;
  final int episodeId;

  const PlayingItem({this.podcast, this.episodeId, Key key}) : super(key: key);

  @override
  _PlayingItemState createState() => _PlayingItemState();
}

class _PlayingItemState extends State<PlayingItem> {
  @override
  Widget build(BuildContext context) {
    EpisodeModel episode =
        widget.podcast.episodes.firstWhere((e) => e.id == widget.episodeId);
    if (episode == null) {
      return Container();
    }
    return Material(
      elevation: 8,
      child: Column(
        children: [
          Container(
            height: 60,
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.podcast.imageUrl,
                  fit: BoxFit.cover,
                  width: 60,
                ),
                SizedBox(width: 8),
                Expanded(child: Text(episode.title)),
                IconButton(onPressed: () {}, icon: Icon(Icons.play_arrow)),
              ],
            ),
          ),
          LinearProgressIndicator(value: 0.4),
        ],
      ),
    );
  }
}
