// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_rahmati/core/error/exceptions.dart';
import 'package:taxi_rahmati/features/manage_work/data/datasources/data_source.dart';
import 'package:taxi_rahmati/features/manage_work/data/models/ride_model.dart';

const String ALL_RIDES = 'ALL_RIDES';
const String INITIALIZED = 'INITIALIZED';

abstract class RideLocalDataSource extends DataSource {
  Future<void> clear();
  Future<void> initialize();
  Future<bool> saveRides(List<RideModel> allRides);
}

class RideLocalDataSourceImpl extends RideLocalDataSource {
  final SharedPreferences sharedPreferences;

  RideLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<RideModel> addRide(RideModel rideModel) async {
    List<RideModel> allRides;
    allRides = await getRides();
    allRides.add(rideModel);
    saveRides(allRides);

    return rideModel;
  }

  @override
  Future<RideModel> deleteRide(RideModel rideModel) async {
    final List<RideModel> rideModels = await getRides();
    rideModels
        .removeWhere((element) => element.id.compareTo(rideModel.id) == 0);
    saveRides(rideModels);

    return rideModel;
  }

  @override
  Future<RideModel> updateRide(RideModel rideModel) async {
    final List<RideModel> rideModels = await getRides();

    rideModels[rideModels.indexWhere(
        (element) => element.id.compareTo(rideModel.id) == 0)] = rideModel;
    saveRides(rideModels);

    return rideModel;
  }

  @override
  Future<List<RideModel>> getRides() {
    String? jsonString = sharedPreferences.getString(ALL_RIDES);

    if (jsonString == null) throw LocalException();

    Iterable l = json.decode(jsonString);
    List<RideModel> allRides = List<RideModel>.from(
        l.map((rideModel) => RideModel.fromJson(rideModel)));

    return Future.value(allRides);
  }

  @override
  Future<void> initialize() async {
    final isInitialized = sharedPreferences.getString(INITIALIZED);

    if (isInitialized == null) {
      sharedPreferences.setString(
          ALL_RIDES, _getJsonStringFromRideList(<RideModel>[]));

      sharedPreferences.setString(INITIALIZED, 'initialized');
    }
  }

  @override
  Future<void> clear() async {
    sharedPreferences.setString(
        ALL_RIDES, _getJsonStringFromRideList(<RideModel>[]));
  }

  @override
  Future<bool> saveRides(List<RideModel> allRides) {
    return sharedPreferences.setString(
        ALL_RIDES, _getJsonStringFromRideList(allRides));
  }

  String _getJsonStringFromRideList(List<RideModel> allRides) {
    return jsonEncode(allRides.map((e) => e.toJson()).toList());
  }
}
