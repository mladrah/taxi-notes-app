import 'package:dartz/dartz.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taxi_rahmati/core/error/failures.dart';
import 'package:taxi_rahmati/core/util/input_converter.dart';

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
        'should return Decimal when the string represents a decimal number with comma',
        () async {
      // arrange
      const string = '28,30';

      // act
      final result = inputConverter.stringToDecimal(string);

      // assert
      expect(result, Right(Decimal.parse('28.30')));
    });

    test(
        'should return Decimal when the string represents a big decimal number with dot and comma',
        () async {
      // arrange
      const string = '9.128,30';

      // act
      final result = inputConverter.stringToDecimal(string);

      // assert
      expect(result, Right(Decimal.parse('9128.30')));
    });

    test(
        'should return Decimal when the string represents a decimal number with comma, invisible char and currency symbol',
        () async {
      // arrange
      const string = '31,21 €';

      // act
      final result = inputConverter.stringToDecimal(string);

      // assert
      expect(result, Right(Decimal.parse('31.21')));
    });

    test(
        'should return Decimal when the string represents a big decimal number with dot, comma and currency symbol',
        () async {
      // arrange
      const string = '9.128,30 €';

      // act
      final result = inputConverter.stringToDecimal(string);

      // assert
      expect(result, Right(Decimal.parse('9128.30')));
    });

    test(
        'should return positive decimal number when the string represents a negative decimal number',
        () async {
      // arrange
      const string = '-28.30';

      // act
      final result = inputConverter.stringToDecimal(string);

      // assert
      expect(result, Right(Decimal.parse('28.30')));
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

  group('dateTimesToDateTime', () {
    final date = DateTime.now();
    final time = DateTime.now();

    test(
        'should combine DateTime when date and time is passed as two DateTime objects',
        () async {
      final result = inputConverter.dateTimesToDateTime(date, time);

      expect(
          result,
          Right(DateTime(date.year, date.month, date.day, time.hour,
              time.minute, time.second)));
    });
  });
}
