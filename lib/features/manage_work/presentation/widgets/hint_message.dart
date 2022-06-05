import 'package:flutter/material.dart';

class HintMessage extends StatelessWidget {
  final String message;

  const HintMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
            height: 1.75,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).hintColor),
      ),
    );
  }
}
