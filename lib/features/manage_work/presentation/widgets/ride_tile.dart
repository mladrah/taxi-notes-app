import 'package:flutter/material.dart' hide Title;
import 'package:intl/intl.dart';

import '../../domain/entities/ride.dart';
import '../../domain/entities/work_unit.dart';

class RideTile extends StatelessWidget {
  final WorkUnit workUnit;
  final Ride ride;
  final DateFormat _timeFormatter = DateFormat('HH:mm');
  final DateFormat _dateFormatter = DateFormat('dd.MM');
  RideTile({
    Key? key,
    required this.workUnit,
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
          onTap: () {
            _onTap(context);
          },
          child: Row(
            children: [
              Container(
                // width: 75,
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
                    '${_dateFormatter.format(ride.start)}\n${_timeFormatter.format(ride.start)}',
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
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          child: Text(
                            ride.fromDestination,
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
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          child: Text(
                            ride.toDestination,
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
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.centerLeft,
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
                    // Expanded(
                    //   flex: 1,
                    //   child: Container(
                    //     height: double.infinity,
                    //     alignment: Alignment.center,
                    //     child: FittedBox(
                    //       child: Text(
                    //         '${ride.price.toString().replaceAll('.', ',')} €',
                    //         textAlign: TextAlign.center,
                    //         style: const TextStyle(
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.bold,
                    //           fontStyle: FontStyle.italic,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    Navigator.of(context).pushNamed('/rideDetails',
        arguments: {'ride': ride, 'workUnit': workUnit});
  }
}
