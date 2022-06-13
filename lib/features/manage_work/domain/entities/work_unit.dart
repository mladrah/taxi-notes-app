import 'package:equatable/equatable.dart';

import 'ride.dart';

class WorkUnit extends Equatable {
  final String id;
  final List<Ride> rides;

  const WorkUnit({required this.id, required this.rides});

  @override
  List<Object> get props => [id, rides];

  String get monthName {
    List<String> months = [
      'Januar',
      'Februar',
      'März',
      'April',
      'Mai',
      'Juni',
      'Juli',
      'August',
      'September',
      'Oktober',
      'November',
      'Dezember'
    ];

    return months[rides[0].start.month];
  }
}
