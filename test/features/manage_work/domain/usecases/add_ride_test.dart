import 'package:dartz/dartz.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/ride.dart';
import 'package:taxi_rahmati/features/manage_work/domain/repositories/work_day_repository.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/add_ride.dart';

import 'add_ride_test.mocks.dart';

// class MockWorkDayRepository extends Mock implements WorkDayRepository {}

@GenerateMocks([WorkDayRepository])
void main() {
  late MockWorkDayRepository mockWorkDayRepository;
  late AddRide usecase;

  setUp(() {
    mockWorkDayRepository = MockWorkDayRepository();
    usecase = AddRide(workDayRepository: mockWorkDayRepository);
  });

  final currentDateTime = DateTime.now();
  final ride = Ride(
      name: 'tName',
      title: Title.herr,
      destination: 'tDestination',
      start: currentDateTime,
      end: currentDateTime.add(const Duration(hours: 1)),
      price: Decimal.parse('28.30'));

  test('should add Ride', () async {
    // mock implementation of the interface
    when(mockWorkDayRepository.addRide(ride))
        .thenAnswer((_) async => Right(ride));

    final result = await usecase(Params(ride: ride));

    expect(result, Right(ride));

    // Verify that the method has been called on the Repository
    verify(mockWorkDayRepository.addRide(ride));

    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockWorkDayRepository);
  });
}
