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

  /// Subscribes to the stream of the vehicle location.
  void _subscribeToVehicleLocation() {
    _vehicleLocationSubscription = _service.vehicleLocation.listen(
      (VehicleLocation vehicleLocation) {
        emit(state.copyWith(vehicleLocation: vehicleLocation));
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

  Future<void> loadAssets() async {
    final List<dynamic> combinedRaceDays = <dynamic>[];
    final List<GeoJsonParser> allRaceDaysGeoJson = <GeoJsonParser>[];
    for (int i = 0; i < Assets.geojson.values.length - 1; i++) {
      final String jsonString = await rootBundle.loadString(
        Assets.geojson.values[i],
      );
      final Map<String, dynamic> json =
          jsonDecode(jsonString) as Map<String, dynamic>;
      allRaceDaysGeoJson.add(GeoJsonParser()..parseGeoJson(json));
      for (final dynamic feature in json['features'] as List<dynamic>) {
        combinedRaceDays.add(feature);
      }
    }

    final Map<String, dynamic> combinedGeoJson = <String, dynamic>{
      'type': 'FeatureCollection',
      'features': combinedRaceDays,
    };

    final GeoJsonParser geoJson = GeoJsonParser()
      ..parseGeoJson(combinedGeoJson);
    allRaceDaysGeoJson.add(geoJson);

    final bool hasRaceStarted =
        Constants.startDate.difference(DateTime.now()).inMinutes < 0;
    final int daysSinceStart =
        DateTime.now().difference(Constants.startDate).inDays;

    emit(
      MapRaceLoaded(
        vehicleLocation: const VehicleLocation.initial(),
        allRaceDaysGeoJson: allRaceDaysGeoJson,
        selectedRaceDayGeoJson: hasRaceStarted
            ? allRaceDaysGeoJson[daysSinceStart + 1]
            : allRaceDaysGeoJson[0],
      ),
    );
    _subscribeToVehicleLocation();
  }

  void loadSelectedDay(int index) {
    int selectedRaceDayIndex = Constants.hasRaceStarted ? index + 1 : index;
    if (Constants.hasRaceStarted && index == 0) {
      selectedRaceDayIndex = state.allRaceDaysGeoJson.length - 1;
    }

    emit(
      state.copyWith(
        selectedRaceDayGeoJson: state.allRaceDaysGeoJson[selectedRaceDayIndex],
      ),
    );
  }
}
