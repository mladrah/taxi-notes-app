import 'package:taxi_rahmati/features/manage_work/data/models/ride_model.dart';

abstract class DataSource {
  Future<List<RideModel>> getAllRides();
}
