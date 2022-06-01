import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class WorkUnit extends Equatable {
  final Uuid id = const Uuid();
  final DateTime date;

  const WorkUnit({required this.date});
}
