import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core.dart';
import 'vehicle_location_state.dart';

class VehicleLocationCubit extends Cubit<VehicleLocationState> {
  VehicleLocationCubit(this._service) : super(VehicleLocationInitial());
  final VehicleLocationService _service;

  Future<void> fetchVehicleLocations() async {
    emit(VehicleLocationLoading());
    final VehicleLocation locations =
        await _service.getVehicleLocation();
    emit(VehicleLocationLoaded(locations));
  }
}
