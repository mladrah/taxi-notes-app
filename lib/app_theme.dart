import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  ColorScheme get colorScheme => const ColorScheme(
        brightness: Brightness.light,
        surface: Colors.white,
        onSurface: Colors.black,
        primary: Color(0xff0D0A0B),
        onPrimary: Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.black,
        error: Colors.red,
        onError: Colors.white,
      );

  Color get splashColor => colorScheme.onPrimary.withValues(alpha: 0.15);

  ThemeData get lightTheme => ThemeData(
        colorScheme: colorScheme,
        splashColor: splashColor,
        appBarTheme: AppBarTheme(
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 0.0,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: colorScheme.primary,
            )),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          errorStyle: const TextStyle(height: 0.01),
          hintStyle: TextStyle(
            color: colorScheme.onSurface.withValues(alpha: 0.35),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: colorScheme.onSurface.withValues(alpha: 0.35),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        datePickerTheme: DatePickerThemeData(
          headerBackgroundColor: colorScheme.primary,
          headerForegroundColor: colorScheme.onPrimary,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          splashColor: splashColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll<Color>(colorScheme.primary),
              foregroundColor:
                  WidgetStatePropertyAll<Color>(colorScheme.onPrimary),
              textStyle: const WidgetStatePropertyAll<TextStyle>(
                TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              overlayColor: WidgetStatePropertyAll<Color>(
                splashColor,
              )),
        ),
        popupMenuTheme: PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
}
