import 'package:taxi_rahmati/features/manage_work/data/models/ride_model.dart';

import '../models/work_unit_model.dart';

abstract class DataSource {
  Future<WorkUnitModel> createWorkUnit();
  Future<List<WorkUnitModel>> getWorkUnits();
  Future<void> deleteWorkUnit({required WorkUnitModel workUnitModel});
  Future<WorkUnitModel> addRide(
      {required WorkUnitModel workUnitModel, required RideModel rideModel});
  Future<WorkUnitModel> deleteRide(
      {required WorkUnitModel workUnitModel, required RideModel rideModel});
  Future<WorkUnitModel> updateRide(
      {required WorkUnitModel workUnitModel, required RideModel rideModel});
}
