import 'package:dartz/dartz.dart';
import 'package:taxi_rahmati/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/work_unit.dart';
import '../repositories/work_unit_repository.dart';
import 'shared/params_ride.dart';

class AddRide implements UseCase<WorkUnit, WorkUnitRidesParams> {
  final WorkUnitRepository workUnitRepository;

  AddRide({required this.workUnitRepository});

  @override
  Future<Either<Failure, WorkUnit>> call(WorkUnitRidesParams params) async {
    return await workUnitRepository.addRide(
        workUnit: params.workUnit, ride: params.ride);
  }
}
