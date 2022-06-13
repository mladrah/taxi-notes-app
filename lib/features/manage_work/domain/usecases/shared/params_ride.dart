import 'package:equatable/equatable.dart';

import '../../entities/ride.dart';
import '../../entities/work_unit.dart';

class WorkUnitRidesParams extends Equatable {
  final WorkUnit workUnit;
  final Ride ride;

  const WorkUnitRidesParams({required this.workUnit, required this.ride});

  @override
  List<Object> get props => [workUnit, ride];
}
