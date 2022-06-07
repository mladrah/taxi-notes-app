import 'package:dartz/dartz.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:taxi_rahmati/core/error/failures.dart';
import 'package:taxi_rahmati/core/usecases/usecase.dart';
import 'package:taxi_rahmati/core/util/input_converter.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/ride.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/add_ride.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/get_all_rides.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/bloc/manage_work_bloc.dart';
import 'package:uuid/uuid.dart';
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
    const Title tTitle = Title.herr;
    const String tDestination = 'Ipsum';
    DateTime tStartDate = DateTime.now();
    DateTime tStartTime = DateTime.now();
    DateTime tEndDate = DateTime.now();
    DateTime tEndTime = DateTime.now();
    const String tPrice = '29,30';

    DateTime tStartParsed = DateTime(
      tStartDate.year,
      tStartDate.month,
      tStartDate.day,
      tStartTime.hour,
      tStartTime.month,
      tStartTime.day,
    );
    DateTime tEndParsed = DateTime(
      tEndDate.year,
      tEndDate.month,
      tEndDate.day,
      tEndTime.hour,
      tEndTime.month,
      tEndTime.day,
    );
    final Decimal tPriceParsed = Decimal.parse('29.30');

    Ride ride = Ride(
      id: const Uuid().v1(),
      name: tName,
      title: tTitle,
      destination: tDestination,
      start: tStartParsed,
      end: tEndParsed,
      price: tPriceParsed,
    );

    setUpInputConverterSuccess() {
      when(mockInputConverter.stringToDecimal(any))
          .thenReturn(Right(tPriceParsed));
      when(mockInputConverter.dateAndTimeToDateTime(any, any))
          .thenReturn(Right(tStartParsed));
    }

    setUpInputConverterFailure() {
      when(mockInputConverter.stringToDecimal(any))
          .thenReturn(Left(InvalidInputFailure()));
      when(mockInputConverter.dateAndTimeToDateTime(any, any))
          .thenReturn(Left(InvalidInputFailure()));
    }

    test('should call the InputConverter to validate and convert the strings',
        () async {
      // arrange
      setUpInputConverterSuccess();
      when(mockAddRide(any)).thenAnswer((_) async => Right(ride));

      // act
      bloc.add(
        AddRideToList(
          title: tTitle,
          name: tName,
          destination: tDestination,
          startDate: tStartDate,
          startTime: tStartTime,
          endDate: tEndDate,
          endTime: tEndTime,
          price: tPrice,
        ),
      );

      await untilCalled(mockInputConverter.dateAndTimeToDateTime(any, any));
      await untilCalled(mockInputConverter.dateAndTimeToDateTime(any, any));
      await untilCalled(mockInputConverter.stringToDecimal(any));

      // assert
      verify(mockInputConverter.dateAndTimeToDateTime(tStartDate, tStartTime));
      verify(mockInputConverter.stringToDecimal(tPrice));
    });

    test('should emit Error when the input is invalid', () async {
      // assert
      setUpInputConverterFailure();

      // assert later
      expectLater(bloc.stream.asBroadcastStream(),
          emits(const Error(message: INVALID_INPUT_MESSAGE)));

      // act
      bloc.add(
        AddRideToList(
          title: tTitle,
          name: tName,
          destination: tDestination,
          startDate: tStartDate,
          startTime: tStartTime,
          endDate: tEndDate,
          endTime: tEndTime,
          price: tPrice,
        ),
      );
    });

    test('should return true when use case is called', () async {
      setUpInputConverterSuccess();
      when(mockAddRide(any)).thenAnswer((_) async => Right(ride));

      bloc.add(
        AddRideToList(
          title: tTitle,
          name: tName,
          destination: tDestination,
          startDate: tStartDate,
          startTime: tStartTime,
          endDate: tEndDate,
          endTime: tEndTime,
          price: tPrice,
        ),
      );
      await untilCalled(mockAddRide(any));

      verify(mockAddRide(any));
    });

    test(
      'should emit [Loading, Created] when Ride is created successfully',
      () async {
        // arrange
        setUpInputConverterSuccess();
        when(mockAddRide(any)).thenAnswer((_) async => Right(ride));

        // assert later
        final expected = [
          Loading(),
          Created(ride: ride),
        ];
        expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(expected));

        // act
        bloc.add(
          AddRideToList(
            title: tTitle,
            name: tName,
            destination: tDestination,
            startDate: tStartDate,
            startTime: tStartTime,
            endDate: tEndDate,
            endTime: tEndTime,
            price: tPrice,
          ),
        );
      },
    );

    test(
      'should emit [Loading, Error] (ServerFailure) when adding ride fails',
      () async {
        // arrange
        setUpInputConverterSuccess();
        when(mockAddRide(any)).thenAnswer((_) async => Left(ServerFailure()));

        // assert later
        final expected = [
          Loading(),
          const Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(expected));
        // act
        bloc.add(
          AddRideToList(
            title: tTitle,
            name: tName,
            destination: tDestination,
            startDate: tStartDate,
            startTime: tStartTime,
            endDate: tEndDate,
            endTime: tEndTime,
            price: tPrice,
          ),
        );
      },
    );

    test(
      'should emit [Loading, Error] (LocalFailure) when adding ride fails',
      () async {
        // arrange
        setUpInputConverterSuccess();
        when(mockAddRide(any)).thenAnswer((_) async => Left(LocalFailure()));

        // assert later
        final expected = [
          Loading(),
          const Error(message: LOCAL_FAILURE_MESSAGE),
        ];
        expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(expected));
        // act

        bloc.add(
          AddRideToList(
            title: tTitle,
            name: tName,
            destination: tDestination,
            startDate: tStartDate,
            startTime: tStartTime,
            endDate: tEndDate,
            endTime: tEndTime,
            price: tPrice,
          ),
        );
      },
    );
  });

  group('ListAllRides', () {
    final ride = Ride(
        id: const Uuid().v1(),
        name: 'tName',
        title: Title.herr,
        destination: 'tDestination',
        start: DateTime.parse('2022-06-11 13:37:27.000Z'),
        end: DateTime.parse('2022-06-11 14:37:27.000Z'),
        price: Decimal.parse('28.3'));

    List<Ride> allRides = [ride];
    test(
      'should get all rides from the use case',
      () async {
        // arrange
        when(mockGetAllRides(any)).thenAnswer((_) async => Right(allRides));

        // act
        bloc.add(ListAllRides());
        await untilCalled(mockGetAllRides(any));

        // assert
        verify(mockGetAllRides(NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when all rides is gotten successfully',
      () async {
        // arrange
        when(mockGetAllRides(any)).thenAnswer((_) async => Right(allRides));
        // assert later

        final expected = [
          Loading(),
          Loaded(allRides: allRides),
        ];

        expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(expected));

        // act
        bloc.add(ListAllRides());
      },
    );

    test(
      'should emit [Loading, Error] (ServerFailure) when retrieving all rides fails',
      () async {
        // arrange
        when(mockGetAllRides(any))
            .thenAnswer((_) async => Left(ServerFailure()));

        // assert later
        final expected = [
          Loading(),
          const Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(expected));

        // act
        bloc.add(ListAllRides());
      },
    );
    test(
      'should emit [Loading, Error] (LocalFailure) when retrieving all rides fails',
      () async {
        // arrange
        when(mockGetAllRides(any))
            .thenAnswer((_) async => Left(LocalFailure()));

        // assert later
        final expected = [
          Loading(),
          const Error(message: LOCAL_FAILURE_MESSAGE),
        ];
        expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(expected));

        // act
        bloc.add(ListAllRides());
      },
    );
  });
}
