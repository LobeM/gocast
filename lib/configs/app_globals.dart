// Class to store runtime global settings.
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gocast/configs/app_theme.dart';
import 'package:gocast/data/models/user_model.dart';

class AppGlobals {
  factory AppGlobals() => instance;

  AppGlobals._();

  /// Dark Theme option
  DarkOption darkThemeOption = DarkOption.dynamic;

  // Singleton instance
  static final AppGlobals instance = AppGlobals._();

  /// [GlobalKey] for our bottom bar.
  GlobalKey globalKeyBottomBar;

  /// [GlobalKey] for our [HomeScreen].
  GlobalKey globalKeyHomeScreen;

  /// [GlobalKey] for our [ExploreScreen].
  GlobalKey globalKeyExploreScreen;

  /// [GlobalKey] for tab bar in [ExploreScreen].
  GlobalKey globalKeyExploreTabs;

  /// Logged in user data.
  UserModel user;

  /// Currently selected [Locale].
  Locale selectedLocale;

  /// Is user onbaorded or this is their first run?
  bool isUserOnboarded = false;

  /// App is running on emulator (or real device)?
  bool isEmulator;

  /// Is the current locale RTL?
  bool isRTL;

  /// The current brightness mode of the host platform.
  Brightness get getPlatformBrightness =>
      SchedulerBinding.instance.window.platformBrightness;

  /// Is the current brightness mode of the host platform dark?
  bool get isPlatformBrightnessDark {
    switch (darkThemeOption) {
      case DarkOption.alwaysOff:
        return false;
        break;
      case DarkOption.alwaysOn:
        return true;
      default:
        return Brightness.dark == getPlatformBrightness;
    }
  }
}
