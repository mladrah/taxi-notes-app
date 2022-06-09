import 'package:flutter/material.dart' hide Title;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/ride.dart';

class RideTile extends StatelessWidget {
  final Ride ride;
  final DateFormat _dateFormatter = DateFormat('dd.MM.yyyy');
  final DateFormat _timeFormatter = DateFormat('HH:mm');

  RideTile({
    Key? key,
    required this.ride,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.25),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          // splashColor: Colors.white.withOpacity(0.5),
          // highlightColor: Colors.white.withOpacity(0.25),
          onTap: () {
            _onTap(context);
          },
          child: Padding(
            padding: EdgeInsets.all(48.h),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    '${_timeFormatter.format(ride.start)} -\n${_timeFormatter.format(ride.end)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    (ride.title == Title.herr ? 'Hr. ' : 'Fr. ') + ride.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    ride.destination,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '${ride.price.toString().replaceAll('.', ',')} €',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
