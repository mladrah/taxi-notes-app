import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/work_month.dart';

abstract class WorkYearRepository {
  Future<Either<Failure, List<WorkMonth>>> getAllWorkMonths();
}
