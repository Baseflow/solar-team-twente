import 'package:equatable/equatable.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';

import '../../../../../core.dart';

/// {@template map_carrousel_state}
/// The state of the map carrousel.
/// {@endtemplate}
sealed class MapState extends Equatable {
  /// {@macro map_carrousel_state}
  const MapState();
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
}

/// {@template map_carrousel_race_loaded_state}
/// {@macro map_carrousel_state}
/// The state when the map carrousel has been loaded for during the race.
/// {@endtemplate}
class MapRaceLoaded extends MapState {
  /// {@macro map_carrousel_race_loaded_state}
  const MapRaceLoaded({
    required this.geoJsonParser,
    required this.vehicleLocation,
  });

  /// The parser for the entire race.
  final GeoJsonParser geoJsonParser;

  final VehicleLocation vehicleLocation;

  /// Copy the current state with the provided changes.
  MapRaceLoaded copyWith({
    GeoJsonParser? geoJsonParser,
    VehicleLocation? vehicleLocation,
  }) {
    return MapRaceLoaded(
      geoJsonParser: geoJsonParser ?? this.geoJsonParser,
      vehicleLocation: vehicleLocation ?? this.vehicleLocation,
    );
  }

  @override
  List<Object?> get props => <Object?>[geoJsonParser, vehicleLocation];
}
