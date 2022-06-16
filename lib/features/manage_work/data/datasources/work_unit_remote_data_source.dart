import 'package:taxi_rahmati/features/manage_work/data/datasources/data_source.dart';
import 'package:taxi_rahmati/features/manage_work/data/models/work_unit_model.dart';

import '../models/ride_model.dart';

abstract class WorkUnitRemoteDataSource extends DataSource {}

class WorkUnitRemoteDataSourceImpl extends WorkUnitRemoteDataSource {
  @override
  Future<WorkUnitModel> addRide(
      {required WorkUnitModel workUnitModel, required RideModel rideModel}) {
    throw UnimplementedError();
  }

  @override
  Future<WorkUnitModel> createWorkUnit() {
    throw UnimplementedError();
  }

  @override
  Future<WorkUnitModel> deleteRide(
      {required WorkUnitModel workUnitModel, required RideModel rideModel}) {
    throw UnimplementedError();
  }

  @override
  Future<List<WorkUnitModel>> getWorkUnits() {
    throw UnimplementedError();
  }

  @override
  Future<WorkUnitModel> updateRide(
      {required WorkUnitModel workUnitModel, required RideModel rideModel}) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteWorkUnit({required WorkUnitModel workUnitModel}) {
    throw UnimplementedError();
  }
}
