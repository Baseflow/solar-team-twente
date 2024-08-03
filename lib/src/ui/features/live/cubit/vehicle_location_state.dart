// State classes remain the same
import 'package:equatable/equatable.dart';

import '../../../../../core.dart';

abstract class VehicleLocationState extends Equatable {
  const VehicleLocationState();

  @override
  List<Object?> get props => <Object?>[];
}

class VehicleLocationInitial extends VehicleLocationState {}

class VehicleLocationLoading extends VehicleLocationState {}

class VehicleLocationLoaded extends VehicleLocationState {
  const VehicleLocationLoaded(this.vehicleLocations);
  final List<VehicleLocation> vehicleLocations;

  @override
  List<Object?> get props => <Object?>[vehicleLocations];
}

class VehicleLocationError extends VehicleLocationState {
  const VehicleLocationError(this.message);
  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
