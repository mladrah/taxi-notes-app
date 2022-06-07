import 'package:dartz/dartz.dart';
import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';
import '../error/failures.dart';

class InputConverter {
  Either<Failure, Decimal> stringToDecimal(String string) {
    try {
      string = string.replaceAll(RegExp(r'[^0-9,.]+'), '');

      if (string.contains(',') && string.contains('.')) {
        string = string.replaceAll('.', '');
        string = string.replaceAll(',', '.');
      } else if (string.contains(',')) {
        string = string.replaceAll(',', '.');
      }

      final Decimal decimal = Decimal.parse(string);

      return Right(decimal);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }

  Either<Failure, DateTime> stringToDateTime(String string) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

    try {
      return Right(dateFormat.parse(string));
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }

  Either<Failure, DateTime> dateAndTimeToDateTime(
      DateTime date, DateTime time) {
    return Right(DateTime(
        date.year, date.month, date.day, time.hour, time.minute, time.second));
  }
}
