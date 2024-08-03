import '../../../core.dart';

final class VehicleLocationClient {
  Future<VehicleLocation> getVehicleLocation() async {
    return VehicleLocation(
      name: 'name',
      longitude: 0.0,
      latitude: 0.0,
      lastSeen: 0,
    );
  }
}
