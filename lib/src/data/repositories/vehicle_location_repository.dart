import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core.dart';
import '../dto/race/vehicle_location_dto.dart';

class SupabaseVehicleLocationRepository implements VehicleLocationRepository {
  SupabaseVehicleLocationRepository({required SupabaseClient supabaseClient})
      : _client = supabaseClient;

  final SupabaseClient _client;

  @override
  Future<VehicleLocation> getVehicleLocation() {
    final PostgrestTransformBuilder<List<Map<String, dynamic>>> response =
        _client
            .from("vehicle_locations")
            .select("last_seen")
            .order("last_seen", ascending: true)
            .limit(1);
    return response.then((List<Map<String, dynamic>> data) {
      return VehicleLocationDto.fromJson(data.first).toEntity();
    }).onError(
      (Object error, StackTrace stackTrace) => Future<VehicleLocation>.value(
        VehicleLocationDto.fromJson(
          <String, dynamic>{
            "name": "DMU",
            "longitude": 5.889339,
            "latitude": 52.060017,
            "last_seen": 1720354200
          },
        ).toEntity(),
      ),
    );
  }
}
