import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';

import '../../../../../core.dart';
import '../../../../assets/generated/assets.gen.dart';
import 'map_state.dart';

/// {@template map_carrousel_cubit}
/// Manages the state of the map carrousel.
/// {@endtemplate}
class MapCubit extends Cubit<MapState> {
  MapCubit(this._service) : super(MapInitial());
  final VehicleLocationService _service;

  /// Initializes the cubit by loading the relevant geo json files.
  Future<void> started() async {
    emit(const MapLoading());
    final Future<String> geoJsonFuture =
        rootBundle.loadString(Assets.geojson.fullMap);
    final Future<VehicleLocation> vehicleLocationFuture =
        _service.getVehicleLocation();
    final List<Object> results = await Future.wait<Object>(<Future<Object>>[
      geoJsonFuture,
      vehicleLocationFuture,
    ]);
    final String geoJson = results[0] as String;
    final VehicleLocation vehicleLocation = results[1] as VehicleLocation;
    final GeoJsonParser globalParser = GeoJsonParser()
      ..parseGeoJsonAsString(geoJson);
    emit(
      MapRaceLoaded(
        geoJsonParser: globalParser,
        vehicleLocation: vehicleLocation,
      ),
    );
    return;
  }

  Future<void> onRefreshButtonPressed() async {
    assert(state is MapRaceLoaded);
    final MapRaceLoaded mapRaceLoaded = state as MapRaceLoaded;
    emit(const MapLoading());
    final VehicleLocation vehicleLocation = await _service.getVehicleLocation();
    emit(mapRaceLoaded.copyWith(vehicleLocation: vehicleLocation));
  }
}
