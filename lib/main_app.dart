import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gocast/blocs/application/application_bloc.dart';
import 'package:gocast/blocs/auth/auth_bloc.dart';
import 'package:gocast/blocs/explore/explore_bloc.dart';
import 'package:gocast/blocs/player/player_bloc.dart';
import 'package:gocast/blocs/theme/theme_bloc.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/configs/app_theme.dart';
import 'package:gocast/configs/routes.dart';
import 'package:gocast/generated/l10n.dart';
import 'package:gocast/main.dart';
import 'package:gocast/screens/onboarding.dart';
import 'package:gocast/screens/splash.dart';
import 'package:gocast/utils/localization.dart';
import 'package:gocast/widgets/bottom_navigation.dart';
import 'package:intl/intl.dart' as intl;

final RouteObserver<PageRoute<dynamic>> routeObserver =
    RouteObserver<PageRoute<dynamic>>();

ApplicationBloc _applicationBloc;
AuthBloc _authBloc;
ThemeBloc _themeBloc;
ExploreBloc _exploreBloc;
PlayerBloc _playerBloc;

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    /// The glue between the widgets layer and the Flutter engine.
    WidgetsBinding.instance.addObserver(this);

    _initGlobalKeys();
    _initBlocs();

    super.initState();
  }

  void _initBlocs() {
    _authBloc = AuthBloc();
    _themeBloc = ThemeBloc();
    _exploreBloc = ExploreBloc();
    _playerBloc = PlayerBloc();

    _applicationBloc = ApplicationBloc(
      authBloc: _authBloc,
      themeBloc: _themeBloc,
    );
  }

  void _initGlobalKeys() {
    getIt.get<AppGlobals>().globalKeyBottomBar =
        GlobalKey(debugLabel: 'bottom_bar');
    getIt.get<AppGlobals>().globalKeyExploreScreen =
        GlobalKey(debugLabel: 'explore_screen');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _applicationBloc.close();
    _authBloc.close();
    _themeBloc.close();
    _exploreBloc.close();
    _playerBloc.close();

    getIt.get<AppGlobals>().player.dispose();

    super.dispose();
  }

  /// Called when the system puts the app in the background or returns the app
  /// to the foreground.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (getIt.get<AppGlobals>().isUserOnboarded) {
      /// Notify ApplicationBloc with a new [LifecycleChangedApplicationEvent].
      _applicationBloc.add(LifecycleChangedApplicaionEvent(state: state));
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<ApplicationBloc>(
            create: (BuildContext context) => _applicationBloc),
        BlocProvider<AuthBloc>(create: (BuildContext context) => _authBloc),
        BlocProvider<ThemeBloc>(create: (BuildContext context) => _themeBloc),
        BlocProvider<ExploreBloc>(
            create: (BuildContext context) => _exploreBloc),
        BlocProvider<PlayerBloc>(create: (BuildContext context) => _playerBloc),
      ],
      child: BlocBuilder<ApplicationBloc, ApplicationState>(
        buildWhen:
            (ApplicationState previousState, ApplicationState currentState) =>
                // Refresh app is lifecycle has been changed to Resume state...
                (currentState is LifecycleChangeInProgressApplicationState &&
                    currentState.state == AppLifecycleState.resumed) ||
                currentState is! LifecycleChangeInProgressApplicationState,
        builder: (BuildContext context, ApplicationState appState) {
          Widget homeWidget;

          if (appState is UpdateLanguageSuccessApplicationState) {
            _initGlobalKeys();
          }

          if (appState is SetupSuccessApplicationState ||
              appState is UpdateLanguageSuccessApplicationState ||
              appState is LifecycleChangeInProgressApplicationState) {
            homeWidget = getIt.get<AppGlobals>().isUserOnboarded
                ? BottomNavigation()
                : OnboardingScreen();
          } else {
            homeWidget = SplashScreen();
          }

          final Locale selectedLocale = getIt.get<AppGlobals>().selectedLocale;
          getIt.get<AppGlobals>().isRTL =
              intl.Bidi.isRtlLanguage(selectedLocale.toString());

          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (BuildContext context, ThemeState theme) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: selectedLocale,
                supportedLocales: L10n.delegate.supportedLocales,
                localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                  L10n.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  FallbackCupertinoLocalisationsDelegate(),
                ],
                localeResolutionCallback:
                    (Locale locale, Iterable<Locale> supportedLocales) =>
                        selectedLocale,
                navigatorObservers: <NavigatorObserver>[routeObserver],
                onGenerateRoute: Routes().generateRoute,
                theme: getIt.get<AppTheme>().lightTheme,
                darkTheme: getIt.get<AppTheme>().darkTheme,
                home: Directionality(
                  textDirection: getIt.get<AppGlobals>().isRTL
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: homeWidget,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
