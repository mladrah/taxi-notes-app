part of 'manage_work_bloc.dart';

abstract class ManageWorkEvent extends Equatable {
  const ManageWorkEvent();

  @override
  List<Object> get props => [];
}

class LoadWorkUnitsFromRepository extends ManageWorkEvent {}

class AddRideInWorkUnit extends ManageWorkEvent {
  final WorkUnit? workUnit;
  final Title title;
  final String name;
  final String fromDestination;
  final String toDestination;
  final String licensePlate;
  final DateTime startDate;
  final DateTime startTime;
  final DateTime endDate;
  final DateTime endTime;
  final String price;

  const AddRideInWorkUnit({
    required this.workUnit,
    required this.title,
    required this.name,
    required this.fromDestination,
    required this.toDestination,
    required this.licensePlate,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.price,
  });

  @override
  List<Object> get props => [
        title,
        name,
        fromDestination,
        toDestination,
        licensePlate,
        startDate,
        startTime,
        endDate,
        endTime,
        price,
      ];
}

class DeleteRideFromRepository extends ManageWorkEvent {
  final WorkUnit workUnit;
  final Ride ride;

  const DeleteRideFromRepository({
    required this.workUnit,
    required this.ride,
  });

  @override
  List<Object> get props => [
        workUnit,
        ride,
      ];
}

class UpdateRideInRepository extends ManageWorkEvent {
  final WorkUnit workUnit;
  final Ride oldRide;
  final String id;
  final Title title;
  final String name;
  final String fromDestination;
  final String toDestination;
  final String licensePlate;
  final DateTime startDate;
  final DateTime startTime;
  final DateTime endDate;
  final DateTime endTime;
  final String price;

  const UpdateRideInRepository({
    required this.workUnit,
    required this.oldRide,
    required this.id,
    required this.title,
    required this.name,
    required this.fromDestination,
    required this.toDestination,
    required this.licensePlate,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.price,
  });

  @override
  List<Object> get props => [
        workUnit,
        oldRide,
        id,
        title,
        name,
        fromDestination,
        toDestination,
        licensePlate,
        startDate,
        startTime,
        endDate,
        endTime,
        price
      ];
}

class LoadWorkUnitFromRepository extends ManageWorkEvent {
  final WorkUnit workUnit;

  const LoadWorkUnitFromRepository({
    required this.workUnit,
  });

  @override
  List<Object> get props => [workUnit];
}

class DeleteWorkUnitFromRepository extends ManageWorkEvent {
  final WorkUnit workUnit;

  const DeleteWorkUnitFromRepository({
    required this.workUnit,
  });

  @override
  List<Object> get props => [workUnit];
}
