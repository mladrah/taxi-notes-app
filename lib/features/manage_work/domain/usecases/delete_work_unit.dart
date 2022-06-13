import 'package:equatable/equatable.dart';
import 'package:taxi_rahmati/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:taxi_rahmati/core/usecases/usecase.dart';

import '../entities/work_unit.dart';
import '../repositories/work_unit_repository.dart';

class DeleteWorkUnit extends UseCase<void, Params> {
  final WorkUnitRepository workUnitRepository;

  DeleteWorkUnit({required this.workUnitRepository});

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await workUnitRepository.deleteWorkUnit(workUnit: params.workUnit);
  }
}

class Params extends Equatable {
  final WorkUnit workUnit;

  const Params({required this.workUnit});

  @override
  List<Object> get props => [workUnit];
}
