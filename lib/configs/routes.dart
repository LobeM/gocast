import 'package:flutter/material.dart';
import 'package:gocast/screens/empty.dart';
import 'package:gocast/screens/podcast/podcast.dart';

/// Generate [MaterialPageRoute] for our screens.
class Routes {
  static const String podcast = '/podcast';

  Route<dynamic> generateRoute(RouteSettings routeSettings) {
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
      default:
        return MaterialPageRoute<EmptyScreen>(
          builder: (BuildContext context) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: EmptyScreen(),
            );
          },
        );
    }
  }
}
