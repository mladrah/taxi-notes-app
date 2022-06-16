import 'package:taxi_rahmati/core/error/exceptions.dart';
import 'package:taxi_rahmati/core/network/network_info.dart';
import 'package:taxi_rahmati/features/manage_work/data/models/ride_model.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/ride.dart';
import 'package:taxi_rahmati/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/work_unit.dart';
import 'package:taxi_rahmati/features/manage_work/domain/repositories/work_unit_repository.dart';

import '../datasources/work_unit_local_data_source.dart';
import '../datasources/work_unit_remote_data_source.dart';
import '../models/work_unit_model.dart';

class WorkUnitRepositoryImpl extends WorkUnitRepository {
  final WorkUnitLocalDataSource rideLocalDataSource;
  final WorkUnitRemoteDataSource rideRemoteDataSource;
  final NetworkInfo networkInfo;

  WorkUnitRepositoryImpl(
      {required this.rideLocalDataSource,
      required this.rideRemoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, WorkUnit>> createWorkUnit() async {
    try {
      return Right(await rideLocalDataSource.createWorkUnit());
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteWorkUnit(
      {required WorkUnit workUnit}) async {
    try {
      return Right(await rideLocalDataSource.deleteWorkUnit(
          workUnitModel: _workToWorkUnitModel(workUnit)));
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, List<WorkUnit>>> getWorkUnits() async {
    try {
      rideLocalDataSource.initialize();
      return Right(await rideLocalDataSource.getWorkUnits());
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, WorkUnit>> addRide(
      {required WorkUnit workUnit, required Ride ride}) async {
    await networkInfo.isConnected;
    try {
      rideLocalDataSource.initialize();
      return Right(await rideLocalDataSource.addRide(
          workUnitModel: _workToWorkUnitModel(workUnit),
          rideModel: _rideToRideModel(ride)));
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, WorkUnit>> deleteRide(
      {required WorkUnit workUnit, required Ride ride}) async {
    await networkInfo.isConnected;
    try {
      return Right(await rideLocalDataSource.deleteRide(
          workUnitModel: _workToWorkUnitModel(workUnit),
          rideModel: _rideToRideModel(ride)));
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, WorkUnit>> updateRide(
      {required WorkUnit workUnit, required Ride ride}) async {
    await networkInfo.isConnected;
    try {
      return Right(await rideLocalDataSource.updateRide(
          workUnitModel: _workToWorkUnitModel(workUnit),
          rideModel: _rideToRideModel(ride)));
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  RideModel _rideToRideModel(Ride ride) {
    return RideModel(
      id: ride.id,
      name: ride.name,
      title: ride.title,
      fromDestination: ride.fromDestination,
      toDestination: ride.toDestination,
      start: ride.start,
      end: ride.end,
      price: ride.price,
    );
  }

  WorkUnitModel _workToWorkUnitModel(WorkUnit workUnit) {
    List<RideModel> rideModels = [];
    for (Ride r in workUnit.rides) {
      rideModels.add(_rideToRideModel(r));
    }

    return WorkUnitModel(id: workUnit.id, rideModels: rideModels);
  }
}
