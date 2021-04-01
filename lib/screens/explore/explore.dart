import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/category_model.dart';
import 'package:gocast/data/models/explore_tab_model.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/data/repositories/podcasts_repository.dart';
import 'package:gocast/generated/l10n.dart';
import 'package:gocast/main.dart';
import 'package:gocast/screens/explore/widgets/explore_header.dart';
import 'package:gocast/screens/explore/widgets/explore_tabs.dart';
import 'package:gocast/widgets/episodes_list.dart';
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
  List<PodcastModel> _topEpisodes;

  final PodcastRepository podcastRepository = const PodcastRepository();

  List<ExploreTabModel> categoryTabs = <ExploreTabModel>[];

  Widget _showSubscribedPodcasts() {}

  Widget _showTopPodcasts() {
    return PodcastsCarousel(
      podcasts: _topPodcasts,
      title: L10n.of(context).exploreTopPodcasts,
    );
  }

  Widget _showTopEpisodes() {
    return EpisodesList(
      podcasts: _topEpisodes,
    );
  }

  Widget _showTrendingPodcasts() {}

  Future<void> _loadData() async {
    _topPodcasts = await podcastRepository.getTopPodcasts();
    _topEpisodes = await podcastRepository.getTopEpisodes();
    if (mounted) {
      setState(() => _isDataLoaded = true);
    }

    /// First tab in the list is ALL (categories).
    categoryTabs.add(ExploreTabModel.fromJson(<String, dynamic>{
      'id': 0,
      'globalKey': GlobalKey(debugLabel: 'categoryTab_for_you'),
      'label': L10n.current.exploreLabelForYou,
    }));

    /// Other tabs in the list will be added from the location category list.
    for (final CategoryModel category in getIt.get<AppGlobals>().categories) {
      categoryTabs.add(ExploreTabModel.fromJson(<String, dynamic>{
        'id': category.id,
        'globalKey':
            GlobalKey(debugLabel: 'categoryTab_' + category.id.toString()),
        'label': category.title,
      }));
    }

    /// Initialize the explore session
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
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: ExploreHeader(expandedHeight: 220),
                // delegate: ExploreHeader(expandedHeight: 280),
                pinned: false,
              ),
              SliverAppBar(
                primary: false,
                floating: true,
                pinned: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                flexibleSpace: ExploreTabs(
                  key: getIt.get<AppGlobals>().globalKeyExploreTabs,
                  exploreTabs: categoryTabs,
                  activeExploreTab: 0,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    _showTopPodcasts(),
                    _showTopEpisodes(),
                    const Padding(padding: EdgeInsets.only(bottom: kPaddingL)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
