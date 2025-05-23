import 'dart:async';
import 'dart:convert';

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

  Future<void> loadMap() async {
    final String jsonString = await rootBundle.loadString(Assets.geojson.fullMap);
    final Map<String, dynamic> json = jsonDecode(jsonString) as Map<String, dynamic>;

    final GeoJsonParser geoJson = GeoJsonParser()..parseGeoJson(json);

    await Future<void>.delayed(const Duration(seconds: 2));

    emit(MapRaceLoaded(vehicleLocation: const VehicleLocation.initial(), geoJson: geoJson));

    _subscribeToVehicleLocation();
  }

  /// Subscribes to the stream of the vehicle location.
  void _subscribeToVehicleLocation() {
    _vehicleLocationSubscription = _service.vehicleLocation.listen(
      (VehicleLocation vehicleLocation) {
        emit(state.copyWith(vehicleLocation: vehicleLocation));
      },
      onError: (_) {
        emit((state as MapRaceLoaded).copyWith(vehicleLocation: const VehicleLocation.initial()));
      },
    );
  }
}
