import 'package:flutter/material.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/main.dart';
import 'package:gocast/screens/explore/explore.dart';
import 'package:gocast/screens/library/library.dart';
import 'package:gocast/screens/podcast/podcast.dart';
import 'package:gocast/screens/profile/profile.dart';

/// Generate [MaterialPageRoute] for our screens.
class Routes {
  static const String podcast = '/podcast';
  static const String explore = '/explore';
  static const String library = '/library';
  static const String profile = '/profile';

  Route<dynamic> generateExploreRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case podcast:
        return MaterialPageRoute<PodcastScreen>(
          builder: (BuildContext context) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: PodcastScreen(podcastId: routeSettings.arguments as int),
            );
          },
        );
      case explore:
      default:
        return MaterialPageRoute<ExploreScreen>(
          builder: (BuildContext context) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: ExploreScreen(
                  key: getIt.get<AppGlobals>().globalKeyExploreScreen),
            );
          },
        );
    }
  }

  Route<dynamic> generateLibraryRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case podcast:
        return MaterialPageRoute<PodcastScreen>(
          builder: (BuildContext context) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: PodcastScreen(podcastId: routeSettings.arguments as int),
            );
          },
        );

      case library:
      default:
        return MaterialPageRoute<LibraryScreen>(
          builder: (BuildContext context) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: LibraryScreen(),
            );
          },
        );
    }
  }

  Route<dynamic> generateProfileRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case profile:
      default:
        return MaterialPageRoute<ProfileScreen>(
          builder: (BuildContext context) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: ProfileScreen(),
            );
          },
        );
    }
  }
}
