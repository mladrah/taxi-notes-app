import 'work_unit.dart';
import 'work_day.dart';

class WorkMonth extends WorkUnit {
  final List workdays;

  const WorkMonth({required date, this.workdays = const <WorkDay>[]})
      : super(date: date);

  @override
  List<Object> get props => [date, workdays];
}
