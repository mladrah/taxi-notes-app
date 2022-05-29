import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class WorkUnit extends Equatable {
  final Uuid id;
  final DateTime date;

  WorkUnit({this.id = const Uuid(), required this.date}) : super([id, date]);
}
