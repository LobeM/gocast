import 'package:flutter/material.dart';
import 'package:gocast/data/models/podcast_model.dart';

class DownloadsTab extends StatefulWidget {
  const DownloadsTab({Key key, this.podcasts}) : super(key: key);

  final List<PodcastModel> podcasts;

  @override
  _DownloadsTabState createState() => _DownloadsTabState();
}

class _DownloadsTabState extends State<DownloadsTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Downloads: "),
    );
  }
}
