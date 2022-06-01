import 'package:taxi_rahmati/core/platform/network_info.dart';
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
  Future<Either<Failure, Ride>> addRide(Ride ride) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Ride>>> getAllRides() {
    throw UnimplementedError();
  }
}
