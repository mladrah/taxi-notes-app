import 'package:flutter/material.dart';

class AppThemeData {
  // ignore: prefer_const_constructors
  final _primaryColor = Color(0xff0D0A0B); // default: 0xff0D0A0B
  // final _primaryColor = Colors.grey.withOpacity(0.175);

  // ignore: prefer_const_constructors
  final _textColor = Color.fromARGB(255, 0, 0, 0);

  ThemeData lighTheme(BuildContext context) {
    Map<int, Color> primaryColorMap = {
      50: Color.fromRGBO(
          _primaryColor.r.toInt(), _primaryColor.g.toInt(), _primaryColor.b.toInt(), .1),
      100: Color.fromRGBO(
          _primaryColor.r.toInt(), _primaryColor.g.toInt(), _primaryColor.b.toInt(), .2),
      200: Color.fromRGBO(
          _primaryColor.r.toInt(), _primaryColor.g.toInt(), _primaryColor.b.toInt(), .3),
      300: Color.fromRGBO(
          _primaryColor.r.toInt(), _primaryColor.g.toInt(), _primaryColor.b.toInt(), .4),
      400: Color.fromRGBO(
          _primaryColor.r.toInt(), _primaryColor.g.toInt(), _primaryColor.b.toInt(), .5),
      500: Color.fromRGBO(
          _primaryColor.r.toInt(), _primaryColor.g.toInt(), _primaryColor.b.toInt(), .6),
      600: Color.fromRGBO(
          _primaryColor.r.toInt(), _primaryColor.g.toInt(), _primaryColor.b.toInt(), .7),
      700: Color.fromRGBO(
          _primaryColor.r.toInt(), _primaryColor.g.toInt(), _primaryColor.b.toInt(), .8),
      800: Color.fromRGBO(
          _primaryColor.r.toInt(), _primaryColor.g.toInt(), _primaryColor.b.toInt(), .9),
      900: Color.fromRGBO(
          _primaryColor.r.toInt(), _primaryColor.g.toInt(), _primaryColor.b.toInt(), 1),
    };

    return ThemeData(
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: _textColor,
            displayColor: _textColor,
          ),
      primarySwatch:
          MaterialColor(_primaryColor.toARGB32(), primaryColorMap),
      primaryColor: _primaryColor,
      hintColor: Colors.grey.withValues(alpha: 0.75),
      focusColor: _primaryColor.withValues(alpha: 0.15),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: _textColor,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        errorStyle: const TextStyle(height: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
