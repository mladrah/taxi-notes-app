import 'package:taxi_rahmati/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/work_unit.dart';
import '../repositories/work_unit_repository.dart';
import 'shared/params_ride.dart';

class DeleteRide implements UseCase<WorkUnit, WorkUnitRidesParams> {
  final WorkUnitRepository workUnitRepository;

  DeleteRide({required this.workUnitRepository});

  @override
  Future<Either<Failure, WorkUnit>> call(WorkUnitRidesParams params) async {
    return await workUnitRepository.deleteRide(
        workUnit: params.workUnit, ride: params.ride);
  }
}
