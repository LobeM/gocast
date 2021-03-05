import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';

enum DarkOption { dynamic, alwaysOn, alwaysOff }

/// Creates light and dark [ThemeData].
///
/// Default values will be derived for arguments that are omitted.
class AppTheme {
  /// constructs an [AppTheme]
  AppTheme() {
    lightTheme = ThemeData(
      fontFamily: kFontFamily,
      brightness: Brightness.light,
      accentColor: kPrimaryColor,
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: const Color(0xfff8f8f8),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xfff5f5f5),
      ),
      buttonColor: kPrimaryColor,
      buttonTheme: const ButtonThemeData(
        textTheme: ButtonTextTheme.accent,
        minWidth: 88,
        height: 48,
        padding: EdgeInsets.only(left: kPaddingM, right: kPaddingM),
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Color(0xff000000), width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.all(Radius.circular(kFormFieldsRadius)),
        ),
        buttonColor: kPrimaryColor,
        disabledColor: Color(0x61000000),
        highlightColor: Color(0x29000000),
        splashColor: Color(0x1f000000),
        focusColor: Color(0x1f000000),
        hoverColor: Color(0x0a000000),
      ),
      appBarTheme: const AppBarTheme(
        brightness: Brightness.dark,
        color: kPrimaryColor,
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Color(0xFFF0F0F0),
        labelStyle: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        contentPadding: EdgeInsets.only(
          top: 12,
          bottom: 12,
          left: 15,
          right: 15,
        ),
      ),
    );

    darkTheme = ThemeData(
      fontFamily: kFontFamily,
      brightness: Brightness.dark,
      accentColor: kPrimaryColor,
      toggleableActiveColor: kPrimaryColor,
      scaffoldBackgroundColor: const Color(0xff20242b),
      cardColor: const Color(0xff2b2f38),
      bottomAppBarColor: const Color(0xff424242),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900],
      ),
      buttonColor: kPrimaryColor,
      buttonTheme: const ButtonThemeData(
        textTheme: ButtonTextTheme.accent,
        minWidth: 88,
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: kPaddingM),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xff000000),
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.all(Radius.circular(kFormFieldsRadius)),
        ),
        buttonColor: kPrimaryColor,
        disabledColor: Color(0x61000000),
        highlightColor: Color(0x29000000),
        splashColor: Color(0x1f000000),
        focusColor: Color(0x1f000000),
        hoverColor: Color(0x0a000000),
      ),
      appBarTheme: AppBarTheme(
        brightness: Brightness.dark,
        color: Colors.grey[900],
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Color(0xff3b404b),
        labelStyle: TextStyle(
          fontSize: 14,
          color: Colors.white70,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        contentPadding: EdgeInsets.only(
          top: 12,
          bottom: 12,
          left: 15,
          right: 15,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey[900],
        actionTextColor: kWhite,
        contentTextStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white70,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }

  ThemeData lightTheme;
  ThemeData darkTheme;
}
