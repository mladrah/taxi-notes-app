import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/ride.dart';
import '../entities/work_unit.dart';

abstract class WorkUnitRepository {
  Future<Either<Failure, WorkUnit>> createWorkUnit();
  Future<Either<Failure, void>> deleteWorkUnit({required WorkUnit workUnit});
  Future<Either<Failure, List<WorkUnit>>> getWorkUnits();
  Future<Either<Failure, WorkUnit>> addRide(
      {required WorkUnit workUnit, required Ride ride});
  Future<Either<Failure, WorkUnit>> deleteRide(
      {required WorkUnit workUnit, required Ride ride});
  Future<Either<Failure, WorkUnit>> updateRide(
      {required WorkUnit workUnit, required Ride ride});
}
