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

    final String geoJson = await rootBundle.loadString(
      Assets.geojson.solarRace24,
    );
    final GeoJsonParser globalParser = GeoJsonParser()
      ..parseGeoJsonAsString(geoJson);
    emit(
      MapCarrouselRaceLoadedState(
        geoJsonParser: globalParser,
        currentParserIndex: currentDay,
      ),
    );
    return;

    // TODO(Floyd): Implement for when the race is happening.
  }

  void previous() {
    assert(state is MapCarrouselRaceLoadedState, 'State is not loaded');
    final MapCarrouselRaceLoadedState loadedState =
        state as MapCarrouselRaceLoadedState;
    final int previousDay = loadedState.currentParserIndex - 1;
    if (previousDay < 0) {
      return;
    }
    emit(
      loadedState.copyWith(
        currentParserIndex: previousDay,
        geoJsonParser: loadedState.geoJsonParsers[previousDay],
      ),
    );
  }

  void next() {
    assert(state is MapCarrouselRaceLoadedState, 'State is not loaded');
    final MapCarrouselRaceLoadedState loadedState =
    state as MapCarrouselRaceLoadedState;
    final int nextDay = loadedState.currentParserIndex + 1;
    if (nextDay > 7) {
      return;
    }
    emit(
      loadedState.copyWith(
        currentParserIndex: nextDay,
        geoJsonParser: loadedState.geoJsonParsers[nextDay],
      ),
    );
  }
}

/// Returns the number of days offset from the start of the race.
///
/// If negative, the race has not started yet.
int raceDayFromDate(DateTime date) {
  return DateTime.now().difference(UiConstants.raceStart).inDays;
}
