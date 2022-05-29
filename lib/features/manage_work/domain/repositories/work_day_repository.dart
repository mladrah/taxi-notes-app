import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/ride.dart';

abstract class WorkdayRepository {
  Future<Either<Failure, List<Ride>>> getAllRides();
}
