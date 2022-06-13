import '../../domain/entities/work_unit.dart';
import 'ride_model.dart';

class WorkUnitModel extends WorkUnit {
  final List<RideModel> rideModels;

  const WorkUnitModel({required id, required this.rideModels})
      : super(id: id, rides: rideModels);

  factory WorkUnitModel.fromJson(Map<String, dynamic> json) {
    Iterable l = json['rides'];

    return WorkUnitModel(
        id: json['id'],
        rideModels: List<RideModel>.from(
            l.map((rideModel) => RideModel.fromJson(rideModel))));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rides': rideModels.map((ride) => ride.toJson()).toList()
    };
  }
}
