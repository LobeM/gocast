// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(value) => "${value} min";

  static m1(hours, mins) => "${hours} hr ${mins} min";

  static m2(hours) => "${hours} hr";

  static m3(mins) => "${mins} min";

  static m4(mins) => "1 hour, ${mins} mins ago";

  static m5(hours) => "1 day, ${hours} hours ago";

  static m6(days) => "${days} days ago";

  static m7(hours) => "${hours} hours ago";

  static m8(mins) => "${mins} mins ago";

  static m9(day) => "${Intl.select(day, {'january': 'January', 'february': 'February', 'march': 'March', 'april': 'April', 'may': 'May', 'june': 'June', 'july': 'July', 'august': 'August', 'september': 'September', 'october': 'October', 'november': 'November', 'december': 'December', 'other': 'Unknown', })}";

  static m10(day) => "${Intl.select(day, {'january': 'Jan', 'february': 'Feb', 'march': 'Mar', 'april': 'Apr', 'may': 'May', 'june': 'Jun', 'july': 'Jul', 'august': 'Aug', 'september': 'Sep', 'october': 'Oct', 'november': 'Nov', 'december': 'Dec', 'other': 'Unknown', })}";

  static m11(day) => "${Intl.select(day, {'monday': 'Monday', 'tuesday': 'Tuesday', 'wednesday': 'Wednesday', 'thursday': 'Thursday', 'friday': 'Friday', 'saturday': 'Saturday', 'sunday': 'Sunday', 'other': 'Unknown', })}";

  static m12(day) => "${Intl.select(day, {'monday': 'Mon', 'tuesday': 'Tue', 'wednesday': 'Wed', 'thursday': 'Thu', 'friday': 'Fri', 'saturday': 'Sat', 'sunday': 'Sun', 'other': 'Unknown', })}";

  static m13(count) => "${count} Episodes";

  static m14(name) => "Hi ${name}!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "commonDurationFormat" : m0,
    "commonDurationHourMin" : m1,
    "commonDurationHours" : m2,
    "commonDurationMins" : m3,
    "commonElapseHhourMins" : m4,
    "commonElapsedDayHours" : m5,
    "commonElapsedDays" : m6,
    "commonElapsedHours" : m7,
    "commonElapsedMins" : m8,
    "commonElapsedNow" : MessageLookupByLibrary.simpleMessage("now"),
    "commonMonthLong" : m9,
    "commonMonthShort" : m10,
    "commonWeekdayLong" : m11,
    "commonWeekdayShort" : m12,
    "commonWeekdayToday" : MessageLookupByLibrary.simpleMessage("Today"),
    "commonWeekdayTomorrow" : MessageLookupByLibrary.simpleMessage("Tomorrow"),
    "episodeCount" : m13,
    "exploreHeaderSubtitle" : MessageLookupByLibrary.simpleMessage("Listen to your favourite podcasts"),
    "exploreLabelForYou" : MessageLookupByLibrary.simpleMessage("For You"),
    "explorePlaceholderSearch" : MessageLookupByLibrary.simpleMessage("Search for podcasts"),
    "exploreTitleGuest" : MessageLookupByLibrary.simpleMessage("Explore"),
    "exploreTitleUser" : m14,
    "exploreTopPodcasts" : MessageLookupByLibrary.simpleMessage("Top Podcasts"),
    "less" : MessageLookupByLibrary.simpleMessage("less"),
    "libraryTabTitle1" : MessageLookupByLibrary.simpleMessage("Downloads"),
    "libraryTabTitle2" : MessageLookupByLibrary.simpleMessage("Subscriptions"),
    "more" : MessageLookupByLibrary.simpleMessage("more"),
    "onboardingBtnGetStarted" : MessageLookupByLibrary.simpleMessage("Get Started"),
    "onboardingBtnSkip" : MessageLookupByLibrary.simpleMessage("Skip"),
    "onboardingPage1Body" : MessageLookupByLibrary.simpleMessage("With over 95 million volumes of spoken audio content we have something for everyone."),
    "onboardingPage1Title" : MessageLookupByLibrary.simpleMessage("Access endless hours of free podcasts"),
    "onboardingPage2Body" : MessageLookupByLibrary.simpleMessage("Enjoy your favourite podcast anywhere by downloading them to play offline and on the go!"),
    "onboardingPage2Title" : MessageLookupByLibrary.simpleMessage("Listen offline"),
    "onboardingPage3Body" : MessageLookupByLibrary.simpleMessage("Connect with hosts and creators you love with this easy to use app."),
    "onboardingPage3Title" : MessageLookupByLibrary.simpleMessage("More than listening"),
    "profileTitleAbout" : MessageLookupByLibrary.simpleMessage("About us"),
    "profileTitleConnect" : MessageLookupByLibrary.simpleMessage("Connect"),
    "profileTitleDownloads" : MessageLookupByLibrary.simpleMessage("My Downloads"),
    "profileTitleEdit" : MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "profileTitleHelp" : MessageLookupByLibrary.simpleMessage("Help"),
    "profileTitleMore" : MessageLookupByLibrary.simpleMessage("More"),
    "profileTitleRate" : MessageLookupByLibrary.simpleMessage("Rate Us"),
    "profileTitleSettings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "profileTitleShare" : MessageLookupByLibrary.simpleMessage("Share GoCast"),
    "profileTitleSubscriptions" : MessageLookupByLibrary.simpleMessage("My Subscriptions"),
    "subscribe" : MessageLookupByLibrary.simpleMessage("Subscribe"),
    "subscribed" : MessageLookupByLibrary.simpleMessage("Subscribed")
  };
}
