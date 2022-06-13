import 'package:taxi_rahmati/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:taxi_rahmati/core/usecases/usecase.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/work_unit.dart';
import 'package:taxi_rahmati/features/manage_work/domain/repositories/work_unit_repository.dart';

class CreateWorkUnit extends UseCase<WorkUnit, NoParams> {
  final WorkUnitRepository workUnitRepository;

  CreateWorkUnit({required this.workUnitRepository});

  @override
  Future<Either<Failure, WorkUnit>> call(NoParams params) async {
    return await workUnitRepository.createWorkUnit();
  }
}
