import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_map_geojson2/geojson2/geojson_layer.dart';
import 'package:latlong2/latlong.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../constants/sizes_constants.dart';
import '../cubit/map_cubit.dart';
import '../cubit/map_state.dart';
import 'solar_car_marker.dart';

class MapLoadedView extends StatefulWidget {
  const MapLoadedView({super.key});

  @override
  State<MapLoadedView> createState() => _MapLoadedViewState();
}

class _MapLoadedViewState extends State<MapLoadedView> with TickerProviderStateMixin {
  static const double _defaultZoom = 12;
  late final AnimatedMapController _animatedMapController;

  @override
  void initState() {
    super.initState();
    _animatedMapController = AnimatedMapController(
      vsync: this,
      curve: Curves.ease,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _animatedMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      listenWhen: (MapState previous, MapState current) {
        return (previous is! MapRaceLoaded && current is MapRaceLoaded) ||
            ((previous is MapRaceLoaded && current is MapRaceLoaded) &&
                previous.vehicleLocation != current.vehicleLocation);
      },
      listener: (BuildContext context, MapState state) async {
        if (state is! MapRaceLoaded) {
          return;
        }

        if (state.vehicleLocation.coordinates != const LatLng(26.2041, 28.0473)) {
          await _animatedMapController.animateTo(dest: state.vehicleLocation.coordinates, zoom: _defaultZoom);
        }
      },
      builder: (BuildContext context, MapState mapState) {
        return FlutterMap(
          mapController: _animatedMapController.mapController,
          options: MapOptions(
            initialCenter: mapState.vehicleLocation.coordinates,
            initialZoom: _defaultZoom,
            interactionOptions: const InteractionOptions(flags: InteractiveFlag.all & ~InteractiveFlag.rotate),
          ),
          children: <Widget>[
            TileLayer(
              tileProvider: CancellableNetworkTileProvider(),
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            MarkerLayer(
              alignment: Alignment.topCenter,
              markers: <Marker>[
                Marker(
                  width: 80,
                  height: 80,
                  point: mapState.vehicleLocation.coordinates,
                  child: const SolarCarMarker(),
                ),
              ],
            ),
            const Positioned(
              bottom: Sizes.defaultBottomSheetCornerRadius + Sizes.s16,
              right: Sizes.s16,
              child: _LiveButton(),
            ),
            GeoJsonLayer.asset(Assets.geojson.linestring),
          ],
        );
      },
    );
  }
}

class _LiveButton extends StatelessWidget {
  const _LiveButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () {}, // TODO(triqoz): Should this still do something?
      icon: const Icon(Icons.my_location_rounded),
      label: const Text('Live'),
    );
  }
}
