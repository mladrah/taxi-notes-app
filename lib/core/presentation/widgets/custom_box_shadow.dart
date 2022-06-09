import 'package:flutter/material.dart';

class CustomBoxShadow {
  static List<BoxShadow> boxShadow(BuildContext context) {
    return [
      BoxShadow(
        color: Theme.of(context).primaryColor.withOpacity(0.25),
        spreadRadius: 3,
        blurRadius: 7,
        offset: const Offset(0, 0),
      ),
    ];
  }
}
