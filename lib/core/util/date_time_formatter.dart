// ignore: unused_import
import 'dart:developer';
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

  static String dayMonthInterval(DateTime dateA, DateTime dateB) {
    if (_datesEqual(dateA, dateB)) {
      return dayMonth(dateA);
    } else {
      return '${dayMonth(dateA)} - ${dayMonth(dateB)}';
    }
  }

  static bool _datesEqual(DateTime dateA, DateTime dateB) {
    return dateA.year == dateB.year &&
        dateA.month == dateB.month &&
        dateA.day == dateB.day;
  }
}
