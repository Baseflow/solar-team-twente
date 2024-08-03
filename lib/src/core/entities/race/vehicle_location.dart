import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class VehicleLocation extends Equatable {
  const VehicleLocation({
    required this.name,
    required this.coordinates,
    required this.lastSeen,
  });

  final String name;
  final LatLng coordinates;
  final int lastSeen;

  @override
  List<Object?> get props => <Object?>[
        name,
        coordinates,
        lastSeen,
      ];
}
