// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class L10n {
  L10n();
  
  static L10n current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<L10n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      L10n.current = L10n();
      
      return L10n.current;
    });
  } 

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  /// `Hi {name}!`
  String exploreTitleUser(Object name) {
    return Intl.message(
      'Hi $name!',
      name: 'exploreTitleUser',
      desc: '',
      args: [name],
    );
  }

  /// `Explore`
  String get exploreTitleGuest {
    return Intl.message(
      'Explore',
      name: 'exploreTitleGuest',
      desc: '',
      args: [],
    );
  }

  /// `Listen to your favourite podcasts`
  String get exploreHeaderSubtitle {
    return Intl.message(
      'Listen to your favourite podcasts',
      name: 'exploreHeaderSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Search for podcasts`
  String get explorePlaceholderSearch {
    return Intl.message(
      'Search for podcasts',
      name: 'explorePlaceholderSearch',
      desc: '',
      args: [],
    );
  }

  /// `Top Podcasts`
  String get exploreTopPodcasts {
    return Intl.message(
      'Top Podcasts',
      name: 'exploreTopPodcasts',
      desc: '',
      args: [],
    );
  }

  /// `For You`
  String get exploreLabelForYou {
    return Intl.message(
      'For You',
      name: 'exploreLabelForYou',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get onboardingBtnSkip {
    return Intl.message(
      'Skip',
      name: 'onboardingBtnSkip',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get onboardingBtnGetStarted {
    return Intl.message(
      'Get Started',
      name: 'onboardingBtnGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Access endless hours of free podcasts`
  String get onboardingPage1Title {
    return Intl.message(
      'Access endless hours of free podcasts',
      name: 'onboardingPage1Title',
      desc: '',
      args: [],
    );
  }

  /// `With over 95 million volumes of spoken audio content we have something for everyone.`
  String get onboardingPage1Body {
    return Intl.message(
      'With over 95 million volumes of spoken audio content we have something for everyone.',
      name: 'onboardingPage1Body',
      desc: '',
      args: [],
    );
  }

  /// `Listen offline`
  String get onboardingPage2Title {
    return Intl.message(
      'Listen offline',
      name: 'onboardingPage2Title',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy your favourite podcast anywhere by downloading them to play offline and on the go!`
  String get onboardingPage2Body {
    return Intl.message(
      'Enjoy your favourite podcast anywhere by downloading them to play offline and on the go!',
      name: 'onboardingPage2Body',
      desc: '',
      args: [],
    );
  }

  /// `More than listening`
  String get onboardingPage3Title {
    return Intl.message(
      'More than listening',
      name: 'onboardingPage3Title',
      desc: '',
      args: [],
    );
  }

  /// `Connect with hosts and creators you love with this easy to use app.`
  String get onboardingPage3Body {
    return Intl.message(
      'Connect with hosts and creators you love with this easy to use app.',
      name: 'onboardingPage3Body',
      desc: '',
      args: [],
    );
  }

  /// `{day, select, monday {Monday} tuesday {Tuesday} wednesday {Wednesday} thursday {Thursday} friday {Friday} saturday {Saturday} sunday {Sunday} other {Unknown}}`
  String commonWeekdayLong(Object day) {
    return Intl.select(
      day,
      {
        'monday': 'Monday',
        'tuesday': 'Tuesday',
        'wednesday': 'Wednesday',
        'thursday': 'Thursday',
        'friday': 'Friday',
        'saturday': 'Saturday',
        'sunday': 'Sunday',
        'other': 'Unknown',
      },
      name: 'commonWeekdayLong',
      desc: '',
      args: [day],
    );
  }

  /// `{day, select, monday {Mon} tuesday {Tue} wednesday {Wed} thursday {Thu} friday {Fri} saturday {Sat} sunday {Sun} other {Unknown}}`
  String commonWeekdayShort(Object day) {
    return Intl.select(
      day,
      {
        'monday': 'Mon',
        'tuesday': 'Tue',
        'wednesday': 'Wed',
        'thursday': 'Thu',
        'friday': 'Fri',
        'saturday': 'Sat',
        'sunday': 'Sun',
        'other': 'Unknown',
      },
      name: 'commonWeekdayShort',
      desc: '',
      args: [day],
    );
  }

  /// `{day, select, january {January} february {February} march {March} april {April} may {May} june {June} july {July} august {August} september {September} october {October} november {November} december {December} other {Unknown}}`
  String commonMonthLong(Object day) {
    return Intl.select(
      day,
      {
        'january': 'January',
        'february': 'February',
        'march': 'March',
        'april': 'April',
        'may': 'May',
        'june': 'June',
        'july': 'July',
        'august': 'August',
        'september': 'September',
        'october': 'October',
        'november': 'November',
        'december': 'December',
        'other': 'Unknown',
      },
      name: 'commonMonthLong',
      desc: '',
      args: [day],
    );
  }

  /// `{day, select, january {Jan} february {Feb} march {Mar} april {Apr} may {May} june {Jun} july {Jul} august {Aug} september {Sep} october {Oct} november {Nov} december {Dec} other {Unknown}}`
  String commonMonthShort(Object day) {
    return Intl.select(
      day,
      {
        'january': 'Jan',
        'february': 'Feb',
        'march': 'Mar',
        'april': 'Apr',
        'may': 'May',
        'june': 'Jun',
        'july': 'Jul',
        'august': 'Aug',
        'september': 'Sep',
        'october': 'Oct',
        'november': 'Nov',
        'december': 'Dec',
        'other': 'Unknown',
      },
      name: 'commonMonthShort',
      desc: '',
      args: [day],
    );
  }

  /// `Today`
  String get commonWeekdayToday {
    return Intl.message(
      'Today',
      name: 'commonWeekdayToday',
      desc: '',
      args: [],
    );
  }

  /// `Tomorrow`
  String get commonWeekdayTomorrow {
    return Intl.message(
      'Tomorrow',
      name: 'commonWeekdayTomorrow',
      desc: '',
      args: [],
    );
  }

  /// `{value} min`
  String commonDurationFormat(Object value) {
    return Intl.message(
      '$value min',
      name: 'commonDurationFormat',
      desc: '',
      args: [value],
    );
  }

  /// `1 day, {hours} hours ago`
  String commonElapsedDayHours(Object hours) {
    return Intl.message(
      '1 day, $hours hours ago',
      name: 'commonElapsedDayHours',
      desc: '',
      args: [hours],
    );
  }

  /// `{days} days ago`
  String commonElapsedDays(Object days) {
    return Intl.message(
      '$days days ago',
      name: 'commonElapsedDays',
      desc: '',
      args: [days],
    );
  }

  /// `1 hour, {mins} mins ago`
  String commonElapseHhourMins(Object mins) {
    return Intl.message(
      '1 hour, $mins mins ago',
      name: 'commonElapseHhourMins',
      desc: '',
      args: [mins],
    );
  }

  /// `{hours} hours ago`
  String commonElapsedHours(Object hours) {
    return Intl.message(
      '$hours hours ago',
      name: 'commonElapsedHours',
      desc: '',
      args: [hours],
    );
  }

  /// `{mins} mins ago`
  String commonElapsedMins(Object mins) {
    return Intl.message(
      '$mins mins ago',
      name: 'commonElapsedMins',
      desc: '',
      args: [mins],
    );
  }

  /// `now`
  String get commonElapsedNow {
    return Intl.message(
      'now',
      name: 'commonElapsedNow',
      desc: '',
      args: [],
    );
  }

  /// `{mins} min`
  String commonDurationMins(Object mins) {
    return Intl.message(
      '$mins min',
      name: 'commonDurationMins',
      desc: '',
      args: [mins],
    );
  }

  /// `{hours} hr`
  String commonDurationHours(Object hours) {
    return Intl.message(
      '$hours hr',
      name: 'commonDurationHours',
      desc: '',
      args: [hours],
    );
  }

  /// `{hours} hr {mins} min`
  String commonDurationHourMin(Object hours, Object mins) {
    return Intl.message(
      '$hours hr $mins min',
      name: 'commonDurationHourMin',
      desc: '',
      args: [hours, mins],
    );
  }

  /// `Downloads`
  String get libraryTabTitle1 {
    return Intl.message(
      'Downloads',
      name: 'libraryTabTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Subscriptions`
  String get libraryTabTitle2 {
    return Intl.message(
      'Subscriptions',
      name: 'libraryTabTitle2',
      desc: '',
      args: [],
    );
  }

  /// `My Subscriptions`
  String get profileTitleSubscriptions {
    return Intl.message(
      'My Subscriptions',
      name: 'profileTitleSubscriptions',
      desc: '',
      args: [],
    );
  }

  /// `My Downloads`
  String get profileTitleDownloads {
    return Intl.message(
      'My Downloads',
      name: 'profileTitleDownloads',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get profileTitleEdit {
    return Intl.message(
      'Edit Profile',
      name: 'profileTitleEdit',
      desc: '',
      args: [],
    );
  }

  /// `Connect`
  String get profileTitleConnect {
    return Intl.message(
      'Connect',
      name: 'profileTitleConnect',
      desc: '',
      args: [],
    );
  }

  /// `Share GoCast`
  String get profileTitleShare {
    return Intl.message(
      'Share GoCast',
      name: 'profileTitleShare',
      desc: '',
      args: [],
    );
  }

  /// `Rate Us`
  String get profileTitleRate {
    return Intl.message(
      'Rate Us',
      name: 'profileTitleRate',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get profileTitleHelp {
    return Intl.message(
      'Help',
      name: 'profileTitleHelp',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get profileTitleMore {
    return Intl.message(
      'More',
      name: 'profileTitleMore',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get profileTitleSettings {
    return Intl.message(
      'Settings',
      name: 'profileTitleSettings',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get profileTitleAbout {
    return Intl.message(
      'About us',
      name: 'profileTitleAbout',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<L10n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<L10n> load(Locale locale) => L10n.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}