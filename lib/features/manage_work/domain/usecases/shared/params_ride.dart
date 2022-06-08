import 'package:equatable/equatable.dart';

import '../../entities/ride.dart';

class Params extends Equatable {
  final Ride ride;

  const Params({required this.ride});

  @override
  List<Object> get props => [ride];
}
