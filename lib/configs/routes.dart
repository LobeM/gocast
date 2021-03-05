import 'package:flutter/material.dart';
import 'package:gocast/screens/empty.dart';

/// Generate [MaterialPageRoute] for our screens.
class Routes {
  static const String location = '/location';

  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case location:
        return MaterialPageRoute<EmptyScreen>(
          builder: (BuildContext context) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: EmptyScreen(),
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
