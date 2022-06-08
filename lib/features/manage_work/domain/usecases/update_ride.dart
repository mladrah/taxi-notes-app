import 'package:taxi_rahmati/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:taxi_rahmati/core/usecases/usecase.dart';
import 'package:taxi_rahmati/features/manage_work/domain/repositories/ride_repository.dart';

import '../entities/ride.dart';
import 'shared/params_ride.dart';

class UpdateRide implements UseCase<Ride, Params> {
  final RideRepository rideRepository;

  UpdateRide({required this.rideRepository});

  @override
  Future<Either<Failure, Ride>> call(params) async {
    return await rideRepository.updateRide(params.ride);
  }
}
