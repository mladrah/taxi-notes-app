import 'package:decimal/decimal.dart';

import '../../domain/entities/ride.dart';
import 'package:enum_to_string/enum_to_string.dart';

class RideModel extends Ride {
  const RideModel(
      {required name,
      required title,
      required destination,
      required start,
      required end,
      required price})
      : super(
            name: name,
            title: title,
            destination: destination,
            start: start,
            end: end,
            price: price);

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
        name: json['name'],
        title: EnumToString.fromString(Title.values, json['title']),
        destination: json['destination'],
        start: DateTime.parse(json['start']),
        end: DateTime.parse(json['end']),
        price: Decimal.fromJson(json['price']));
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': EnumToString.convertToString(title),
      'destination': destination,
      'start': start.toString(),
      'end': end.toString(),
      'price': price.toJson()
    };
  }
}
