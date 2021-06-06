import 'package:flutter/material.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/main.dart';
import 'package:gocast/screens/explore/explore.dart';
import 'package:gocast/screens/forgot_password.dart';
import 'package:gocast/screens/library/library.dart';
import 'package:gocast/screens/podcast/podcast.dart';
import 'package:gocast/screens/profile/profile.dart';
import 'package:gocast/screens/sign_up.dart';

/// Generate [MaterialPageRoute] for our screens.
class Routes {
  static const String podcast = '/podcast';
  static const String explore = '/explore';
  static const String library = '/library';
  static const String profile = '/profile';
  static const String signUp = '/signUp';
  static const String forgotPassword = '/forgotPassword';

  /// Global routes
  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case signUp:
        return MaterialPageRoute<SignUpScreen>(
          builder: (BuildContext context) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: SignUpScreen(),
            );
          },
        );
      case forgotPassword:
        return MaterialPageRoute<ForgotPasswordScreen>(
          builder: (BuildContext context) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: ForgotPasswordScreen(),
            );
          },
        );
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

  /// Explore tab routes
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

  /// Library tab routes
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

  /// Profile tab routes
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
