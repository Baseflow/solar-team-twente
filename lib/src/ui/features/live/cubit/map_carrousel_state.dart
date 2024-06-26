import 'package:flutter_map_geojson/flutter_map_geojson.dart';

/// {@template map_carrousel_state}
/// The state of the map carrousel.
/// {@endtemplate}
sealed class MapCarrouselState {
  /// {@macro map_carrousel_state}
  const MapCarrouselState();
}

/// {@template map_carrousel_initial_state}
/// {@macro map_carrousel_state}
/// The initial state of the map carrousel.
/// {@endtemplate}
class MapCarrouselInitialState extends MapCarrouselState {
  /// {@macro map_carrousel_initial_state}
  const MapCarrouselInitialState();
}

/// {@template map_carrousel_loading_state}
/// {@macro map_carrousel_state}
/// The state when the map carrousel is loading.
/// {@endtemplate}
class MapCarrouselLoadingState extends MapCarrouselState {
  /// {@macro map_carrousel_loading_state}
  const MapCarrouselLoadingState() : super();
}

/// {@template map_carrousel_race_loaded_state}
/// {@macro map_carrousel_state}
/// The state when the map carrousel has been loaded for during the race.
/// {@endtemplate}
class MapCarrouselRaceLoadedState extends MapCarrouselState {
  /// {@macro map_carrousel_race_loaded_state}
  const MapCarrouselRaceLoadedState({
    required this.currentParserIndex,
    required this.geoJsonParser,
    this.geoJsonParsers = const <int, GeoJsonParser>{},
  }) : super();

  /// The current day that is being looked at.
  final int currentParserIndex;

  /// All Parsers that have been loaded.
  final Map<int, GeoJsonParser> geoJsonParsers;

  /// The parser for the entire race.
  final GeoJsonParser geoJsonParser;

  /// Copy the current state with the provided changes.
  MapCarrouselRaceLoadedState copyWith({
    int? currentParserIndex,
    Map<int, GeoJsonParser>? geoJsonParsers,
    GeoJsonParser? geoJsonParser,
  }) {
    return MapCarrouselRaceLoadedState(
      currentParserIndex: currentParserIndex ?? this.currentParserIndex,
      geoJsonParsers: geoJsonParsers ?? this.geoJsonParsers,
      geoJsonParser: geoJsonParser ?? this.geoJsonParser,
    );
  }
}
