import 'package:dartz/dartz.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:taxi_rahmati/core/error/exceptions.dart';
import 'package:taxi_rahmati/core/error/failures.dart';
import 'package:taxi_rahmati/core/network/network_info.dart';
import 'package:taxi_rahmati/features/manage_work/data/datasources/ride_local_data_source.dart';
import 'package:taxi_rahmati/features/manage_work/data/datasources/ride_remote_date_source.dart';
import 'package:taxi_rahmati/features/manage_work/data/models/ride_model.dart';
import 'package:taxi_rahmati/features/manage_work/data/repositories/ride_repository_impl.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/ride.dart';
import 'package:uuid/uuid.dart';

import 'ride_repository_impl_test.mocks.dart';

@GenerateMocks([RideLocalDataSource, RideRemoteDataSource, NetworkInfo])
void main() {
  late RideRepositoryImpl rideRepositoryImpl;

  late MockRideLocalDataSource mockRideLocalDataSource;
  late MockRideRemoteDataSource mockRideRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRideLocalDataSource = MockRideLocalDataSource();
    mockRideRemoteDataSource = MockRideRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    rideRepositoryImpl = RideRepositoryImpl(
        rideLocalDataSource: mockRideLocalDataSource,
        rideRemoteDataSource: mockRideRemoteDataSource,
        networkInfo: mockNetworkInfo);
  });

  group('getRides', () {
    final ride = RideModel(
        id: const Uuid().v1(),
        name: 'tName',
        title: Title.herr,
        destination: 'tDestination',
        start: DateTime.parse('2022-06-11 13:37:27.000Z'),
        end: DateTime.parse('2022-06-11 14:37:27.000Z'),
        price: Decimal.parse('28.3'));

    List<RideModel> allRides = [ride];

    test('should check if the device is online', () {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRideRemoteDataSource.getRides())
          .thenAnswer((_) async => allRides);
      when(mockRideLocalDataSource.getRides())
          .thenAnswer((_) async => allRides);

      // act
      rideRepositoryImpl.getRides();

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    // group('device is online', () {
    //   setUp(() {
    //     when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    //   });

    //   test(
    //       'should return remote data when the call to remote data source is successful',
    //       () async {
    //     when(mockRideRemoteDataSource.getAllRides())
    //         .thenAnswer((_) async => allRides);

    //     final result = await rideRepositoryImpl.getAllRides();

    //     expect(result, Right(allRides));
    //   });

    //   test(
    //       'should return server failure when the call to remote data source is unsuccessful',
    //       () async {
    //     when(mockRideRemoteDataSource.getAllRides())
    //         .thenThrow(ServerException());

    //     final result = await rideRepositoryImpl.getAllRides();

    //     expect(result, Left(ServerFailure()));
    //   });
    // });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should return local data when the call to local data source is successful',
          () async {
        when(mockRideLocalDataSource.getRides())
            .thenAnswer((_) async => allRides);

        final result = await rideRepositoryImpl.getRides();

        verifyZeroInteractions(mockRideRemoteDataSource);
        expect(result, Right(allRides));
      });

      test(
          'should return local failure when the call to local data source is unsuccessful',
          () async {
        when(mockRideLocalDataSource.getRides()).thenThrow(LocalException());

        final result = await rideRepositoryImpl.getRides();

        verifyZeroInteractions(mockRideRemoteDataSource);
        expect(result, Left(LocalFailure()));
      });
    });
  });

  group('addRide', () {
    final rideModel = RideModel(
        id: '79b6b990-e1d3-11ec-aaf1-8738c050a64f',
        name: 'tName',
        title: Title.herr,
        destination: 'tDestination',
        start: DateTime.parse('2022-06-11 13:37:27.000Z'),
        end: DateTime.parse('2022-06-11 14:37:27.000Z'),
        price: Decimal.parse('28.3'));

    final ride = rideModel;

    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRideRemoteDataSource.addRide(any)).thenAnswer((_) async => ride);
      when(mockRideLocalDataSource.addRide(any)).thenAnswer((_) async => ride);

      // act
      await rideRepositoryImpl.addRide(ride);

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    // group('device is online', () {
    //   setUp(() {
    //     when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    //   });

    // test(
    //     'should add RideModel to remote data when the call to remote data source is succesful',
    //     () async {
    //   when(mockRideRemoteDataSource.addRide(ride))
    //       .thenAnswer((_) async => ride);

    //   final result = await rideRepositoryImpl.addRide(ride);

    //   verify(mockRideRemoteDataSource.addRide(ride));
    //   expect(result, Right(ride));
    // });

    // test(
    //     'should return server failure when adding RideModel to remote data source is unsuccessful',
    //     () async {
    //   when(mockRideRemoteDataSource.addRide(ride))
    //       .thenThrow(ServerException());

    //   final result = await rideRepositoryImpl.addRide(ride);

    //   verify(mockRideRemoteDataSource.addRide(ride));
    //   expect(result, Left(ServerFailure()));
    // });
    // });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should add ride when the call to local data source is successful',
          () async {
        when(mockRideLocalDataSource.addRide(any))
            .thenAnswer((_) async => ride);

        final result = await rideRepositoryImpl.addRide(ride);

        verifyZeroInteractions(mockRideRemoteDataSource);
        expect(result, Right(ride));
      });

      test(
          'should return local failure when the call to local data source is unsuccessful',
          () async {
        when(mockRideLocalDataSource.addRide(any)).thenThrow(LocalException());

        final result = await rideRepositoryImpl.addRide(ride);

        verifyZeroInteractions(mockRideRemoteDataSource);
        expect(result, Left(LocalFailure()));
      });
    });
  });

  group('deleteRide', () {
    final rideModel = RideModel(
        id: '79b6b990-e1d3-11ec-aaf1-8738c050a64f',
        name: 'tName',
        title: Title.herr,
        destination: 'tDestination',
        start: DateTime.parse('2022-06-11 13:37:27.000Z'),
        end: DateTime.parse('2022-06-11 14:37:27.000Z'),
        price: Decimal.parse('28.3'));

    final ride = rideModel;

    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRideRemoteDataSource.deleteRide(ride))
          .thenAnswer((_) async => ride);
      when(mockRideLocalDataSource.deleteRide(ride))
          .thenAnswer((_) async => ride);

      // act
      await rideRepositoryImpl.deleteRide(ride);

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    // group('device is online', () {
    //   setUp(() {
    //     when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    //   });

    // test(
    //     'should add RideModel to remote data when the call to remote data source is succesful',
    //     () async {
    //   when(mockRideRemoteDataSource.addRide(ride))
    //       .thenAnswer((_) async => ride);

    //   final result = await rideRepositoryImpl.addRide(ride);

    //   verify(mockRideRemoteDataSource.addRide(ride));
    //   expect(result, Right(ride));
    // });

    // test(
    //     'should return server failure when adding RideModel to remote data source is unsuccessful',
    //     () async {
    //   when(mockRideRemoteDataSource.addRide(ride))
    //       .thenThrow(ServerException());

    //   final result = await rideRepositoryImpl.addRide(ride);

    //   verify(mockRideRemoteDataSource.addRide(ride));
    //   expect(result, Left(ServerFailure()));
    // });
    // });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should return deleted ride when the call to local data source is successful',
          () async {
        when(mockRideLocalDataSource.deleteRide(any))
            .thenAnswer((_) async => ride);

        final result = await rideRepositoryImpl.deleteRide(ride);

        verifyZeroInteractions(mockRideRemoteDataSource);
        expect(result, Right(ride));
      });

      test(
          'should return local failure when the call to local data source is unsuccessful',
          () async {
        when(mockRideLocalDataSource.deleteRide(any))
            .thenThrow(LocalException());

        final result = await rideRepositoryImpl.deleteRide(ride);

        verifyZeroInteractions(mockRideRemoteDataSource);
        expect(result, Left(LocalFailure()));
      });
    });
  });
}
