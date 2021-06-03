import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gocast/blocs/auth/auth_bloc.dart';
import 'package:gocast/blocs/player/player_bloc.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/configs/routes.dart';
import 'package:gocast/data/models/bottom_bar_item_model.dart';
import 'package:gocast/main.dart';
import 'package:gocast/utils/bottom_bar_items.dart';
import 'package:gocast/utils/string.dart';
import 'package:gocast/widgets/playing_podcast_item.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  /// Creates the bottom bar items.
  List<BottomNavigationBarItem> _bottomBarItems(BuildContext context) {
    getIt.get<BottomBarItems>().clear();
    getIt
        .get<BottomBarItems>()
        .add(const BottomBarItemModel(id: 'explore', icon: Icons.explore));
    getIt
        .get<BottomBarItems>()
        .add(const BottomBarItemModel(id: 'library', icon: Icons.headset));
    getIt
        .get<BottomBarItems>()
        .add(const BottomBarItemModel(id: 'profile', icon: Icons.person));

    final List<BottomNavigationBarItem> bottomBarItems =
        <BottomNavigationBarItem>[];

    for (final BottomBarItemModel item
        in getIt.get<BottomBarItems>().getItems()) {
      bottomBarItems.add(BottomNavigationBarItem(
        icon: Icon(item.icon),
        label: item.id.toTitleCases(),
      ));
    }

    return bottomBarItems;
  }

  // var json = {
  //   "id": 2,
  //   "title": "The Daily",
  //   "author": "The New York Times",
  //   "image_url":
  //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjZt805JMihjChbsRmtabBwt86kFvGcdEdzg2Fg-rP_hPUo6We",
  //   "description":
  //       "This is what the news should sound like. The biggest stories of our time, told by the best journalists in the world. Hosted by Michael Barbaro. Twenty minutes a day, five days a week, ready by 6 a.m.",
  //   "episodes": [
  //     {
  //       "id": 1,
  //       "title": "‘We Have to Prove Democracy Still Works’",
  //       "description":
  //           "In his first speech to a joint session of Congress, President Biden set out an expansive vision for the role of American government. He spent much of the address detailing his proposals for investing in the nation’s economic future — spending that would total \$4 trillion.\nWe analyze the president’s address and his plans for remaking the American economy.\n\nGuest: Jim Tankersley, a White House correspondent for The New York Times.",
  //       "duration": 27,
  //       "upload_date": "2021-04-29T11:00:00Z",
  //       "url":
  //           "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3"
  //     },
  //     {
  //       "id": 2,
  //       "title": "Fear and Loss: Inside India’s Coronavirus Crisis",
  //       "description":
  //           "At the beginning of this year, many people in India thought the worst of the pandemic was finished there. But in the last few weeks, any sense of ease has given way to widespread fear.\n\nThe country is suffering from the worst coronavirus outbreak in the world, with people being turned away from full hospitals and a scarcity of medical oxygen.\n\nHow did India, after successfully containing the virus last year, get to this point?\n\nGuest: Jeffrey Gettleman, the South Asia bureau chief for The New York Times, based in New Delhi.",
  //       "duration": 24,
  //       "upload_date": "2021-04-28T11:00:00Z",
  //       "url": "https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3"
  //     },
  //     {
  //       "id": 3,
  //       "title": "Can the U.S. Win Back Its Climate Credibility?",
  //       "description":
  //           "During a global climate summit, President Biden signaled America’s commitment to fighting climate change with an ambitious target: The U.S. will cut its economywide carbon emissions by 50 percent of 2005 levels by 2030.\n\nWhat became clear is that the rest of the world has become cautious about following the United States’ lead after years of commitments shifting from one administration to the next.\n\nWhat happened at the summit and how can the U.S. regain its credibility in the struggle against climate change?\n\nGuest: Coral Davenport, who covers energy and environmental policy for The New York Times, with a focus on climate change.",
  //       "duration": 27,
  //       "upload_date": "2021-04-27T11:00:00Z",
  //       "url":
  //           "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3"
  //     }
  //   ]
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (BuildContext context, AuthState state) {
                return IndexedStack(
                  index: _selectedIndex,
                  children: [
                    Navigator(onGenerateRoute: Routes().generateExploreRoute),
                    Navigator(onGenerateRoute: Routes().generateLibraryRoute),
                    Navigator(onGenerateRoute: Routes().generateProfileRoute),
                  ],
                );
              },
            ),
          ),
          // PlayingItem(podcast: PodcastModel.fromJson(json), episodeId: 2),
          BlocBuilder<PlayerBloc, PlayerState>(
              builder: (BuildContext context, PlayerState state) {
            return PlayingItem(
              podcast: getIt.get<AppGlobals>().selectedPodcast,
              episodeId: getIt.get<AppGlobals>().selectedEpisode,
            );
          }),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        key: getIt.get<AppGlobals>().globalKeyBottomBar,
        items: _bottomBarItems(context),
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
