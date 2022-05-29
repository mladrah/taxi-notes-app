import 'package:dartz/dartz.dart';
import 'work_month.dart';
import 'work_unit.dart';

class WorkYear extends WorkUnit {
  final List workMonths;

  WorkYear({date, this.workMonths = const <WorkMonth>[]}) : super(date: date);
}
