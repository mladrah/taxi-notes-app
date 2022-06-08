import 'package:dartz/dartz.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:taxi_rahmati/core/usecases/usecase.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/ride.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/get_rides.dart';
import 'package:uuid/uuid.dart';

import 'add_ride_test.mocks.dart';

void main() {
  late MockRideRepository rideRepository;
  late GetRides usecase;

  setUp(() {
    rideRepository = MockRideRepository();
    usecase = GetRides(rideRepository: rideRepository);
  });

  final ride = Ride(
      id: const Uuid().v1(),
      name: 'tName',
      title: Title.herr,
      destination: 'tDestination',
      start: DateTime.parse('2022-06-11 13:37:27.000Z'),
      end: DateTime.parse('2022-06-11 14:37:27.000Z'),
      price: Decimal.parse('28.3'));

  List<Ride> allRides = [ride];

  test('should get all Rides', () async {
    // mock implementation of the interface
    when(rideRepository.getRides()).thenAnswer((_) async => Right(allRides));

    final result = await usecase(NoParams());

    expect(result, Right(allRides));

    // Verify that the method has been called on the Repository
    verify(rideRepository.getRides());

    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(rideRepository);
  });
}
