import 'package:taxi_rahmati/features/manage_work/data/models/ride_model.dart';

abstract class DataSource {
  Future<bool> addRide(RideModel rideModel);
  Future<List<RideModel>> getAllRides();
  Future<bool> saveAllRides(List<RideModel> allRides);
}
