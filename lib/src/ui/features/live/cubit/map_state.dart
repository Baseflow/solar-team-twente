import 'package:equatable/equatable.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';

import '../../../../../core.dart';

/// {@template map_carrousel_state}
/// The state of the map carrousel.
/// {@endtemplate}
sealed class MapState extends Equatable {
  /// {@macro map_carrousel_state}
  const MapState({this.vehicleLocation = const VehicleLocation.initial(), this.geoJson});

  final VehicleLocation vehicleLocation;
  final GeoJsonParser? geoJson;

  MapState copyWith({VehicleLocation? vehicleLocation, GeoJsonParser? geoJson});
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
  MapState copyWith({VehicleLocation? vehicleLocation, GeoJsonParser? geoJson}) {
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
  MapState copyWith({VehicleLocation? vehicleLocation, GeoJsonParser? geoJson}) {
    return const MapLoading();
  }
}

/// {@template map_carrousel_race_loaded_state}
/// {@macro map_carrousel_state}
/// The state when the map carrousel has been loaded for during the race.
/// {@endtemplate}
class MapRaceLoaded extends MapState {
  /// {@macro map_carrousel_race_loaded_state}
  const MapRaceLoaded({required super.vehicleLocation, required super.geoJson});

  /// Copy the current state with the provided changes.
  @override
  MapState copyWith({VehicleLocation? vehicleLocation, GeoJsonParser? geoJson}) {
    return MapRaceLoaded(vehicleLocation: vehicleLocation ?? this.vehicleLocation, geoJson: geoJson ?? this.geoJson);
  }

  @override
  List<Object?> get props => <Object?>[vehicleLocation, geoJson];
}
