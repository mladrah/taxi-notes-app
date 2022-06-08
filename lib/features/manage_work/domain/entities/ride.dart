import 'package:equatable/equatable.dart';
import 'package:decimal/decimal.dart';

class Ride extends Equatable {
  final String id;
  final Title title;
  final String name;
  final String destination;
  final DateTime start;
  final DateTime end;
  final Decimal price;

  const Ride(
      {required this.id,
      required this.title,
      required this.name,
      required this.destination,
      required this.start,
      required this.end,
      required this.price});

  @override
  List<Object> get props => [id, title, name, destination, start, end, price];
}

enum Title { herr, frau }
