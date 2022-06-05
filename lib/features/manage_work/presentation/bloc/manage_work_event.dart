part of 'manage_work_bloc.dart';

abstract class ManageWorkEvent extends Equatable {
  const ManageWorkEvent();

  @override
  List<Object> get props => [];
}

class AddRideToList extends ManageWorkEvent {
  final String name;
  final String title;
  final String destination;
  final String start;
  final String end;
  final String price;

  const AddRideToList(this.name, this.title, this.destination, this.start,
      this.end, this.price);

  @override
  List<Object> get props => [name, title, destination, start, end, price];
}

class ListAllRides extends ManageWorkEvent {}
