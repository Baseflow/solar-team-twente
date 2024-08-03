import '../entities/race/vehicle_location.dart';

abstract interface class VehicleLocationRepository {
  /// Retrieves all vehicle locations.
  Future<VehicleLocation> getVehicleLocation();
}
