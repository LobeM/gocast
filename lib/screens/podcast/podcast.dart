import 'package:flutter/material.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/data/repositories/podcasts_repository.dart';

class PodcastScreen extends StatefulWidget {
  final int podcastId;

  const PodcastScreen({Key key, this.podcastId = 0}) : super(key: key);
  @override
  _PodcastScreenState createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  PodcastModel _podcastModel;

  Future<void> _loadData() async {
    _podcastModel =
        await const PodcastRepository().getPodcast(widget.podcastId);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.podcastId > 0) {
      return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverAppBar(
              leading: BackButton(),
              expandedHeight: 250.0,
              floating: true,
              pinned: true,
              title: Text(_podcastModel.title),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(color: Colors.red),
                ),
              ),
            )
          ],
          body: Container(),
        ),
      );
    }
    return Container();
  }
}
