import 'package:taxi_rahmati/features/manage_work/data/datasources/data_source.dart';

import '../models/ride_model.dart';

abstract class RideRemoteDataSource extends DataSource {}

class RideRemoteDataSourceImpl extends RideRemoteDataSource {
  @override
  Future<RideModel> addRide(RideModel rideModel) {
    throw UnimplementedError();
  }

  @override
  Future<List<RideModel>> getRides() {
    throw UnimplementedError();
  }

  @override
  Future<RideModel> deleteRide(RideModel rideModel) {
    throw UnimplementedError();
  }

  @override
  Future<RideModel> updateRide(RideModel rideModel) {
    throw UnimplementedError();
  }
}
