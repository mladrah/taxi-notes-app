import '../../domain/entities/ride.dart';

abstract class DataSource {
  Future<List<Ride>> getAllRides();
  Future<void> saveAllRides();
}
