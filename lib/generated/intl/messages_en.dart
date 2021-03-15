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

  static m0(name) => "Hi ${name}!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "exploreHeaderSubtitle" : MessageLookupByLibrary.simpleMessage("Listen to your favourite podcasts"),
    "explorePlaceholderSearch" : MessageLookupByLibrary.simpleMessage("Search for podcasts"),
    "exploreTitleGuest" : MessageLookupByLibrary.simpleMessage("Explore"),
    "exploreTitleUser" : m0,
    "onboardingBtnGetStarted" : MessageLookupByLibrary.simpleMessage("Get Started"),
    "onboardingBtnSkip" : MessageLookupByLibrary.simpleMessage("Skip"),
    "onboardingPage1Body" : MessageLookupByLibrary.simpleMessage("With over 95 million volumes of spoken audio content we have something for everyone."),
    "onboardingPage1Title" : MessageLookupByLibrary.simpleMessage("Access endless hours of free podcasts"),
    "onboardingPage2Body" : MessageLookupByLibrary.simpleMessage("Enjoy your favourite podcast anywhere by downloading them to play offline and on the go!"),
    "onboardingPage2Title" : MessageLookupByLibrary.simpleMessage("Listen offline"),
    "onboardingPage3Body" : MessageLookupByLibrary.simpleMessage("Connect with hosts and creators you love with this easy to use app."),
    "onboardingPage3Title" : MessageLookupByLibrary.simpleMessage("More than listening")
  };
}
