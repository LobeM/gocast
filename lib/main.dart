import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_is_emulator/flutter_is_emulator.dart';
import 'package:get_it/get_it.dart';
import 'package:gocast/blocs/app_observer.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/configs/app_theme.dart';
import 'package:gocast/main_app.dart';
import 'package:gocast/utils/app_preferences.dart';
import 'package:gocast/utils/bottom_bar_items.dart';

GetIt getIt = GetIt.instance;

void main() async {
  // Ensure that plugin services are initialized
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Init service locator singletons.
  initServiceLocator();

  // Init remote logging service.
  createLogger();

  /// Running on emulator or real device?
  getIt.get<AppGlobals>().isEmulator =
      await FlutterIsEmulator.isDeviceAnEmulatorOrASimulator;

  /// The App's [BlocObserver].
  Bloc.observer = AppObserver();

  // Initialize firebase
  await Firebase.initializeApp();

  // Inflate the MainApp widget.
  runApp(MainApp());
}

/// Remote logging with Flutter on the logz.io ELK stack.
void createLogger() {
  // if (!kReleaseMode || kLogzioToken.isEmpty) {
  if (!kReleaseMode) {
    return;
  }

  // Logger.root.level = Level.ALL;

  // LogzIoApiAppender(
  //   apiToken: kLogzioToken,
  //   url: kLogzioUrl,
  //   labels: <String, String>{'version': kAppVersion},
  // ).attachToLogger(Logger.root);
}

/// Registers all the singletons we need by passing a factory function.
void initServiceLocator() async {
  getIt.registerLazySingleton<AppTheme>(() => AppTheme());
  getIt.registerLazySingleton<AppGlobals>(() => AppGlobals());
  getIt.registerLazySingleton<BottomBarItems>(() => BottomBarItems());

  final AppPreferences appPreferencesInstance =
      await AppPreferences.getInstance();
  getIt.registerSingleton<AppPreferences>(appPreferencesInstance);
}
