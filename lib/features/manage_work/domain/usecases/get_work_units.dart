import 'package:taxi_rahmati/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:taxi_rahmati/core/usecases/usecase.dart';
import 'package:taxi_rahmati/features/manage_work/domain/repositories/work_unit_repository.dart';

import '../entities/work_unit.dart';

class GetWorkUnits extends UseCase<List<WorkUnit>, NoParams> {
  final WorkUnitRepository workUnitRepository;

  GetWorkUnits({required this.workUnitRepository});

  @override
  Future<Either<Failure, List<WorkUnit>>> call(params) async {
    return await workUnitRepository.getWorkUnits();
  }
}
