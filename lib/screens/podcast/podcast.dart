import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/data/repositories/podcasts_repository.dart';
import 'package:gocast/generated/l10n.dart';
import 'package:gocast/screens/podcast/widgets/podcast_header.dart';
import 'package:gocast/widgets/episode_list_item.dart';
import 'package:gocast/widgets/sliver_app_title.dart';
import 'package:gocast/widgets/strut_text.dart';

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
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: PodcastHeader(podcast: _podcast),
              ),
              title: _podcast != null
                  ? SliverAppTitle(child: Text(_podcast.title))
                  : Container(),
            )
          ],
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
                child: Column(
                  children: [
                    SizedBox(height: kPaddingS),
                    ExpandableText(
                      _podcast.description,
                      expandText: L10n.of(context).more,
                      collapseText: L10n.of(context).less,
                      maxLines: 5,
                      linkColor: kPrimaryColor,
                    )
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                child: Row(
                  children: [
                    StrutText(
                        L10n.of(context).episodeCount(_podcast.episodes.length),
                        style: Theme.of(context).textTheme.headline6),
                    Spacer(),
                    PopupMenuButton(
                      icon: Icon(Icons.sort),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          child: Text('Newest First'),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text('Oldest First'),
                          value: 1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _podcast.episodes.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Column(
                        children: [
                          EpisodeListItem(
                            podcast: _podcast,
                            episodeId: _podcast.episodes[i].id,
                            viewType: EpisodeListItemViewType.basicEpisode1,
                          ),
                          Divider()
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    }
    return Container();
  }
}
