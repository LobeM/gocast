import 'package:flutter/material.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/data/repositories/podcasts_repository.dart';
import 'package:gocast/screens/podcast/widgets/podcast_header.dart';

class PodcastScreen extends StatefulWidget {
  final int podcastId;

  const PodcastScreen({Key key, this.podcastId = 0}) : super(key: key);
  @override
  _PodcastScreenState createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  PodcastModel _podcast;

  Future<void> _loadData() async {
    _podcast = await const PodcastRepository().getPodcast(widget.podcastId);
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
              primary: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: PodcastHeader(
                  imageUrl: _podcast.imageUrl,
                  title: _podcast.title,
                ),
                background: Container(color: Colors.purple),
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
