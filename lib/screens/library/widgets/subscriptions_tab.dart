import 'package:flutter/material.dart';
import 'package:gocast/data/models/podcast_model.dart';

class SubscriptionsTab extends StatefulWidget {
  const SubscriptionsTab({Key key, this.podcasts}) : super(key: key);
  final List<PodcastModel> podcasts;

  @override
  _SubscriptionsTabState createState() => _SubscriptionsTabState();
}

class _SubscriptionsTabState extends State<SubscriptionsTab> {
  // void _initGlobals() async {
  //   _podcasts = await const PodcastRepository().getTopEpisodes();
  // }

  // @override
  // void initState() {
  //   _initGlobals();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("subscriptions: ${widget.podcasts.length}"),
    );
  }
}
