import 'package:flutter/material.dart';

class RideTile extends StatelessWidget {
  // final Title title;
  // final String name;
  // final String destination;
  // final DateTime start;
  // final DateTime end;
  // final Decimal price;

  const RideTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).primaryColor),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.25),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(
          '01:45 - 02:15',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text('Fr. ' + 'Name'),
        Text('Ort'),
        Text(
          '30€',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        )
      ]),
    );
  }
}
