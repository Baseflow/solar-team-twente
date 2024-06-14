import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../constants/ui_constants.dart';
import 'map_carrousel_state.dart';

/// {@template map_carrousel_cubit}
/// Manages the state of the map carrousel.
/// {@endtemplate}
class MapCarrouselCubit extends Cubit<MapCarrouselState> {
  /// {@macro map_carrousel_cubit}
  MapCarrouselCubit() : super(const MapCarrouselInitialState());

  /// Initializes the cubit by loading the relevant geojson files.
  Future<void> init() async {
    emit(const MapCarrouselLoadingState());
    final int currentDay = raceDayFromDate(DateTime.now());
    // final Map<int, GeoJsonParser> parsers = <int, GeoJsonParser>{};
    if (currentDay < 0) {
      final String geoJson = await rootBundle.loadString(
        Assets.geojson.solarRace24,
      );
      final GeoJsonParser globalParser = GeoJsonParser()
        ..parseGeoJsonAsString(geoJson);
      emit(MapCarrouselGlobalLoadedState(geoJsonParser: globalParser));
      return;
    }
    // TODO(Floyd): Implement for when the race is happening.
  }
}

/// Returns the number of days offset from the start of the race.
///
/// If negative, the race has not started yet.
int raceDayFromDate(DateTime date) {
  return DateTime.now().difference(UiConstants.raceStart).inDays;
}
