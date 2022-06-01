import 'ride.dart';
import 'work_unit.dart';

class WorkDay extends WorkUnit {
  final List rides;

  const WorkDay({required date, this.rides = const <Ride>[]})
      : super(date: date);

  @override
  List<Object> get props => [date, rides];
}
