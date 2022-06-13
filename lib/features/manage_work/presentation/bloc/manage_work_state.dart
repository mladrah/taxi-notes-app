// ignore_for_file: must_be_immutable

part of 'manage_work_bloc.dart';

abstract class ManageWorkState extends Equatable {
  const ManageWorkState();

  @override
  List<Object> get props => [];
}

class Initial extends ManageWorkState {}

class Loading extends ManageWorkState {}

class WorkUnitsLoaded extends ManageWorkState {
  List<WorkUnit> workUnits;

  WorkUnitsLoaded({required this.workUnits});

  @override
  List<Object> get props => [workUnits];
}

class WorkUnitLoaded extends ManageWorkState {
  WorkUnit workUnit;

  WorkUnitLoaded({required this.workUnit});

  @override
  List<Object> get props => [workUnit];
}

class WorkUnitDeleted extends ManageWorkState {}

class RideAdded extends ManageWorkState {
  WorkUnit workUnit;

  RideAdded({required this.workUnit});

  @override
  List<Object> get props => [workUnit];
}

class RideDeleted extends ManageWorkState {
  WorkUnit workUnit;

  RideDeleted({required this.workUnit});

  @override
  List<Object> get props => [workUnit];
}

class RideUpdated extends ManageWorkState {
  WorkUnit workUnit;

  RideUpdated({required this.workUnit});

  @override
  List<Object> get props => [workUnit];
}

class Error extends ManageWorkState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
