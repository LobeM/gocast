import 'package:flutter/material.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/data/models/top_tab_model.dart';
import 'package:gocast/generated/l10n.dart';
import 'package:gocast/main.dart';
import 'package:gocast/screens/library/widgets/library_tabs.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<TopTabModel> categoryTabs = <TopTabModel>[];

  Future<void> _initGlobals() async {
    categoryTabs.add(TopTabModel.fromJson(<String, dynamic>{
      'id': 0,
      'globalKey': GlobalKey(debugLabel: 'downloads'),
      'label': L10n.current.libraryTabTitle1,
    }));
    categoryTabs.add(TopTabModel.fromJson(<String, dynamic>{
      'id': 1,
      'globalKey': GlobalKey(debugLabel: 'subscriptions'),
      'label': L10n.current.libraryTabTitle2,
    }));
  }

  @override
  void initState() {
    super.initState();
    getIt.get<AppGlobals>().globalKeyLibraryTabs =
        GlobalKey<LibraryTabsState>();

    _initGlobals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                activeExploreTab: 0,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
