import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_rahmati/core/error/exceptions.dart';
import 'package:taxi_rahmati/features/manage_work/data/datasources/ride_local_data_source.dart';
import 'package:taxi_rahmati/features/manage_work/data/models/ride_model.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/ride.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'ride_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late RideLocalDataSourceImpl rideLocalDataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    rideLocalDataSourceImpl =
        RideLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });
  group('initialize', () {
    test(
        'should initialize empty list when shared preferences does not have a list',
        () async {
      when(mockSharedPreferences.getString(INITIALIZED)).thenReturn(null);
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      await rideLocalDataSourceImpl.initialize();

      verify(mockSharedPreferences.setString(ALL_RIDES, any));
      verify(mockSharedPreferences.setString(INITIALIZED, 'initialized'));
    });

    test(
        'should not initialize when shared preferences is already initialized and does contain a list',
        () async {
      when(mockSharedPreferences.getString(INITIALIZED))
          .thenReturn('initialized');

      await rideLocalDataSourceImpl.initialize();

      verifyNever(mockSharedPreferences.setString(ALL_RIDES, any));
      verifyNever(mockSharedPreferences.setString(INITIALIZED, 'initialized'));
    });
  });

  group('getAllRides', () {
    Iterable l = json.decode(fixture('all_rides.json'));
    List<RideModel> allRides = List<RideModel>.from(
        l.map((rideModel) => RideModel.fromJson(rideModel)));

    test(
        'should return all Rides from SharedPreferences when there is atleast one inside the local repisotory',
        () async {
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('all_rides.json'));

      final result = await rideLocalDataSourceImpl.getAllRides();

      verify(mockSharedPreferences.getString(ALL_RIDES));
      expect(result, allRides);
    });

    test(
        'should throw LocalException when there is no Rides inside the local repisotory',
        () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      final call = rideLocalDataSourceImpl.getAllRides;

      expect(() => call(), throwsA(isA<LocalException>()));
    });
  });

  group('saveAllRides', () {
    List<RideModel> allRides = [
      RideModel(
          id: '65b6b990-e1d3-11ec-aaf1-8738c050a64f',
          name: 'tName',
          title: Title.herr,
          destination: 'tDestination',
          start: DateTime.parse('2022-06-11 13:37:27.000Z'),
          end: DateTime.parse('2022-06-11 14:37:27.000Z'),
          price: Decimal.parse('24.3'))
    ];

    test('should call SharedPereferences to save list of Rides', () {
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      rideLocalDataSourceImpl.saveAllRides(allRides);

      final expectedJsonString =
          jsonEncode(allRides.map((e) => e.toJson()).toList());
      verify(mockSharedPreferences.setString(
        ALL_RIDES,
        expectedJsonString,
      ));
    });
  });
}
