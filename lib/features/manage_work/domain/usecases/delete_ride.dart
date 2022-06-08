import 'package:taxi_rahmati/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/ride.dart';
import '../repositories/ride_repository.dart';
import 'shared/params_ride.dart';

class DeleteRide implements UseCase<Ride, Params> {
  final RideRepository rideRepository;

  DeleteRide({required this.rideRepository});

  @override
  Future<Either<Failure, Ride>> call(Params params) async {
    return await rideRepository.deleteRide(params.ride);
  }
}
