import '../../../../core.dart';
import '../clients/vehicle_location_client.dart';

class VehicleLocationRepositoryImpl implements VehicleLocationRepository {
  const VehicleLocationRepositoryImpl({
    required VehicleLocationClient vehicleLocationClient,
  }) : _vehicleLocationClient = vehicleLocationClient;

  final VehicleLocationClient _vehicleLocationClient;

  @override
  Future<List<VehicleLocation>> getAllVehicleLocations() async {
    return _vehicleLocationClient.getAllVehicleLocations();
  }
}
