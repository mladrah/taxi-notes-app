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

  void _onAddRideToList(AddRideToList event, Emitter emit) async {
    bool isFailed = false;
    late final Title titleParsed;
    late final DateTime startParsed;
    late final DateTime endParsed;
    late final Decimal priceParsed;

    inputConverter
        .stringToTitleEnum(event.title)
        .fold((failure) => isFailed = true, (title) => titleParsed = title);
    inputConverter
        .stringToDateTime(event.start)
        .fold((failure) => isFailed = true, (start) => startParsed = start);
    inputConverter
        .stringToDateTime(event.end)
        .fold((failure) => isFailed = true, (end) => endParsed = end);
    inputConverter
        .stringToDecimal(event.price)
        .fold((failure) => isFailed = true, (price) => priceParsed = price);

    if (isFailed) {
      emit(const Error(message: INVALID_INPUT_MESSAGE));
    } else {
      emit(Loading());

      final result = await addRideUseCase(Params(
          ride: Ride(
              id: const Uuid().v1(),
              name: event.name,
              title: titleParsed,
              destination: event.destination,
              start: startParsed,
              end: endParsed,
              price: priceParsed)));

      result.fold(
          (failure) => emit(Error(message: _mapFailureToMessage(failure))),
          (ride) => emit(Created(ride: ride)));
    }
  }

  void _onListAllRides(ListAllRides event, Emitter emit) async {
    emit(Loading());
    final result = await getAllRidesUseCase(NoParams());
    result.fold(
        (failure) => emit(Error(message: _mapFailureToMessage(failure))),
        (allRides) => emit(Loaded(allRides: allRides)));
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
