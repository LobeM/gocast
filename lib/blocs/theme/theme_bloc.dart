import 'package:bloc/bloc.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/configs/app_theme.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/main.dart';
import 'package:gocast/utils/app_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(InitialThemeState());

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    /// Update theme style and font.
    if (event is ChangeRequestedThemeEvent) {
      yield* _mapChangeRequestedThemeEventToState(event);
    }
  }

  Stream<ThemeState> _mapChangeRequestedThemeEventToState(
      ChangeRequestedThemeEvent event) async* {
    yield UpdateInProgressThemeState();

    getIt.get<AppGlobals>().darkThemeOption =
        event.darkOption ?? DarkOption.dynamic;

    final AppTheme theme = AppTheme();

    switch (getIt.get<AppGlobals>().darkThemeOption) {
      case DarkOption.dynamic:
        getIt.get<AppTheme>().lightTheme = theme.lightTheme;
        getIt.get<AppTheme>().darkTheme = theme.darkTheme;
        break;
      case DarkOption.alwaysOn:
        getIt.get<AppTheme>().lightTheme = theme.darkTheme;
        getIt.get<AppTheme>().darkTheme = theme.darkTheme;
        break;
      case DarkOption.alwaysOff:
        getIt.get<AppTheme>().lightTheme = theme.lightTheme;
        getIt.get<AppTheme>().darkTheme = theme.darkTheme;
        break;
      default:
        getIt.get<AppTheme>().lightTheme = theme.lightTheme;
        getIt.get<AppTheme>().darkTheme = theme.darkTheme;
        break;
    }

    await getIt.get<AppPreferences>().setString(PreferenceKey.darkOption,
        getIt.get<AppGlobals>().darkThemeOption.toString());

    yield UpdateSuccessThemeState();
  }
}
