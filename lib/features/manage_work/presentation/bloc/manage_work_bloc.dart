// ignore_for_file: constant_identifier_names
// ignore: unused_import
import 'dart:async';
// ignore: unused_import
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_rahmati/core/usecases/usecase.dart';
import 'package:taxi_rahmati/core/util/input_converter.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/work_unit.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/create_work_unit.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/delete_work_unit.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/ride.dart';
import '../../domain/usecases/get_work_units.dart';
import '../../domain/usecases/shared/params_ride.dart';
import '../../domain/usecases/update_ride.dart';
import '../../domain/usecases/delete_ride.dart';
import '../../domain/usecases/add_ride.dart';

part 'manage_work_event.dart';
part 'manage_work_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String LOCAL_FAILURE_MESSAGE = 'Local Failure';
const String INVALID_INPUT_DATE_MESSAGE = 'Invalid Date Input';
const String INVALID_INPUT_PRICE_MESSAGE = 'Invalid Price Input';

class ManageWorkBloc extends Bloc<ManageWorkEvent, ManageWorkState> {
  final CreateWorkUnit createWorkUnitUseCase;
  final DeleteWorkUnit deleteWorkUnitUseCase;
  final GetWorkUnits getWorkUnitsUseCase;
  final AddRide addRideUseCase;
  final DeleteRide deleteRideUseCase;
  final UpdateRide updateRideUseCase;
  final InputConverter inputConverter;

  ManageWorkBloc({
    required this.createWorkUnitUseCase,
    required this.deleteWorkUnitUseCase,
    required this.getWorkUnitsUseCase,
    required this.addRideUseCase,
    required this.deleteRideUseCase,
    required this.updateRideUseCase,
    required this.inputConverter,
  }) : super(Initial()) {
    on<LoadWorkUnitsFromRepository>(_onLoadWorkUnitsFromRepository);
    on<AddRideInWorkUnit>(_onAddRideToRepository);
    on<DeleteRideFromRepository>(_onDeleteRideFromRepository);
    on<UpdateRideInRepository>(_onUpdateRideInRepository);
    on<DeleteWorkUnitFromRepository>(_onDeleteWorkUnitFromRepository);
  }

  void _onAddRideToRepository(AddRideInWorkUnit event, Emitter emit) async {
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
      return;
    }

    emit(Loading());

    late final WorkUnit newWorkUnit;
    if (event.workUnit == null) {
      final createWorkUnitResult = await createWorkUnitUseCase(NoParams());
      createWorkUnitResult.fold(
          (failure) => emit(Error(message: _mapFailureToMessage(failure))),
          (workUnit) => newWorkUnit = workUnit);
    }

    final result = await addRideUseCase(
      WorkUnitRidesParams(
        workUnit: event.workUnit ?? newWorkUnit,
        ride: Ride(
            id: const Uuid().v1(),
            title: event.title,
            name: event.name,
            fromDestination: event.fromDestination,
            toDestination: event.toDestination,
            start: startParsed,
            end: endParsed,
            price: priceParsed),
      ),
    );

    result.fold(
      (failure) => emit(Error(message: _mapFailureToMessage(failure))),
      (workUnit) {
        _sortRidesOfWorkUnit(workUnit);
        emit(RideAdded(workUnit: workUnit));
      },
    );
  }

  void _onDeleteRideFromRepository(
      DeleteRideFromRepository event, Emitter<ManageWorkState> emit) async {
    emit(Loading());

    final result = await deleteRideUseCase(
        WorkUnitRidesParams(workUnit: event.workUnit, ride: event.ride));

    late final WorkUnit workUnitResult;
    result
        .fold((failure) => emit(Error(message: _mapFailureToMessage(failure))),
            (workUnit) {
      workUnitResult = workUnit;
    });

    if (workUnitResult.rides.isEmpty) {
      final deleteResult =
          await deleteWorkUnitUseCase(Params(workUnit: workUnitResult));

      deleteResult.fold(
          (failure) => emit(Error(message: _mapFailureToMessage(failure))),
          (r) => emit(WorkUnitDeleted()));
    } else {
      _sortRidesOfWorkUnit(workUnitResult);
      emit(RideDeleted(workUnit: workUnitResult));
    }
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
          fromDestination: event.fromDestination,
          toDestination: event.toDestination,
          start: startParsed,
          end: endParsed,
          price: priceParsed);

      final result = await updateRideUseCase(
        WorkUnitRidesParams(workUnit: event.workUnit, ride: newRide),
      );

      result.fold(
        (failure) => emit(Error(message: _mapFailureToMessage(failure))),
        (workUnit) {
          _sortRidesOfWorkUnit(workUnit);
          emit(RideUpdated(workUnit: workUnit));
        },
      );
    }
  }

  void _onLoadWorkUnitsFromRepository(
      LoadWorkUnitsFromRepository event, Emitter<ManageWorkState> emit) async {
    emit(Loading());

    final result = await getWorkUnitsUseCase(NoParams());

    result
        .fold((failure) => emit(Error(message: _mapFailureToMessage(failure))),
            (workUnits) {
      _sortWorkUnits(workUnits);
      emit(WorkUnitsLoaded(workUnits: workUnits));
    });
  }

  void _onDeleteWorkUnitFromRepository(
      DeleteWorkUnitFromRepository event, Emitter<ManageWorkState> emit) async {
    emit(Loading());

    final deleteResult =
        await deleteWorkUnitUseCase(Params(workUnit: event.workUnit));

    deleteResult.fold(
        (failure) => emit(Error(message: _mapFailureToMessage(failure))),
        (r) => emit(WorkUnitDeleted()));
  }

  void _sortWorkUnits(List<WorkUnit> workUnits) {
    for (WorkUnit wu in workUnits) {
      _sortRidesOfWorkUnit(wu);
    }

    workUnits.sort((a, b) => a.rides[0].start.compareTo(b.rides[0].start));
  }

  void _sortRidesOfWorkUnit(WorkUnit workUnit) {
    workUnit.rides.sort((a, b) => a.start.compareTo(b.start));
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
