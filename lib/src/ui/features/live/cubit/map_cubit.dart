import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core.dart';
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
    emit(const MapRaceLoaded(vehicleLocation: VehicleLocation.initial()));

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
