// ignore_for_file: constant_identifier_names

import 'dart:convert';
// ignore: unused_import
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_rahmati/core/error/exceptions.dart';
import 'package:taxi_rahmati/features/manage_work/data/datasources/data_source.dart';
import 'package:taxi_rahmati/features/manage_work/data/models/ride_model.dart';
import 'package:taxi_rahmati/features/manage_work/data/models/work_unit_model.dart';
import 'package:uuid/uuid.dart';

const String WORK_UNITS = 'WORK_UNITS';
const String INITIALIZED = 'INITIALIZED';

abstract class WorkUnitLocalDataSource extends DataSource {
  Future<void> initialize();
  Future<void> saveWorkUnits(List<WorkUnitModel> workUnitModels);
}

class WorkUnitLocalDataSourceImpl extends WorkUnitLocalDataSource {
  final SharedPreferences sharedPreferences;

  WorkUnitLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> initialize() async {
    final isInitialized = sharedPreferences.getString(INITIALIZED);

    if (isInitialized == null) {
      sharedPreferences.setString(
          WORK_UNITS, _getJsonStringFromWorkUnits(<WorkUnitModel>[]));

      sharedPreferences.setString(INITIALIZED, 'initialized');
    }
  }

  @override
  Future<WorkUnitModel> createWorkUnit() async {
    final WorkUnitModel workUnitModel =
        WorkUnitModel(id: const Uuid().v1(), rideModels: const <RideModel>[]);

    final List<WorkUnitModel> workUnitModels = await getWorkUnits();
    workUnitModels.add(workUnitModel);

    await saveWorkUnits(workUnitModels);

    return workUnitModel;
  }

  @override
  Future<void> deleteWorkUnit({required WorkUnitModel workUnitModel}) async {
    final List<WorkUnitModel> workUnitModels = await getWorkUnits();

    workUnitModels
        .removeWhere((element) => element.id.compareTo(workUnitModel.id) == 0);

    await saveWorkUnits(workUnitModels);
  }

  @override
  Future<List<WorkUnitModel>> getWorkUnits() async {
    String? jsonString = sharedPreferences.getString(WORK_UNITS);

    if (jsonString == null) throw LocalException();

    Iterable l = json.decode(jsonString);
    List<WorkUnitModel> workUnitModels = List<WorkUnitModel>.from(
      l.map(
        (workUnitModel) => WorkUnitModel.fromJson(workUnitModel),
      ),
    );

    return Future.value(workUnitModels);
  }

  @override
  Future<void> saveWorkUnits(List<WorkUnitModel> workUnitModels) async {
    final String jsonString = jsonEncode(
        workUnitModels.map((workUnitModel) => workUnitModel.toJson()).toList());

    sharedPreferences.setString(WORK_UNITS, jsonString);
  }

  @override
  Future<WorkUnitModel> addRide(
      {required WorkUnitModel workUnitModel,
      required RideModel rideModel}) async {
    List<WorkUnitModel> workUnitModels = await getWorkUnits();

    for (WorkUnitModel wum in workUnitModels) {
      if (wum.id.compareTo(workUnitModel.id) == 0) {
        wum.rideModels.add(rideModel);
        workUnitModel = wum;
        break;
      }
    }

    await saveWorkUnits(workUnitModels);

    return workUnitModel;
  }

  @override
  Future<WorkUnitModel> deleteRide(
      {required WorkUnitModel workUnitModel,
      required RideModel rideModel}) async {
    final List<WorkUnitModel> workUnitModels = await getWorkUnits();

    for (WorkUnitModel wum in workUnitModels) {
      if (wum.id.compareTo(workUnitModel.id) == 0) {
        wum.rideModels
            .removeWhere((element) => element.id.compareTo(rideModel.id) == 0);
        workUnitModel = wum;
        break;
      }
    }

    await saveWorkUnits(workUnitModels);

    return workUnitModel;
  }

  @override
  Future<WorkUnitModel> updateRide(
      {required WorkUnitModel workUnitModel,
      required RideModel rideModel}) async {
    final List<WorkUnitModel> workUnitModels = await getWorkUnits();

    for (WorkUnitModel wum in workUnitModels) {
      if (wum.id.compareTo(workUnitModel.id) == 0) {
        wum.rideModels[wum.rideModels.indexWhere(
            (element) => element.id.compareTo(rideModel.id) == 0)] = rideModel;
        workUnitModel = wum;
        break;
      }
    }

    await saveWorkUnits(workUnitModels);

    return workUnitModel;
  }

  String _getJsonStringFromWorkUnits(List<WorkUnitModel> workUnits) {
    return jsonEncode(workUnits.map((workUnit) => workUnit.toJson()).toList());
  }
}
