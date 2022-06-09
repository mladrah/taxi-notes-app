import 'package:flutter/material.dart';

class AppThemeData {
  // ignore: prefer_const_constructors
  final _primaryColor = Color(0xff0D0A0B); // default: 0xff0D0A0B

  // ignore: prefer_const_constructors
  final _textColor = Color.fromARGB(255, 0, 0, 0);

  final _focusColor = const Color(0xFF003566);
  final _hintColor = const Color(0xFFC0C0C0);

  ThemeData lighTheme(BuildContext context) {
    Map<int, Color> primaryColorMap = {
      50: Color.fromRGBO(
          _primaryColor.red, _primaryColor.green, _primaryColor.blue, .1),
      100: Color.fromRGBO(
          _primaryColor.red, _primaryColor.green, _primaryColor.blue, .2),
      200: Color.fromRGBO(
          _primaryColor.red, _primaryColor.green, _primaryColor.blue, .3),
      300: Color.fromRGBO(
          _primaryColor.red, _primaryColor.green, _primaryColor.blue, .4),
      400: Color.fromRGBO(
          _primaryColor.red, _primaryColor.green, _primaryColor.blue, .5),
      500: Color.fromRGBO(
          _primaryColor.red, _primaryColor.green, _primaryColor.blue, .6),
      600: Color.fromRGBO(
          _primaryColor.red, _primaryColor.green, _primaryColor.blue, 7),
      700: Color.fromRGBO(
          _primaryColor.red, _primaryColor.green, _primaryColor.blue, .8),
      800: Color.fromRGBO(
          _primaryColor.red, _primaryColor.green, _primaryColor.blue, .9),
      900: Color.fromRGBO(
          _primaryColor.red, _primaryColor.green, _primaryColor.blue, 1),
    };

    return ThemeData(
      textTheme: Theme.of(context).textTheme.apply(
            fontFamily: 'Kodchasan',
            bodyColor: _textColor,
            displayColor: _textColor,
          ),
      primarySwatch:
          MaterialColor(_primaryColor.value.toInt(), primaryColorMap),
      primaryColor: _primaryColor,
      hintColor: _hintColor,
      focusColor: _focusColor,
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
