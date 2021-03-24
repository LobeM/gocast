import 'package:flutter/material.dart';
import 'package:gocast/data/models/episode_model.dart';

class EpisodesList extends StatefulWidget {
  const EpisodesList({Key key, this.episodes}) : super(key: key);

  final List<EpisodeModel> episodes;

  @override
  _EpisodesListState createState() => _EpisodesListState();
}

class _EpisodesListState extends State<EpisodesList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
