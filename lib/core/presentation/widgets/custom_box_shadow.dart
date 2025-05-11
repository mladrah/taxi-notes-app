import 'package:flutter/material.dart';

class CustomBoxShadow {
  static List<BoxShadow> boxShadow(
      {required BuildContext context,
      required Color color,
      spreadRadius = 3.0,
      blurRadius = 7.0,
      offset = const Offset(0, 0)}) {
    return [
      BoxShadow(
        color: color,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        offset: offset,
      ),
    ];
  }
}
