import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taxi_rahmati/features/manage_work/data/models/ride_model.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/ride.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final rideModel = RideModel(
      id: '65b6b990-e1d3-11ec-aaf1-8738c050a64f',
      name: 'tName',
      title: Title.herr,
      destination: 'tDestination',
      start: DateTime.parse('2022-06-11 13:37:27.000Z'),
      end: DateTime.parse('2022-06-11 14:37:27.000Z'),
      price: Decimal.parse('24.3'));

  test('should be a subclass of Ride entity', () async {
    expect(rideModel, isA<Ride>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('ride.json'));

      final result = RideModel.fromJson(jsonMap);

      expect(result, rideModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      final result = rideModel.toJson();

      final expectedMap = {
        "id": "65b6b990-e1d3-11ec-aaf1-8738c050a64f",
        "name": "tName",
        "title": "herr",
        "destination": "tDestination",
        "start": "2022-06-11 13:37:27.000Z",
        "end": "2022-06-11 14:37:27.000Z",
        "price": "24.3"
      };
      expect(result, expectedMap);
    });
  });
}
