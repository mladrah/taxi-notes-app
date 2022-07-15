import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DeleteAlert {
  final BuildContext context;
  final VoidCallback onPressed;
  final String title;

  DeleteAlert(
      {required this.context, required this.onPressed, required this.title});

  Alert get alert => Alert(
        context: context,
        type: AlertType.warning,
        desc: title,
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Abbrechen",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.black,
          ),
          DialogButton(
            onPressed: () {
              onPressed();
              Navigator.pop(context);
            },
            child: const Text(
              "Löschen",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            color: Theme.of(context).errorColor,
          ),
        ],
      );
}
