import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gocast/blocs/explore/explore_bloc.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/category_model.dart';
import 'package:gocast/data/models/explore_session_model.dart';
import 'package:gocast/data/models/top_tab_model.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/data/repositories/podcasts_repository.dart';
import 'package:gocast/generated/l10n.dart';
import 'package:gocast/main.dart';
import 'package:gocast/screens/explore/widgets/explore_header.dart';
import 'package:gocast/screens/explore/widgets/explore_tabs.dart';
import 'package:gocast/widgets/episodes_list.dart';
import 'package:gocast/widgets/full_screen_indicator.dart';
import 'package:gocast/widgets/loading_overlay.dart';
import 'package:gocast/widgets/podcasts_carousel.dart';
import 'package:gocast/utils/list.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  // AnimationController _controller;
  // bool _isDataLoaded = false;

  // List<PodcastModel> _topPodcasts;
  // List<PodcastModel> _topEpisodes;

  final PodcastRepository podcastRepository = const PodcastRepository();

  List<TopTabModel> categoryTabs = <TopTabModel>[];

  ExploreBloc _exploreBloc;

  // Widget _showSubscribedPodcasts() {}

  Widget _showTopPodcasts(List<PodcastModel> podcasts) {
    return PodcastsCarousel(
      podcasts: podcasts,
      title: L10n.of(context).exploreTopPodcasts,
    );
  }

  Widget _showTopEpisodes(List<PodcastModel> podcasts) {
    return EpisodesList(
      podcasts: podcasts,
    );
  }

  // Widget _showTrendingPodcasts() {}

  Future<void> _initGlobals() async {
    // _topPodcasts = await podcastRepository.getTopPodcasts();
    // _topEpisodes = await podcastRepository.getTopEpisodes();
    // if (mounted) {
    //   // setState(() => _isDataLoaded = true);
    // }

    /// First tab in the list is ALL (categories).
    categoryTabs.add(TopTabModel.fromJson(<String, dynamic>{
      'id': 0,
      'globalKey': GlobalKey(debugLabel: 'categoryTab_for_you'),
      'label': L10n.current.exploreLabelForYou,
    }));

    /// Other tabs in the list will be added from the location category list.
    for (final CategoryModel category in getIt.get<AppGlobals>().categories) {
      categoryTabs.add(TopTabModel.fromJson(<String, dynamic>{
        'id': category.id,
        'globalKey':
            GlobalKey(debugLabel: 'categoryTab_' + category.id.toString()),
        'label': category.title,
      }));
    }

    /// Initialize the explore session
    _exploreBloc.add(SessionInitiatedExploreEvent(
      activeExploreTab: categoryTabs.first.id,
    ));
  }

  @override
  void initState() {
    super.initState();
    _exploreBloc = BlocProvider.of<ExploreBloc>(context);
    // _controller = AnimationController(vsync: this);
    getIt.get<AppGlobals>().globalKeyExploreTabs =
        GlobalKey<ExploreTabsState>();
    _initGlobals();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreBloc, ExploreState>(
      buildWhen: (ExploreState previousState, ExploreState currentState) {
        /// Return true/false to determine whether or not to rebuild the widget
        /// with state.
        return currentState is InitialExploreState ||
            currentState is RefreshSuccessExploreState;
      },
      builder: (BuildContext context, ExploreState state) {
        // While the screen state is initializing we shall show a full screen
        // progress indicator and init the search session.
        if (state is InitialExploreState) {
          return FullScreenIndicator(
            color: Theme.of(context).cardColor,
            backgroundColor: Theme.of(context).cardColor,
          );
        }

        /// Session is initialized and/or refreshed.
        final ExploreSessionModel session =
            (state as RefreshSuccessExploreState).session;

        /// Lets see what's in it and show the results on the screen.
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            body: SafeArea(
              child: LoadingOverlay(
                isLoading: session.isLoading,
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
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      flexibleSpace: ExploreTabs(
                        key: getIt.get<AppGlobals>().globalKeyExploreTabs,
                        exploreTabs: categoryTabs,
                        activeExploreTab: session.activeExploreTab,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        <Widget>[
                          if (session.topPodcasts.isNotNullOrEmpty)
                            _showTopPodcasts(session.topPodcasts),
                          if (session.topEpisodes.isNotNullOrEmpty)
                            _showTopEpisodes(session.topEpisodes),
                          const Padding(
                              padding: EdgeInsets.only(bottom: kPaddingL)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
