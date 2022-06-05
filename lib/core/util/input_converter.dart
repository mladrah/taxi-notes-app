import 'package:dartz/dartz.dart';
import 'package:decimal/decimal.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:intl/intl.dart';

import '../../features/manage_work/domain/entities/ride.dart';
import '../error/failures.dart';

class InputConverter {
  Either<Failure, Decimal> stringToDecimal(String string) {
    try {
      final Decimal decimal = Decimal.parse(string);

      if (decimal.signum < 0) throw const FormatException();

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

  Either<Failure, Title> stringToTitleEnum(String string) {
    Title? title = EnumToString.fromString(Title.values, string);

    return title == null ? Left(InvalidInputFailure()) : Right(title);
  }
}
