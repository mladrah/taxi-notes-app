import 'package:equatable/equatable.dart';
import 'package:decimal/decimal.dart';
import 'package:uuid/uuid.dart';

class Ride extends Equatable {
  final Uuid id = const Uuid();
  final String name;
  final Title title;
  final String destination;
  final DateTime start;
  final DateTime end;
  final Decimal price;

  const Ride(
      {required this.name,
      required this.title,
      required this.destination,
      required this.start,
      required this.end,
      required this.price});

  @override
  List<Object> get props => [name, title, destination, start, end, price];
}

enum Title { herr, frau }
