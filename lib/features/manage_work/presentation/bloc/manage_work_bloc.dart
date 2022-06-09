// ignore_for_file: constant_identifier_names
// ignore: unused_import
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_rahmati/core/usecases/usecase.dart';
import 'package:taxi_rahmati/core/util/input_converter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/ride.dart';
import '../../domain/usecases/shared/params_ride.dart';
import '../../domain/usecases/update_ride.dart';
import '../../domain/usecases/delete_ride.dart';
import '../../domain/usecases/add_ride.dart';
import '../../domain/usecases/get_rides.dart';

part 'manage_work_event.dart';
part 'manage_work_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String LOCAL_FAILURE_MESSAGE = 'Local Failure';
const String INVALID_INPUT_DATE_MESSAGE = 'Invalid Date Input';
const String INVALID_INPUT_PRICE_MESSAGE = 'Invalid Price Input';

class ManageWorkBloc extends Bloc<ManageWorkEvent, ManageWorkState> {
  final AddRide addRideUseCase;
  final DeleteRide deleteRideUseCase;
  final UpdateRide updateRideUseCase;
  final GetRides getAllRidesUseCase;
  final InputConverter inputConverter;

  ManageWorkBloc(
      {required this.addRideUseCase,
      required this.deleteRideUseCase,
      required this.updateRideUseCase,
      required this.getAllRidesUseCase,
      required this.inputConverter})
      : super(Loading()) {
    on<AddRideToRepository>(_onAddRideToRepository);
    on<DeleteRideFromRepository>(_onDeleteRideFromRepository);
    on<UpdateRideInRepository>(_onUpdateRideInRepository);
    on<LoadRidesFromRepository>(_onLoadRidesFromRepository);
  }

  void _onAddRideToRepository(AddRideToRepository event, Emitter emit) async {
    bool isFailed = false;
    List<String> errorMessages = [];
    late final DateTime startParsed;
    late final DateTime endParsed;
    late final Decimal priceParsed;

    inputConverter.dateAndTimeToDateTime(event.startDate, event.startTime).fold(
        (failure) {
      isFailed = true;
      errorMessages.add(INVALID_INPUT_DATE_MESSAGE);
    }, (start) => startParsed = start);

    inputConverter.dateAndTimeToDateTime(event.endDate, event.endTime).fold(
        (failure) {
      isFailed = true;
      errorMessages.add(INVALID_INPUT_DATE_MESSAGE);
    }, (end) => endParsed = end);

    inputConverter.stringToDecimal(event.price).fold((failure) {
      isFailed = true;
      errorMessages.add(INVALID_INPUT_PRICE_MESSAGE);
    }, (price) => priceParsed = price);

    if (isFailed) {
      emit(Error(message: errorMessages.join(' | ')));
    } else {
      emit(Loading());

      final result = await addRideUseCase(Params(
          ride: Ride(
              id: const Uuid().v1(),
              title: event.title,
              name: event.name,
              destination: event.destination,
              start: startParsed,
              end: endParsed,
              price: priceParsed)));

      result.fold(
        (failure) => emit(Error(message: _mapFailureToMessage(failure))),
        (ride) => emit(Created()),
      );
    }
  }

  void _onDeleteRideFromRepository(
      DeleteRideFromRepository event, Emitter<ManageWorkState> emit) async {
    emit(Loading());

    final result = await deleteRideUseCase(Params(ride: event.ride));

    result.fold(
        (failure) => emit(Error(message: _mapFailureToMessage(failure))),
        (r) => emit(Deleted()));
  }

  void _onUpdateRideInRepository(
      UpdateRideInRepository event, Emitter<ManageWorkState> emit) async {
    bool isFailed = false;
    List<String> errorMessages = [];
    late final DateTime startParsed;
    late final DateTime endParsed;
    late final Decimal priceParsed;

    inputConverter.dateAndTimeToDateTime(event.startDate, event.startTime).fold(
        (failure) {
      isFailed = true;
      errorMessages.add(INVALID_INPUT_DATE_MESSAGE);
    }, (start) => startParsed = start);

    inputConverter.dateAndTimeToDateTime(event.endDate, event.endTime).fold(
        (failure) {
      isFailed = true;
      errorMessages.add(INVALID_INPUT_DATE_MESSAGE);
    }, (end) => endParsed = end);

    inputConverter.stringToDecimal(event.price).fold((failure) {
      isFailed = true;
      errorMessages.add(INVALID_INPUT_PRICE_MESSAGE);
    }, (price) => priceParsed = price);

    if (isFailed) {
      emit(Error(message: errorMessages.join(' | ')));
    } else {
      emit(Loading());

      final Ride newRide = Ride(
          id: event.id,
          title: event.title,
          name: event.name,
          destination: event.destination,
          start: startParsed,
          end: endParsed,
          price: priceParsed);

      if (event.oldRide == newRide) {
        emit(Updated(ride: event.oldRide));
        log('Not Updated');
        return;
      }

      final result = await updateRideUseCase(
        Params(ride: newRide),
      );

      result.fold(
        (failure) => emit(Error(message: _mapFailureToMessage(failure))),
        (ride) => emit(Updated(ride: ride)),
      );
    }
  }

  void _onLoadRidesFromRepository(
      LoadRidesFromRepository event, Emitter emit) async {
    emit(Loading());

    final result = await getAllRidesUseCase(NoParams());

    result
        .fold((failure) => emit(Error(message: _mapFailureToMessage(failure))),
            (rides) {
      rides.sort((a, b) => a.start.compareTo(b.start));
      emit(Loaded(rides: rides));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case LocalFailure:
        return LOCAL_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
