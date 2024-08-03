import '../entities/race/vehicle_location.dart';

abstract interface class VehicleLocationRepository {
  /// Retrieves all vehicle locations.
  Future<List<VehicleLocation>> getAllVehicleLocations();
}
