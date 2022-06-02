import 'package:equatable/equatable.dart';
import 'package:decimal/decimal.dart';

class Ride extends Equatable {
  final String id;
  final String name;
  final Title title;
  final String destination;
  final DateTime start;
  final DateTime end;
  final Decimal price;

  const Ride(
      {required this.id,
      required this.name,
      required this.title,
      required this.destination,
      required this.start,
      required this.end,
      required this.price});

  @override
  List<Object> get props => [id, name, title, destination, start, end, price];
}

enum Title { herr, frau }
