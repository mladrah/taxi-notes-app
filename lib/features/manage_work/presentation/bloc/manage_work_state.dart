// ignore_for_file: must_be_immutable

part of 'manage_work_bloc.dart';

abstract class ManageWorkState extends Equatable {
  const ManageWorkState();

  @override
  List<Object> get props => [];
}

class Loading extends ManageWorkState {}

class Loaded extends ManageWorkState {
  List<Ride> rides;

  Loaded({required this.rides});

  @override
  List<Object> get props => [rides];
}

class Created extends ManageWorkState {}

class Deleted extends ManageWorkState {}

class Updated extends ManageWorkState {
  Ride ride;

  Updated({required this.ride});

  @override
  List<Object> get props => [ride];
}

class Error extends ManageWorkState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
