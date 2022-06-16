import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String dayMonth(DateTime date) {
    final DateFormat _dateFormatter = DateFormat('dd.MM');
    return _dateFormatter.format(date);
  }

  static String dayMonthYear(DateTime date) {
    final DateFormat _dateFormatter = DateFormat('dd.MM.yyyy');
    return _dateFormatter.format(date);
  }

  static String hourMinute(DateTime time) {
    final DateFormat _timeFormatter = DateFormat('HH:mm');
    return _timeFormatter.format(time);
  }
}
