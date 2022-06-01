import 'work_month.dart';
import 'work_unit.dart';

class WorkYear extends WorkUnit {
  final List workMonths;

  const WorkYear({date, this.workMonths = const <WorkMonth>[]})
      : super(date: date);

  @override
  List<Object> get props => [date, workMonths];
}
