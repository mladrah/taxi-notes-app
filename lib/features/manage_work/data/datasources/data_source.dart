import 'package:taxi_rahmati/features/manage_work/data/models/ride_model.dart';

import '../../domain/entities/ride.dart';

abstract class DataSource {
  Future<List<RideModel>> getAllRides();
  Future<RideModel> addRide(RideModel rideModel);
}
