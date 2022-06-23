import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/custom_box_shadow.dart';
import '../../../../core/util/date_time_formatter.dart';
import '../../domain/entities/work_unit.dart';

class WorkUnitTile extends StatelessWidget {
  final WorkUnit workUnit;

  const WorkUnitTile({Key? key, required this.workUnit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: CustomBoxShadow.boxShadow(context),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            _onTap(context);
          },
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                  child: FittedBox(
                    child: Text(
                      '${workUnit.rides[0].start.year}\n${DateTimeFormatter.dayMonthInterval(workUnit.rides[0].start, workUnit.rides[workUnit.rides.length - 1].start)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: FittedBox(
                            child: Text(
                              '${workUnit.rides.length.toString()} ${workUnit.rides.length > 1 ? 'Fahrten' : 'Fahrt'}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Expanded(
                      //   child: Container(
                      //     alignment: Alignment.center,
                      //     child: const FittedBox(
                      //       child: Text(
                      //         'XX:XXh',
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: Container(
                      //     alignment: Alignment.center,
                      //     child: const FittedBox(
                      //       child: Text(
                      //         'XX €',
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.bold,
                      //           fontStyle: FontStyle.italic,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    Navigator.of(context)
        .pushNamed('/workUnit', arguments: {'workUnit': workUnit});
  }
}
