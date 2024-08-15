import 'dart:async';

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
  MapCubit(this._service) : super(const MapInitial());

  final VehicleLocationService _service;

  late StreamSubscription<VehicleLocation> _vehicleLocationSubscription;

  @override
  Future<void> close() {
    _vehicleLocationSubscription.cancel();
    return super.close();
  }

  /// Initializes the cubit by loading the relevant geo json files.
  Future<void> started() async {
    emit(const MapLoading());
    final String geoJson = await rootBundle.loadString(Assets.geojson.fullMap);
    final GeoJsonParser globalParser = GeoJsonParser()
      ..parseGeoJsonAsString(geoJson);
    emit(
      MapRaceLoaded(
        geoJsonParser: globalParser,
        vehicleLocation: const VehicleLocation.initial(),
      ),
    );
    _subscribeToVehicleLocation();
  }

  /// Subscribes to the stream of the vehicle location.
  void _subscribeToVehicleLocation() {
    assert(state is MapRaceLoaded, 'State must be MapRaceLoaded');

    _vehicleLocationSubscription = _service.vehicleLocation.listen(
      (VehicleLocation vehicleLocation) {
        final MapRaceLoaded mapRaceLoaded = state as MapRaceLoaded;
        emit(mapRaceLoaded.copyWith(vehicleLocation: vehicleLocation));
      },
      onError: (_) {
        emit(
          (state as MapRaceLoaded).copyWith(
            vehicleLocation: const VehicleLocation.initial(),
          ),
        );
      },
    );
  }
}
