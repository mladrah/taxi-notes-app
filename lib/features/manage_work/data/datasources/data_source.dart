import 'package:taxi_rahmati/features/manage_work/data/models/ride_model.dart';

abstract class DataSource {
  Future<RideModel> addRide(RideModel rideModel);
  Future<RideModel> deleteRide(RideModel rideModel);
  Future<RideModel> updateRide(RideModel rideModel);
  Future<List<RideModel>> getRides();
}
