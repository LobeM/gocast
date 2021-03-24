import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/data/repositories/podcasts_repository.dart';
import 'package:gocast/generated/l10n.dart';
import 'package:gocast/screens/explore/widgets/explore_header.dart';
import 'package:gocast/widgets/episode_list_item.dart';
import 'package:gocast/widgets/podcasts_carousel.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _isDataLoaded = false;

  List<PodcastModel> _topPodcasts;

  final PodcastRepository podcastRepository = const PodcastRepository();

  Widget _showSubscribedPodcasts() {}

  Widget _showTopPodcasts() {
    return PodcastsCarousel(
      podcasts: _topPodcasts,
      title: L10n.of(context).exploreTopPodcasts,
    );
  }

  Widget _showTrendingPodcasts() {}

  Future<void> _loadData() async {
    _topPodcasts = await podcastRepository.getTopPodcasts();
    if (mounted) {
      setState(() => _isDataLoaded = true);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: ExploreHeader(expandedHeight: 280),
              pinned: false,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  _showTopPodcasts(),
                  EpisodeListItem(),
                  const Padding(padding: EdgeInsets.only(bottom: kPaddingL)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
