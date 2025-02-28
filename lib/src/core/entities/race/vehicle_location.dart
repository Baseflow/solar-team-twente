import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class VehicleLocation extends Equatable {
  const VehicleLocation({
    required this.name,
    required this.coordinates,
    required this.lastSeen,
  });

  /// Default vehicle location.
  ///
  /// Defaults to Johannesburg, South Africa.
  const VehicleLocation.initial()
      : name = 'Whoops',
        coordinates = const LatLng(26.2041, 28.0473),
        lastSeen = -1;

  final String name;
  final LatLng coordinates;
  final int lastSeen;

  @override
  List<Object?> get props => <Object?>[name, coordinates, lastSeen];
}
