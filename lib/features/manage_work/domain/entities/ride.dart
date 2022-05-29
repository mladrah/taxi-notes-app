import 'package:equatable/equatable.dart';
import 'package:decimal/decimal.dart';
import 'package:uuid/uuid.dart';

// class 'Equatable' applies equals method -> values to apply equals are inside super(...)
class Ride extends Equatable {
  final Uuid id;
  final String name;
  final Title title;
  final String destination;
  final DateTime start;
  final DateTime end;
  final Decimal price;

  Ride(
      {this.id = const Uuid(),
      required this.name,
      required this.title,
      required this.destination,
      required this.start,
      required this.end,
      required this.price})
      : super([id, name, title, destination, start, end, price]);
}

enum Title { herr, frau }
