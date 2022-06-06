import 'package:flutter/material.dart' hide Title;

import '../../domain/entities/ride.dart';

class RideTile extends StatelessWidget {
  final Ride ride;

  const RideTile({
    Key? key,
    required this.ride,
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
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(
          '${ride.start.hour}:${ride.start.minute} - ${ride.end.hour}:${ride.end.minute}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text((ride.title == Title.herr ? 'Hr. ' : 'Fr. ') + ride.name),
        Text(ride.destination),
        Text(
          '${ride.price.toString()} €',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        )
      ]),
    );
  }
}
