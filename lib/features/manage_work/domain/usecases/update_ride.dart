import 'package:taxi_rahmati/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:taxi_rahmati/core/usecases/usecase.dart';
import 'package:taxi_rahmati/features/manage_work/domain/repositories/work_unit_repository.dart';

import '../entities/work_unit.dart';
import 'shared/params_ride.dart';

class UpdateRide implements UseCase<WorkUnit, WorkUnitRidesParams> {
  final WorkUnitRepository workUnitRepository;

  UpdateRide({required this.workUnitRepository});

  @override
  Future<Either<Failure, WorkUnit>> call(params) async {
    return await workUnitRepository.updateRide(
        workUnit: params.workUnit, ride: params.ride);
  }
}
