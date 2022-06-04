import 'package:taxi_rahmati/features/manage_work/data/datasources/data_source.dart';

import '../models/ride_model.dart';

abstract class RideRemoteDataSource extends DataSource {
  Future<bool> addRide(RideModel rideModel);
}
