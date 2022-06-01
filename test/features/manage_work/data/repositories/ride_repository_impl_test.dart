import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:taxi_rahmati/core/platform/network_info.dart';
import 'package:taxi_rahmati/features/manage_work/data/datasources/ride_local_data_source.dart';
import 'package:taxi_rahmati/features/manage_work/data/datasources/ride_remote_date_source.dart';
import 'package:taxi_rahmati/features/manage_work/data/repositories/ride_repository_impl.dart';

import 'ride_repository_impl_test.mocks.dart';

@GenerateMocks([RideLocalDataSource, RideRemoteDataSource, NetworkInfo])
void main() {
  RideRepositoryImpl rideRepositoryImpl;

  MockRideLocalDataSource mockRideLocalDataSource;
  MockRideRemoteDataSource mockRideRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRideLocalDataSource = MockRideLocalDataSource();
    mockRideRemoteDataSource = MockRideRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    rideRepositoryImpl = RideRepositoryImpl(
        rideLocalDataSource: mockRideLocalDataSource,
        rideRemoteDataSource: mockRideRemoteDataSource,
        networkInfo: mockNetworkInfo);
  });
}
