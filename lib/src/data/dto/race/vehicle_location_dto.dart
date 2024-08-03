import '../../../../core.dart';

class VehicleLocationDto {
  VehicleLocationDto({
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.lastSeen,
  });

  factory VehicleLocationDto.fromJson(Map<String, dynamic> json) {
    return VehicleLocationDto(
      name: json['name'] as String,
      longitude: json['longitude'] as double,
      latitude: json['latitude'] as double,
      lastSeen: json['last_seen'] as int,
    );
  }

  factory VehicleLocationDto.fromEntity(VehicleLocation vehicleLocation) {
    return VehicleLocationDto(
      name: vehicleLocation.name,
      longitude: vehicleLocation.longitude,
      latitude: vehicleLocation.latitude,
      lastSeen: vehicleLocation.lastSeen,
    );
  }

  final String name;
  final double longitude;
  final double latitude;
  final int lastSeen;

  VehicleLocation toEntity() {
    return VehicleLocation(
      name: name,
      longitude: longitude,
      latitude: latitude,
      lastSeen: lastSeen,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'longitude': longitude,
      'latitude': latitude,
      'last_seen': lastSeen,
    };
  }
}
