import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme {
  static const Color primaryColor = Color.fromARGB(255, 0, 113, 255);
  static const Color secondayColor = Color(0xff16A8EA);
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFF2f2F2);
  static const Color lighterGrey = Color(0xffF9F9F9);
  static const Color shadowColor = Color(0x1A000000);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color midGrayColor = Color(0xFFC6C6C6);
  static const Color red = Color(0xffDC143C);
  static const Color pinkColor = Color(0xffFF8C94);
  static const Color blueShadowColor = Color(0xffA8E6CE);
  static const Color greenShadowColor = Color(0xffDCEDC2);
  static const Color lightYello = Color(0xffFFD3B5);
  static const Color lightRedColor = Color(0xffFFAAA6);
  static const Color lightPurpleColor = Color.fromARGB(255, 209, 187, 255);
  static const Color primaryShdowColor = Color.fromARGB(255, 141, 189, 255);
  static const Color blueLight = Color(0xffE9EFF8);
  static const Color skyBlue = Color(0xffE6F8FB);
  static const Color darkRed = Color(0xffC62D38);
  static const Color yellow = Color(0xffFFC727);
  static const Color textBlueColor = Color(0xFF2460B9);
  static const Color greenColor = Colors.green;

  static const Color darkGrey = Color(0xff4D4D4D);

  static const double symmetricHozPadding = 12.0;

  static const MaterialColor primarymaterialcolor =
      MaterialColor(_primarymaterialcolorPrimaryValue, <int, Color>{
    50: Color(0xFFE5ECF1),
    100: Color(0xFFBDCEDB),
    200: Color(0xFF92AEC3),
    300: Color(0xFF668EAB),
    400: Color(0xFF457599),
    500: Color(_primarymaterialcolorPrimaryValue),
    600: Color(0xFF20557F),
    700: Color(0xFF1B4B74),
    800: Color(0xFF16416A),
    900: Color(0xFF0D3057),
  });
  static const int _primarymaterialcolorPrimaryValue = 0xFF245D87;

  static const MaterialColor primarymaterialcolorAccent =
      MaterialColor(_primarymaterialcolorAccentValue, <int, Color>{
    100: Color(0xFF8DBDFF),
    200: Color(_primarymaterialcolorAccentValue),
    400: Color(0xFF2783FF),
    700: Color(0xFF0E74FF),
  });
  static const int _primarymaterialcolorAccentValue = 0xFF5AA0FF;

  static ThemeData lightTheme = ThemeData(
    primarySwatch: primarymaterialcolor,
    primaryColor: primaryColor,
    primaryColorDark: primaryColor,
    shadowColor: Colors.black,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: primaryColor),
      // systemOverlayStyle: SystemUiOverlayStyle.dark,

      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: primarymaterialcolorAccent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
    scaffoldBackgroundColor: white,
    iconTheme: const IconThemeData(color: black),
    // fontFamily: GoogleFonts.openSans().fontFamily,
    // fontFamily: Font.quicksand,

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: black,
        fontWeight: FontWeight.bold,
        fontSize: 24,
        height: 1.35,
        letterSpacing: 0.5,
      ),
      displayMedium: TextStyle(
        color: black,
        fontWeight: FontWeight.bold,
        fontSize: 22,
        letterSpacing: 0.5,
        height: 1.35,
      ),
      displaySmall: TextStyle(
        color: black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        letterSpacing: 0.5,
        height: 1.35,
      ),
      headlineMedium: TextStyle(
        fontSize: 18,
        color: black,
        letterSpacing: 0.5,
        height: 1.35,
      ),
      headlineSmall: TextStyle(
        color: black,
        fontSize: 16,
        letterSpacing: 0.5,
        height: 1.35,
      ),
      titleLarge: TextStyle(
        color: black,
        fontSize: 14,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.5,
        height: 1.35,
      ),
      bodySmall: TextStyle(
        color: black,
        fontSize: 8,
        letterSpacing: 0.5,
        height: 1.35,
      ),
      titleSmall: TextStyle(
        color: black,
        fontSize: 12,
        letterSpacing: 0.5,
        height: 1.35,
      ),
      titleMedium: TextStyle(
        color: black,
        fontSize: 10,
        letterSpacing: 0.5,
        height: 1.35,
      ),
      labelLarge: TextStyle(
        color: black,
        fontSize: 12,
        letterSpacing: 0.5,
        height: 1.35,
      ),
      bodyLarge: TextStyle(
        fontSize: 12,
        color: black,
        letterSpacing: 0.5,
        height: 1.35,
      ),
      bodyMedium: TextStyle(
        fontSize: 10,
        color: black,
        letterSpacing: 0.5,
        height: 1.35,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: white),
  );
}
