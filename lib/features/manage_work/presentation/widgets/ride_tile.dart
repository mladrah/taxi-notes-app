import 'package:flutter/material.dart' hide Title;
import 'package:intl/intl.dart';

import '../../domain/entities/ride.dart';

class RideTile extends StatelessWidget {
  final Ride ride;
  final DateFormat _timeFormatter = DateFormat('HH:mm');

  RideTile({
    Key? key,
    required this.ride,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
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
          child: Row(
            children: [
              Container(
                width: 75,
                height: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
                child: FittedBox(
                  child: Text(
                    '${_timeFormatter.format(ride.start)} -\n${_timeFormatter.format(ride.end)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: double.infinity,
                  child: Row(children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: FittedBox(
                          child: Text(
                            '${ride.title == Title.herr ? 'Hr.' : 'Fr.'} ${ride.name}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: FittedBox(
                          child: Text(
                            ride.destination,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: FittedBox(
                          child: Text(
                            '${ride.price.toString().replaceAll('.', ',')} €',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Expanded(
                    //   flex: 1,
                    //   child: Text(
                    //     '${ride.price.toString().replaceAll('.', ',')} €',
                    //     textAlign: TextAlign.right,
                    //     style: const TextStyle(
                    //       fontStyle: FontStyle.italic,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ]),
                ),
              )
              // Padding(
              //   padding: const EdgeInsets.all(16),
              //   child: Row(
              //     children: [

              //       SizedBox(
              //         width: 8,
              //       ),

              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    Navigator.of(context).pushNamed('/rideDetails', arguments: {'ride': ride});
  }
}
