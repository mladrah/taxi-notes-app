import 'package:dartz/dartz.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:taxi_rahmati/core/error/failures.dart';
import 'package:taxi_rahmati/core/util/input_converter.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/ride.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/add_ride.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/get_all_rides.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/bloc/manage_work_bloc.dart';

import 'manage_work_bloc_test.mocks.dart';

@GenerateMocks([AddRide, GetAllRides, InputConverter])
void main() {
  late ManageWorkBloc bloc;
  late MockAddRide mockAddRide;
  late MockGetAllRides mockGetAllRides;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockAddRide = MockAddRide();
    mockGetAllRides = MockGetAllRides();
    mockInputConverter = MockInputConverter();

    bloc = ManageWorkBloc(
        addRideUseCase: mockAddRide,
        getAllRidesUseCase: mockGetAllRides,
        inputConverter: mockInputConverter);
  });

  test('inititalState should be Empty', () {
    expect(bloc.state, Empty());
  });

  group('AddRideToList', () {
    const String tName = 'Lorem';
    const String tTitle = 'herr';
    const String tDestination = 'Ipsum';
    const String tStart = '2022-06-01 22:30:00';
    const String tEnd = '2022-06-01 23:30:00';
    const String tPrice = '29.30';

    const Title tTitleParsed = Title.herr;
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    final DateTime tStartParsed = dateFormat.parse(tStart);
    final DateTime tEndParsed = dateFormat.parse(tEnd);
    final Decimal tPriceParsed = Decimal.parse(tPrice);

    test('should call the InputConverter to validate and convert the strings',
        () async {
      // arrange
      when(mockInputConverter.stringToTitleEnum(tTitle))
          .thenReturn(const Right(tTitleParsed));
      when(mockInputConverter.stringToDateTime(tStart))
          .thenReturn(Right(tStartParsed));
      when(mockInputConverter.stringToDateTime(tEnd))
          .thenReturn(Right(tEndParsed));
      when(mockInputConverter.stringToDecimal(tPrice))
          .thenReturn(Right(tPriceParsed));

      // act
      bloc.add(const AddRideToList(
          tName, tTitle, tDestination, tStart, tEnd, tPrice));
      await untilCalled(mockInputConverter.stringToTitleEnum(any));
      await untilCalled(mockInputConverter.stringToDateTime(any));
      await untilCalled(mockInputConverter.stringToDecimal(any));

      // assert
      verify(mockInputConverter.stringToTitleEnum(tTitle));
      verify(mockInputConverter.stringToDateTime(any));
      verify(mockInputConverter.stringToDecimal(tPrice));
    });

    test('should emit Error when the input is invalid', () async {
      // assert
      when(mockInputConverter.stringToTitleEnum(any))
          .thenReturn(Left(InvalidInputFailure()));

      // assert later
      expectLater(bloc.stream.asBroadcastStream(),
          emits(const Error(message: INVALID_INPUT_MESSAGE)));

      // act
      bloc.add(const AddRideToList(
          tName, tTitle, tDestination, tStart, tEnd, tPrice));
    });
  });
}
