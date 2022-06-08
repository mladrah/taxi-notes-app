import 'package:flutter/material.dart' hide Title;
import 'package:intl/intl.dart';

import '../../domain/entities/ride.dart';

class RideTile extends StatelessWidget {
  final Ride ride;
  final DateFormat _dateFormatter = DateFormat('dd.MM.yyyy');
  final DateFormat _timeFormatter = DateFormat('hh:mm');

  RideTile({
    Key? key,
    required this.ride,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).primaryColor),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          splashColor: Theme.of(context).primaryColor.withAlpha(75),
          highlightColor: Theme.of(context).primaryColor.withAlpha(25),
          onTap: () {
            _onTap(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    '${_timeFormatter.format(ride.start)} -\n${_timeFormatter.format(ride.end)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    (ride.title == Title.herr ? 'Hr. ' : 'Fr. ') + ride.name,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    ride.destination,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '${ride.price.toString().replaceAll('.', ',')} €',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    Navigator.of(context).pushNamed('/rideDetails', arguments: {'ride': ride});
  }
}
