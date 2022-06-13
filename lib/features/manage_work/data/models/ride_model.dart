import 'package:decimal/decimal.dart';

import '../../domain/entities/ride.dart';
import 'package:enum_to_string/enum_to_string.dart';

class RideModel extends Ride {
  const RideModel(
      {required id,
      required name,
      required title,
      required fromDestination,
      required toDestination,
      required start,
      required end,
      required price})
      : super(
            id: id,
            name: name,
            title: title,
            fromDestination: fromDestination,
            toDestination: toDestination,
            start: start,
            end: end,
            price: price);

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
        id: json['id'],
        name: json['name'],
        title: EnumToString.fromString(Title.values, json['title']),
        fromDestination: json['fromDestination'],
        toDestination: json['toDestination'],
        start: DateTime.parse(json['start']),
        end: DateTime.parse(json['end']),
        price: Decimal.fromJson(json['price']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'title': EnumToString.convertToString(title),
      'fromDestination': fromDestination,
      'toDestination': toDestination,
      'start': start.toString(),
      'end': end.toString(),
      'price': price.toJson()
    };
  }
}
