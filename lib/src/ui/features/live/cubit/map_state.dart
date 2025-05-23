import 'package:equatable/equatable.dart';

import '../../../../../core.dart';

/// {@template map_carrousel_state}
/// The state of the map carrousel.
/// {@endtemplate}
sealed class MapState extends Equatable {
  /// {@macro map_carrousel_state}
  const MapState({this.vehicleLocation = const VehicleLocation.initial()});

  final VehicleLocation vehicleLocation;

  MapState copyWith({VehicleLocation? vehicleLocation});
}

/// {@template map_carrousel_initial_state}
/// {@macro map_carrousel_state}
/// The initial state of the map carrousel.
/// {@endtemplate}
class MapInitial extends MapState {
  /// {@macro map_carrousel_initial_state}
  const MapInitial();

  @override
  List<Object?> get props => <Object?>[];

  @override
  MapState copyWith({VehicleLocation? vehicleLocation}) {
    return const MapInitial();
  }
}

/// {@template map_carrousel_loading_state}
/// {@macro map_carrousel_state}
/// The state when the map carrousel is loading.
/// {@endtemplate}
class MapLoading extends MapState {
  /// {@macro map_carrousel_loading_state}
  const MapLoading() : super();

  @override
  List<Object?> get props => <Object?>[];

  @override
  MapState copyWith({VehicleLocation? vehicleLocation}) {
    return const MapLoading();
  }
}

/// {@template map_carrousel_race_loaded_state}
/// {@macro map_carrousel_state}
/// The state when the map carrousel has been loaded for during the race.
/// {@endtemplate}
class MapRaceLoaded extends MapState {
  /// {@macro map_carrousel_race_loaded_state}
  const MapRaceLoaded({required super.vehicleLocation});

  /// Copy the current state with the provided changes.
  @override
  MapState copyWith({VehicleLocation? vehicleLocation}) {
    return MapRaceLoaded(vehicleLocation: vehicleLocation ?? this.vehicleLocation);
  }

  @override
  List<Object?> get props => <Object?>[vehicleLocation];
}
