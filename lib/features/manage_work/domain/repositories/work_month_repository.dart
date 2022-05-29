import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/work_day.dart';

abstract class WorkMonthRepository {
  Future<Either<Failure, List<WorkDay>>> getAllWorkDays();
}
