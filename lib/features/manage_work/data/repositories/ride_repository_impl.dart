import 'package:taxi_rahmati/core/error/exceptions.dart';
import 'package:taxi_rahmati/core/network/network_info.dart';
import 'package:taxi_rahmati/features/manage_work/data/models/ride_model.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/ride.dart';
import 'package:taxi_rahmati/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:taxi_rahmati/features/manage_work/domain/repositories/ride_repository.dart';

import '../datasources/ride_local_data_source.dart';
import '../datasources/ride_remote_date_source.dart';

class RideRepositoryImpl extends RideRepository {
  final RideLocalDataSource rideLocalDataSource;
  final RideRemoteDataSource rideRemoteDataSource;
  final NetworkInfo networkInfo;

  RideRepositoryImpl(
      {required this.rideLocalDataSource,
      required this.rideRemoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, Ride>> addRide(Ride ride) async {
    await networkInfo.isConnected;
    try {
      rideLocalDataSource.initialize();
      return Right(await rideLocalDataSource.addRide(_rideToRideModel(ride)));
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, Ride>> deleteRide(Ride ride) async {
    await networkInfo.isConnected;
    try {
      return Right(
          await rideLocalDataSource.deleteRide(_rideToRideModel(ride)));
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, Ride>> updateRide(Ride ride) async {
    await networkInfo.isConnected;
    try {
      return Right(
          await rideLocalDataSource.updateRide(_rideToRideModel(ride)));
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, List<Ride>>> getRides() async {
    await networkInfo.isConnected;
    try {
      rideLocalDataSource.initialize();
      return Right(await rideLocalDataSource.getRides());
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  RideModel _rideToRideModel(Ride ride) {
    return RideModel(
      id: ride.id,
      name: ride.name,
      title: ride.title,
      destination: ride.destination,
      start: ride.start,
      end: ride.end,
      price: ride.price,
    );
  }
}
