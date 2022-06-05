import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  final primaryColor = const Color(0xFFFCA311);
  final textColor = const Color(0xFF001D3D);
  final highlightTextColor = const Color(0xFF003566);
  final greyColor = const Color(0xFFC0C0C0);

  Map<int, Color> primarySwatchColor = {
    50: const Color.fromRGBO(252, 163, 17, .1),
    100: const Color.fromRGBO(252, 163, 17, .2),
    200: const Color.fromRGBO(252, 163, 17, .3),
    300: const Color.fromRGBO(252, 163, 17, .4),
    400: const Color.fromRGBO(252, 163, 17, .5),
    500: const Color.fromRGBO(252, 163, 17, .6),
    600: const Color.fromRGBO(252, 163, 17, .7),
    700: const Color.fromRGBO(252, 163, 17, .8),
    800: const Color.fromRGBO(252, 163, 17, .9),
    900: const Color.fromRGBO(252, 163, 17, 1),
  };

  ThemeData get lighTheme {
    return ThemeData(
        textTheme: GoogleFonts.kodchasanTextTheme(),
        primarySwatch: MaterialColor(0xFFFCA311, primarySwatchColor),
        primaryColor: primaryColor,
        hintColor: greyColor,
        focusColor: highlightTextColor,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: textColor,
          titleTextStyle: GoogleFonts.kodchasan(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ));
  }
}
