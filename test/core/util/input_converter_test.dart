import 'package:dartz/dartz.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taxi_rahmati/core/error/failures.dart';
import 'package:taxi_rahmati/core/util/input_converter.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/ride.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToDecimal', () {
    test('should return Decimal when the string represents a decimal number',
        () async {
      // arrange
      const string = '28.30';

      // act
      final result = inputConverter.stringToDecimal(string);

      // assert
      expect(result, Right(Decimal.parse(string)));
    });

    test(
        'should return Failure when the string represents a negative decimal number',
        () async {
      // arrange
      const string = '-28.30';

      // act
      final result = inputConverter.stringToDecimal(string);

      // assert
      expect(result, Left(InvalidInputFailure()));
    });

    test(
        'should return Failure when the string does not represent a decimal number',
        () async {
      // arrange
      const string = 'alphanumeric123';

      // act
      final result = inputConverter.stringToDecimal(string);

      // assert
      expect(result, Left(InvalidInputFailure()));
    });
  });

  group('stringToDateTime', () {
    test(
        'should return DateTime when the string represents a date and time with pattern: yyyy-mm-dd hh:mm:ss',
        () async {
      const string = '2022-06-01 8:40:23';

      final result = inputConverter.stringToDateTime(string);

      expect(result, Right(DateTime(2022, 6, 1, 8, 40, 23)));
    });

    test(
        'should return Failure when the string does not match pattern: yyyy-mm-dd hh:mm:ss',
        () async {
      const string = '2022-06 8:40';

      final result = inputConverter.stringToDateTime(string);

      expect(result, Left(InvalidInputFailure()));
    });
  });

  group('stringToTitleEnum', () {
    test('should return Title when the string represents enum value', () async {
      const string = 'herr';

      final result = inputConverter.stringToTitleEnum(string);

      expect(result, const Right(Title.herr));
    });

    test('should return Failure when the string does not represent enum value',
        () async {
      const string = 'mr';

      final result = inputConverter.stringToTitleEnum(string);

      expect(result, Left(InvalidInputFailure()));
    });
  });
}
