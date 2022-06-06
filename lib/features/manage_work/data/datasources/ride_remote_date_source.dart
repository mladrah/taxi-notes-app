import 'package:taxi_rahmati/features/manage_work/data/datasources/data_source.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/ride.dart';

import '../models/ride_model.dart';

abstract class RideRemoteDataSource extends DataSource {}

class RideRemoteDataSourceImpl extends RideRemoteDataSource {
  @override
  Future<RideModel> addRide(RideModel rideModel) {
    // TODO: implement addRide
    throw UnimplementedError();
  }

  @override
  Future<List<RideModel>> getAllRides() {
    // TODO: implement getAllRides
    throw UnimplementedError();
  }
}
