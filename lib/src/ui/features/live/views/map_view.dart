import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
import '../cubit/map_cubit.dart';
import '../cubit/map_state.dart';

class MapView extends StatefulWidget {
  const MapView({
    required this.geoJsonParser,
    super.key,
  });

  final GeoJsonParser geoJsonParser;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> with TickerProviderStateMixin {
  static const double _defaultZoom = 8.2;
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
    final List<LatLng> markerPoints = widget.geoJsonParser.markers
        .map((Marker marker) => marker.point)
        .toList();
    return BlocConsumer<MapCubit, MapState>(
      listenWhen: (MapState previous, MapState current) {
        return (previous is! MapRaceLoaded && current is MapRaceLoaded) ||
            ((previous is MapRaceLoaded && current is MapRaceLoaded) &&
                previous.vehicleLocation != current.vehicleLocation);
      },
      listener: (BuildContext context, MapState state) {
        if (state is! MapRaceLoaded) {
          return;
        }

        _animatedMapController.animateTo(
          dest: state.vehicleLocation.coordinates,
          zoom: _defaultZoom,
        );
      },
      builder: (BuildContext context, MapState state) {
        state as MapRaceLoaded;
        return FlutterMap(
          mapController: _animatedMapController.mapController,
          options: MapOptions(
            initialCenter: state.vehicleLocation.coordinates,
            initialZoom: _defaultZoom,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
          ),
          children: <Widget>[
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            MarkerLayer(
              markers: <Marker>[
                Marker(
                  width: 80,
                  height: 80,
                  point: state.vehicleLocation.coordinates,
                  child: SvgPicture.asset(
                    Assets.icons.solarCarIcon,
                    semanticsLabel: 'Solarteam Car',
                  ),
                ),
              ],
            ),
            PolylineLayer<Object>(
              polylines: <Polyline<Object>>[
                Polyline<Object>(
                  points: markerPoints,
                  color: context.colorScheme.primary,
                  strokeWidth: 3,
                ),
              ],
            ),
            Positioned(
              bottom: Sizes.s8,
              right: Sizes.s16,
              child: FilledButton.icon(
                onPressed: () {
                  _animatedMapController.animateTo(
                    dest: state.vehicleLocation.coordinates,
                    zoom: _defaultZoom,
                  );
                },
                icon: const Icon(Icons.my_location_rounded),
                label: const Text('Live'),
              ),
            ),
          ],
        );
      },
    );
  }
}
