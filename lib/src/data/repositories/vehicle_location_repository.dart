import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core.dart';
import '../dto/race/vehicle_location_dto.dart';

class SupabaseVehicleLocationRepository implements VehicleLocationRepository {
  SupabaseVehicleLocationRepository({required SupabaseClient client})
    : _client = client;

  final SupabaseClient _client;

  @override
  Stream<VehicleLocation> get vehicleLocation {
    final SupabaseStreamBuilder response = _client
        .from('vehicle_locations')
        .stream(primaryKey: <String>['id'])
        .order('last_seen')
        .limit(1);

    return response.map((List<Map<String, dynamic>> data) {
      return VehicleLocationDto.fromJson(data.single).toEntity();
    });
  }
}
