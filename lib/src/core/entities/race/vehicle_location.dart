import 'package:equatable/equatable.dart';

class VehicleLocation extends Equatable {
  const VehicleLocation({
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.lastSeen,
  });

  final String name;
  final double longitude;
  final double latitude;
  final int lastSeen;

  @override
  List<Object?> get props => <Object?>[
        name,
        longitude,
        latitude,
        lastSeen,
      ];
}
