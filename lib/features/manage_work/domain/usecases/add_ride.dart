import 'package:dartz/dartz.dart';
import 'package:taxi_rahmati/core/usecases/usecase.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/ride.dart';

import '../../../../core/error/failures.dart';
import '../repositories/ride_repository.dart';
import 'shared/params_ride.dart';

class AddRide implements UseCase<Ride, Params> {
  final RideRepository rideRepository;

  AddRide({required this.rideRepository});

  @override
  Future<Either<Failure, Ride>> call(Params params) async {
    return await rideRepository.addRide(params.ride);
  }
}
