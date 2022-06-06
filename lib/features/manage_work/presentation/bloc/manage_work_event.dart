part of 'manage_work_bloc.dart';

abstract class ManageWorkEvent extends Equatable {
  const ManageWorkEvent();

  @override
  List<Object> get props => [];
}

class AddRideToList extends ManageWorkEvent {
  final Title title;
  final String name;
  final String destination;
  final DateTime startDate;
  final DateTime startTime;
  final DateTime endDate;
  final DateTime endTime;
  final String price;

  const AddRideToList(
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

class ListAllRides extends ManageWorkEvent {}
