import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_rahmati/core/usecases/usecase.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/ride.dart';

import '../../../../core/error/failures.dart';
import '../repositories/work_day_repository.dart';

class AddRide implements UseCase<Ride, Params> {
  final WorkDayRepository workDayRepository;

  AddRide({required this.workDayRepository});

  @override
  Future<Either<Failure, Ride>> call(Params params) async {
    return await workDayRepository.addRide(params.ride);
  }
}

class Params extends Equatable {
  final Ride ride;

  const Params({required this.ride});

  @override
  List<Object> get props => [ride];
}
