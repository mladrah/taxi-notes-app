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
    if (await networkInfo.isConnected) {
      try {
        return Right(await rideRemoteDataSource.addRide(ride as RideModel));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Ride>>> getAllRides() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await rideRemoteDataSource.getAllRides());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        return Right(await rideLocalDataSource.getAllRides());
      } on LocalException {
        return Left(LocalFailure());
      }
    }
  }
}
