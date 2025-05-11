import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/custom_box_shadow.dart';
import '../../../../core/util/date_time_formatter.dart';
import '../../domain/entities/work_unit.dart';

class WorkUnitTile extends StatelessWidget {
  final WorkUnit workUnit;

  late Color _backgroundColor;
  late Color _textColor;
  late Color _borderColor;

  WorkUnitTile({Key? key, required this.workUnit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _backgroundColor = Theme.of(context).colorScheme.secondary;
    _textColor = Theme.of(context).colorScheme.onSecondary;
    _borderColor =
        Theme.of(context).colorScheme.onSecondary.withValues(alpha: 0.1);

    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor, width: 2),
        boxShadow: CustomBoxShadow.boxShadow(
          context: context,
          color:
              Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.125),
          spreadRadius: 0.0,
          blurRadius: 23.0,
        ),
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
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: _borderColor,
                      ),
                    ),
                  ),
                  child: FittedBox(
                    child: Text(
                      '${workUnit.rides[0].start.year}\n${DateTimeFormatter.dayMonthInterval(workUnit.rides[0].start, workUnit.rides[workUnit.rides.length - 1].start)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _textColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
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
                              style: TextStyle(
                                color: _textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
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
