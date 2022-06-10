import 'package:flutter/material.dart';

class EmptyListHintMessage extends StatelessWidget {
  const EmptyListHintMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          style: TextStyle(color: Theme.of(context).hintColor),
          children: [
            const TextSpan(
              text: 'Keine Arbeit!\n',
            ),
            WidgetSpan(
              child: Icon(
                Icons.add_circle_rounded,
                size: 16,
                color: Theme.of(context).hintColor,
              ),
            ),
            const TextSpan(text: ' drücken, um zu erstellen.')
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
