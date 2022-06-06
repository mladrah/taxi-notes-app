// ignore_for_file: constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_rahmati/core/usecases/usecase.dart';
import 'package:taxi_rahmati/core/util/input_converter.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/add_ride.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/get_all_rides.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/ride.dart';

part 'manage_work_event.dart';
part 'manage_work_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String LOCAL_FAILURE_MESSAGE = 'Local Failure';
const String INVALID_INPUT_DATE_MESSAGE = 'Invalid Date Input';
const String INVALID_INPUT_PRICE_MESSAGE = 'Invalid Price Input';

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
    on<LoadAllRides>(_onLoadAllRides);
  }

  void _onAddRideToList(AddRideToList event, Emitter emit) async {
    bool isFailed = false;
    List<String> errorMessages = [];
    late final DateTime startParsed;
    late final DateTime endParsed;
    late final Decimal priceParsed;

    inputConverter.dateTimesToDateTime(event.startDate, event.startTime).fold(
        (failure) {
      isFailed = true;
      errorMessages.add(INVALID_INPUT_DATE_MESSAGE);
    }, (start) => startParsed = start);

    inputConverter.dateTimesToDateTime(event.endDate, event.endTime).fold(
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
          (ride) => emit(Created(ride: ride)));
    }
  }

  void _onLoadAllRides(LoadAllRides event, Emitter emit) async {
    emit(Loading());

    final result = await getAllRidesUseCase(NoParams());

    result.fold(
        (failure) => emit(Error(message: _mapFailureToMessage(failure))),
        (allRides) => allRides.isEmpty
            ? emit(Empty())
            : emit(Loaded(allRides: allRides)));
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
