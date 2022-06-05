import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_rahmati/core/error/failures.dart';
import 'package:taxi_rahmati/core/util/input_converter.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/add_ride.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/get_all_rides.dart';

import '../../domain/entities/ride.dart';

part 'manage_work_event.dart';
part 'manage_work_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String LOCAL_FAILURE_MESSAGE = 'Local Failure';
const String INVALID_INPUT_MESSAGE = 'Invalid Input';

class ManageWorkBloc extends Bloc<ManageWorkEvent, ManageWorkState> {
  final AddRide addRideUseCase;
  final GetAllRides getAllRidesUseCase;
  final InputConverter inputConverter;

  ManageWorkBloc(
      {required this.addRideUseCase,
      required this.getAllRidesUseCase,
      required this.inputConverter})
      : super(Empty()) {
    on<AddRideToList>(_onAddRideToList);
    on<ListAllRides>(_onListAllRides);
  }

  void _onAddRideToList(AddRideToList event, Emitter emit) {
    final inputEither = inputConverter.stringToTitleEnum(event.title);
    // inputConverter.stringToDateTime(event.start);
    // inputConverter.stringToDateTime(event.end);
    // inputConverter.stringToDecimal(event.price);

    inputEither.fold((failure) async {
      emit(const Error(message: INVALID_INPUT_MESSAGE));
    }, (title) => throw UnimplementedError());
  }

  void _onListAllRides(ListAllRides event, Emitter emit) {}
}
