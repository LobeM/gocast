import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/data/models/top_tab_model.dart';
import 'package:gocast/data/repositories/podcasts_repository.dart';
import 'package:gocast/generated/l10n.dart';
import 'package:gocast/main.dart';
import 'package:gocast/screens/library/widgets/downloads_tab.dart';
import 'package:gocast/screens/library/widgets/library_tabs.dart';
import 'package:gocast/screens/library/widgets/subscriptions_tab.dart';
import 'package:gocast/utils/list.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final List<TopTabModel> categoryTabs = <TopTabModel>[];
  final List<Widget> screens = <Widget>[];
  int _activeTab = 0;

  Future<void> _initGlobals() async {
    List<PodcastModel> _downloads =
        await const PodcastRepository().getTopEpisodes();
    List<PodcastModel> _subscriptions =
        await const PodcastRepository().getTopEpisodes();

    categoryTabs.add(TopTabModel.fromJson(<String, dynamic>{
      'id': 0,
      'globalKey': GlobalKey(debugLabel: 'libraryTab_downloads'),
      'label': L10n.current.libraryTabTitle1,
    }));
    categoryTabs.add(TopTabModel.fromJson(<String, dynamic>{
      'id': 1,
      'globalKey': GlobalKey(debugLabel: 'libraryTab_subscriptions'),
      'label': L10n.current.libraryTabTitle2,
    }));

    screens.add(DownloadsTab(
      podcasts: _downloads,
    ));
    screens.add(SubscriptionsTab(
      podcasts: _subscriptions,
    ));
  }

  void _onTabTapped(int tabIndex) {
    setState(() {
      _activeTab = tabIndex;
    });
  }

  @override
  void initState() {
    getIt.get<AppGlobals>().globalKeyLibraryTabs =
        GlobalKey<LibraryTabsState>();

    _initGlobals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                primary: false,
                floating: true,
                pinned: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                flexibleSpace: LibraryTabs(
                  key: getIt.get<AppGlobals>().globalKeyLibraryTabs,
                  libraryTabs: categoryTabs,
                  activeTab: _activeTab,
                  onTap: _onTabTapped,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[if (screens.isNotNullOrEmpty) screens[_activeTab]],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
