import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/ride.dart';

abstract class RideRepository {
  Future<Either<Failure, Ride>> addRide(Ride ride);
  Future<Either<Failure, Ride>> deleteRide(Ride ride);
  Future<Either<Failure, Ride>> updateRide(Ride ride);
  Future<Either<Failure, List<Ride>>> getRides();
}
