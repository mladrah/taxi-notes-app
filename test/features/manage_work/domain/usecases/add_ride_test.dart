// import 'package:dartz/dartz.dart';
// import 'package:decimal/decimal.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:taxi_rahmati/features/manage_work/domain/entities/ride.dart';
// import 'package:taxi_rahmati/features/manage_work/domain/repositories/work_unit_repository.dart';
// import 'package:taxi_rahmati/features/manage_work/domain/usecases/add_ride.dart';
// import 'package:taxi_rahmati/features/manage_work/domain/usecases/shared/params_ride.dart';

// import 'package:uuid/uuid.dart';

// import 'add_ride_test.mocks.dart';

// @GenerateMocks([WorkUnitRepository])
// void main() {
//   late MockWorkUnitRepository mockWorkUnitRepository;
//   late AddRide usecase;

//   setUp(() {
//     mockWorkUnitRepository = MockWorkUnitRepository();
//     usecase = AddRide(workUnitRepository: mockWorkUnitRepository);
//   });

//   final ride = Ride(
//       id: const Uuid().v1(),
//       name: 'tName',
//       title: Title.herr,
//       destination: 'tDestination',
//       start: DateTime.parse('2022-06-11 13:37:27.000Z'),
//       end: DateTime.parse('2022-06-11 14:37:27.000Z'),
//       price: Decimal.parse('28.3'));

//   test('should add Ride', () async {
//     // mock implementation of the interface
//     when(mockWorkUnitRepository.addRide(ride))
//         .thenAnswer((_) async => Right(ride));

//     final result = await usecase(WorkUnitRidesParams(ride: ride));

//     expect(result, Right(ride));

//     // Verify that the method has been called on the Repository
//     verify(mockWorkUnitRepository.addRide(ride));

//     // Only the above method should be called and nothing more.
//     verifyNoMoreInteractions(mockWorkUnitRepository);
//   });
// }
