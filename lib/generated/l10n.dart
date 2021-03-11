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