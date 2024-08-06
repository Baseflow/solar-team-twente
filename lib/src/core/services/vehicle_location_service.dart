import '../entities/race/vehicle_location.dart';
import '../repositories/vehicle_location_repository.dart';

class VehicleLocationService {
  const VehicleLocationService({
    required VehicleLocationRepository vehicleLocationRepository,
  }) : _vehicleLocationRepository = vehicleLocationRepository;

  final VehicleLocationRepository _vehicleLocationRepository;

  Stream<VehicleLocation> get vehicleLocation {
    return _vehicleLocationRepository.vehicleLocation;
  }
}
