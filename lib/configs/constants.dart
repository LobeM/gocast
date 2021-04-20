import 'package:flutter/material.dart';

const String kAppName = 'GoCast';
const String kAppVersion = '1.0.0';

/// Default theme font.
///
/// Use null for system font or font name declared in pubspec.yaml like Roboto
/// or Raleway.
const String kFontFamily = null;

// Date/time formats
const String kDateFormat = 'MMM d, y';
const String kDateTimeFormat = 'MMM d, y HH:mm';
const String kTimeFormat = 'HH:mm';

// Various Sizes
const double kBottomBarIconSize = 32.0;
const double kBoxDecorationRadius = 8.0;
const double kFormFieldsRadius = 6.0;
const double kRoundedButtonRadius = 24.0;
const double kCardRadius = 24.0;
const double kBadgeRadius = 16.0;
const double kTimelineDateSize = 88.0;

// Colors
const Color kPrimaryColor = Colors.blue;
const Color kBlueGrey = Colors.blueGrey;
const Color kGrey = Colors.grey;
const Color kWhite = Color(0xFFFFFFFF);
const Color kBlack = Color(0xFF000000);
const Color kGold = Color(0xFFF3C952);
const Color kTransparent = Colors.transparent;

// Padding
const double kPaddingS = 10.0;
const double kPaddingM = 20.0;
const double kPaddingL = 40.0;

// Avatar sizes
const double kCircleAvatarSizeRadiusAppBar = 20.0;
const double kCircleAvatarSizeRadiusSmall = 24.0;
const double kCircleAvatarSizeRadiusLarge = 48.0;

// Animations
const Duration kRippleAnimationDuration = Duration(milliseconds: 600);
const Duration kButtonAnimationDuration = Duration(milliseconds: 200);
const Duration kPaymentCardAnimationDuration = Duration(milliseconds: 500);

/// Minimal query string length.
const int kMinimalNameQueryLength = 3;

/// Minimal password string length.
const int kMinimalPasswordLength = 8;

/// SnackBar duration in miliseconds (short).
const int kSnackBarDurationShort = 2500;

/// SnackBar duration in miliseconds (long).
const int kSnackBarDurationLong = 10000;

/// Default locale.
const Locale kDefaultLocale = Locale('en');

/// Random list of 10
const List<int> kTenNumberList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

/// Password match regex string.
///
/// - Require that at least one digit appear anywhere in the string
/// - Require that at least one uppercase letter appear anywhere in the string
/// - The password must be at least 8 characters long
const String kPasswordRegex = r'^(?=.*[0-9])(?=.*[A-Z]).{8,}$';

/// Logz.io Token for remote logging.
/// Settings > General > Account Settings
const String kLogzioToken = 'flqmcXGLTlkodgJqPSpNpFCblcRQvukD';

/// Logz.io remote Url.
/// This largely depends which region you selected during registration.
const String kLogzioUrl = 'https://listener-uk.logz.io:8071/';

/// Assets images
class AssetsImages {
  static const String background = 'assets/images/background.jpg';
  static const String onboardingAudioPlayer =
      'assets/images/onboarding/audio_player.svg';
  static const String onboardingPodcast =
      'assets/images/onboarding/podcast.svg';
  static const String onboardingWalkInTheCity =
      'assets/images/onboarding/walk_in_the_city.svg';
}

/// Preference keys used to store/read values using [AppPreferences].
class PreferenceKey {
  static const String appVersion = 'appVersion';
  static const String isOnboarded = 'isOnboarded';
  static const String user = 'user';
  static const String token = 'token';
  static const String language = 'language';
  static const String notification = 'notification';
  static const String darkOption = 'darkOption';
}
