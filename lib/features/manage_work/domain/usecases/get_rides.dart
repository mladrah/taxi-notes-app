import 'package:taxi_rahmati/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:taxi_rahmati/core/usecases/usecase.dart';
import 'package:taxi_rahmati/features/manage_work/domain/repositories/ride_repository.dart';

import '../entities/ride.dart';

class GetRides extends UseCase<List<Ride>, NoParams> {
  final RideRepository rideRepository;

  GetRides({required this.rideRepository});

  @override
  Future<Either<Failure, List<Ride>>> call(NoParams params) async {
    return await rideRepository.getRides();
  }
}
