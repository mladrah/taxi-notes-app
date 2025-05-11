import 'package:flutter/material.dart' hide Title;

import '../../../../core/presentation/widgets/custom_box_shadow.dart';
import '../../../../core/util/date_time_formatter.dart';
import '../../domain/entities/ride.dart';
import '../../domain/entities/work_unit.dart';

class RideTile extends StatelessWidget {
  final WorkUnit workUnit;
  final Ride ride;
  final int _flexDate = 1;
  final int _flexTime = 1;
  final int _flexDestination = 1;
  final int _flexName = 1;

  late Color _backgroundColor;
  late Color _textColor;
  late Color _borderColor;

  RideTile({
    Key? key,
    required this.workUnit,
    required this.ride,
  }) : super(key: key);

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
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 75.0,
            ),
            padding:
                const EdgeInsets.only(left: 16, bottom: 8, right: 16, top: 8),
            child: Row(children: [
              Expanded(
                flex: _flexDate,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateTimeFormatter.dayMonth(ride.start),
                    style: TextStyle(
                      color: _textColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: _flexTime,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateTimeFormatter.hourMinute(ride.start),
                    style: TextStyle(
                      color: _textColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: _flexDestination,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ride.fromDestination,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: _textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                flex: _flexDestination,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ride.toDestination,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: _textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                flex: _flexName,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${ride.title == Title.herr ? 'Hr.' : 'Fr.'} ${ride.name}'
                        .replaceAll('', '\u{200B}'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: _textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ]),
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
