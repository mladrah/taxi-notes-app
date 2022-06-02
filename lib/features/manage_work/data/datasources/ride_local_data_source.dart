import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_rahmati/core/error/exceptions.dart';
import 'package:taxi_rahmati/features/manage_work/data/datasources/data_source.dart';
import 'package:taxi_rahmati/features/manage_work/data/models/ride_model.dart';

const String ALL_RIDES = 'ALL_RIDES';

abstract class RideLocalDataSource extends DataSource {}

class RideLocalDataSourceImpl extends RideLocalDataSource {
  final SharedPreferences sharedPreferences;

  RideLocalDataSourceImpl({required this.sharedPreferences});

  // überhaupt hier notwendig? vlt nur als use case
  @override
  Future<bool> addRide(RideModel rideModel) async {
    List<RideModel> allRides;
    try {
      allRides = await getAllRides();
      allRides.add(rideModel);
    } on LocalException {
      allRides = [rideModel];
    }
    return sharedPreferences.setString(
        ALL_RIDES, jsonEncode(allRides.map((e) => e.toJson()).toList()));
  }

  @override
  Future<List<RideModel>> getAllRides() {
    final jsonString = sharedPreferences.getString(ALL_RIDES);

    if (jsonString == null) throw LocalException();

    Iterable l = json.decode(jsonString)['rides'];
    List<RideModel> allRides = List<RideModel>.from(
        l.map((rideModel) => RideModel.fromJson(rideModel)));

    return Future.value(allRides);
  }

  @override
  Future<bool> saveAllRides(List<RideModel> allRides) {
    return sharedPreferences.setString(
        ALL_RIDES, jsonEncode(allRides.map((e) => e.toJson()).toList()));
  }
}
