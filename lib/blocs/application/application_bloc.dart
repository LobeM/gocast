import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gocast/blocs/auth/auth_bloc.dart';
import 'package:gocast/blocs/theme/theme_bloc.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/configs/app_theme.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/repositories/podcasts_repository.dart';
import 'package:gocast/generated/l10n.dart';
import 'package:gocast/main.dart';
import 'package:gocast/utils/app_preferences.dart';
import 'package:gocast/utils/string.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc({
    this.authBloc,
    this.themeBloc,
  }) : super(InitialApplicationState());

  final AuthBloc authBloc;
  final ThemeBloc themeBloc;

  @override
  Stream<ApplicationState> mapEventToState(ApplicationEvent event) async* {
    if (event is SetupApplicationEvent) {
      yield* _mapSetupApplicationEventToState();
    } else if (event is SettingsLoadedApplicaionEvent) {
      yield* _mapSettingsLoadedApplicationEventToState();
    } else if (event is OnboardingCompletedApplicationEvent) {
      yield* _mapCompletedOnboardingApplicationEventToState();
    } else if (event is LifecycleChangedApplicaionEvent) {
      yield* _mapLifecycleChangedApplicationEventToState(event);
    } else if (event is ChangeRequestedLanguageApplicationEvent) {
      yield* _mapChangeRequestedLanguageApplicationEventToState(event);
    }
  }

  Stream<ApplicationState> _mapSetupApplicationEventToState() async* {
    yield SetupInProgressApplicationState();

    /// Load server/global settings.
    add(SettingsLoadedApplicaionEvent());

    /// Get the previously selected language from preferences.
    final String selectedLanguage =
        getIt.get<AppPreferences>().getString(PreferenceKey.language);

    /// Save current language to globals
    if (selectedLanguage.isNullOrEmpty) {
      add(ChangeRequestedLanguageApplicationEvent(kDefaultLocale));
    } else {
      add(ChangeRequestedLanguageApplicationEvent(Locale(selectedLanguage)));
    }

    /// Get the previously selected dark option from preferences.
    final String selectedDarkOption =
        getIt.get<AppPreferences>().getString(PreferenceKey.darkOption);

    /// Deafult dark option is 'dynamic'.
    DarkOption darkOption = DarkOption.dynamic;

    // Validate the selected dark option.
    if (selectedDarkOption.isNotNullOrEmpty) {
      darkOption = DarkOption.values.firstWhere(
          (DarkOption e) => e.toString() == selectedDarkOption,
          orElse: () => DarkOption.dynamic);
    }
    // Save the dark option value for future use.
    getIt.get<AppGlobals>().darkThemeOption = darkOption;
    themeBloc.add(ChangeRequestedThemeEvent(
        darkOption: getIt.get<AppGlobals>().darkThemeOption));

    /// Get the current app version.
    final String oldVersion =
        getIt.get<AppPreferences>().getString(PreferenceKey.appVersion);

    /// Is the user onboarded already?
    getIt.get<AppGlobals>().isUserOnboarded =
        getIt.get<AppPreferences>().containsKey(PreferenceKey.isOnboarded);

    // New install/version?
    if (oldVersion != kAppVersion) {
      // Save the new version info.
      await getIt
          .get<AppPreferences>()
          .setString(PreferenceKey.appVersion, kAppVersion);
      // Clear logged in user info, and force to re-login.
      // await getIt.get<AppPreferences>().remove(PreferenceKey.user);
    } else {
      if (getIt.get<AppGlobals>().isUserOnboarded) {
        authBloc.add(ProfileLoadedAuthEvent());
      }
    }
  }

  Stream<ApplicationState> _mapSettingsLoadedApplicationEventToState() async* {
    yield LoadSettingsInProgressApplicationState();

    // Load any settings
    getIt.get<AppGlobals>().categories =
        await const PodcastRepository().getCategories();

    yield LoadSettingsSuccessApplicationState();
  }

  Stream<ApplicationState>
      _mapCompletedOnboardingApplicationEventToState() async* {
    // Save the info about completed onboarding process to shared preferences.
    await getIt.get<AppPreferences>().setBool(PreferenceKey.isOnboarded, true);

    getIt.get<AppGlobals>().isUserOnboarded = true;
  }

  Stream<ApplicationState> _mapLifecycleChangedApplicationEventToState(
      LifecycleChangedApplicaionEvent event) async* {
    yield LifecycleChangeInProgressApplicationState(event.state);
  }

  Stream<ApplicationState> _mapChangeRequestedLanguageApplicationEventToState(
      ChangeRequestedLanguageApplicationEvent event) async* {
    yield UpdateLanguageInProgressApplicationState();

    getIt.get<AppGlobals>().selectedLocale = event.locale;

    await getIt
        .get<AppPreferences>()
        .setString(PreferenceKey.language, event.locale.toString());

    L10n.load(event.locale);

    yield UpdateLanguageSuccessApplicationState();
  }
}
