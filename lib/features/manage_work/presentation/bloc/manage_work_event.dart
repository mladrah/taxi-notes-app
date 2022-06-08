part of 'manage_work_bloc.dart';

abstract class ManageWorkEvent extends Equatable {
  const ManageWorkEvent();

  @override
  List<Object> get props => [];
}

class AddRideToRepository extends ManageWorkEvent {
  final Title title;
  final String name;
  final String destination;
  final DateTime startDate;
  final DateTime startTime;
  final DateTime endDate;
  final DateTime endTime;
  final String price;

  const AddRideToRepository(
      {required this.title,
      required this.name,
      required this.destination,
      required this.startDate,
      required this.startTime,
      required this.endDate,
      required this.endTime,
      required this.price});

  @override
  List<Object> get props =>
      [title, name, destination, startDate, startTime, endDate, endTime, price];
}

class DeleteRideFromRepository extends ManageWorkEvent {
  final Ride ride;

  const DeleteRideFromRepository({required this.ride});

  @override
  List<Object> get props => [ride];
}

class UpdateRideInRepository extends ManageWorkEvent {
  final String id;
  final Title title;
  final String name;
  final String destination;
  final DateTime startDate;
  final DateTime startTime;
  final DateTime endDate;
  final DateTime endTime;
  final String price;

  const UpdateRideInRepository(
      {required this.id,
      required this.title,
      required this.name,
      required this.destination,
      required this.startDate,
      required this.startTime,
      required this.endDate,
      required this.endTime,
      required this.price});

  @override
  List<Object> get props =>
      [title, name, destination, startDate, startTime, endDate, endTime, price];
}

class LoadRidesFromRepository extends ManageWorkEvent {}
