part of 'manage_work_bloc.dart';

abstract class ManageWorkState extends Equatable {
  const ManageWorkState();

  @override
  List<Object> get props => [];
}

class Empty extends ManageWorkState {}

class Loading extends ManageWorkState {}

// ignore: must_be_immutable
class Loaded extends ManageWorkState {
  List<Ride> allRides;

  Loaded({required this.allRides});
}

class Error extends ManageWorkState {
  final String message;

  const Error({required this.message});
}
