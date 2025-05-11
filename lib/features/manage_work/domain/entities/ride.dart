import 'package:equatable/equatable.dart';
import 'package:decimal/decimal.dart';

import '../../../../core/util/date_time_formatter.dart';

class Ride extends Equatable {
  final String id;
  final Title title;
  final String name;
  final String fromDestination;
  final String toDestination;
  final String licensePlate;
  final DateTime start;
  final DateTime end;
  final Decimal price;

  const Ride(
      {required this.id,
      required this.title,
      required this.name,
      required this.fromDestination,
      required this.toDestination,
      required this.licensePlate,
      required this.start,
      required this.end,
      required this.price});

  @override
  List<Object> get props => [
        id,
        title,
        name,
        fromDestination,
        toDestination,
        licensePlate,
        start,
        end,
        price,
      ];

  @override
  String toString() {
    return '(Ride) [${DateTimeFormatter.dayMonthYear(start)}] [${DateTimeFormatter.hourMinute(start)}] | [$fromDestination] -> [$toDestination] | [$title] [$name]';
  }
}

enum Title { herr, frau }
