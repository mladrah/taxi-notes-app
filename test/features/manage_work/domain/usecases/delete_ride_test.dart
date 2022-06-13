import 'package:dartz/dartz.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/ride.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/shared/params_ride.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/delete_ride.dart';
import 'package:uuid/uuid.dart';

import 'add_ride_test.mocks.dart';

void main() {
  late MockRideRepository mockRideRepository;
  late DeleteRide usecase;

  setUp(() {
    mockRideRepository = MockRideRepository();
    usecase = DeleteRide(workUnitRepository: mockRideRepository);
  });

  final ride = Ride(
      id: const Uuid().v1(),
      name: 'tName',
      title: Title.herr,
      destination: 'tDestination',
      start: DateTime.parse('2022-06-11 13:37:27.000Z'),
      end: DateTime.parse('2022-06-11 14:37:27.000Z'),
      price: Decimal.parse('28.3'));

  test('should delete Ride', () async {
    // mock implementation of the interface
    when(mockRideRepository.deleteRide(ride))
        .thenAnswer((_) async => Right(ride));

    final result = await usecase(WorkUnitRidesParams(ride: ride));

    expect(result, Right(ride));

    // Verify that the method has been called on the Repository
    verify(mockRideRepository.deleteRide(ride));

    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockRideRepository);
  });
}
