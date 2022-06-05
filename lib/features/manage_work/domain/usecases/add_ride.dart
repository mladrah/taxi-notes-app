import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_rahmati/core/usecases/usecase.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/ride.dart';

import '../../../../core/error/failures.dart';
import '../repositories/ride_repository.dart';

class AddRide implements UseCase<Ride, Params> {
  final RideRepository rideRepository;

  AddRide({required this.rideRepository});

  @override
  Future<Either<Failure, Ride>> call(Params params) async {
    return await rideRepository.addRide(params.ride);
  }
}

class Params extends Equatable {
  final Ride ride;

  const Params({required this.ride});

  @override
  List<Object> get props => [ride];
}
