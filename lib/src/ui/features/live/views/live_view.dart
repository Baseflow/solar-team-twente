import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../extensions/build_context_extensions.dart';
import '../cubit/map_cubit.dart';
import '../cubit/map_state.dart';

/// {@template live_view}
/// The UI for the live page, displaying the most important information
/// during the event, like the location of the vehicle, the speed,
/// battery level, etc.
/// {@endtemplate}
class LiveView extends StatelessWidget {
  /// {@macro live_view}
  const LiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          context.isDarkMode ? Assets.dark.logo.path : Assets.light.logo.path,
          fit: BoxFit.fitHeight,
          height: 64,
          semanticLabel: 'Solarteam Logo',
        ),
      ),
      body: BlocBuilder<MapCubit, MapState>(
        builder: (BuildContext _, MapState state) {
          return switch (state) {
            final MapInitial _ ||
            final MapLoading _ =>
              const Center(child: CircularProgressIndicator()),
            final MapRaceLoaded _ =>
              _FlutterMap(geoJsonParser: state.geoJsonParser),
          };
        },
      ),
    );
  }
}

class _FlutterMap extends StatefulWidget {
  const _FlutterMap({required this.geoJsonParser});

  final GeoJsonParser geoJsonParser;

  @override
  State<_FlutterMap> createState() => _FlutterMapState();
}

class _FlutterMapState extends State<_FlutterMap>
    with TickerProviderStateMixin {
  late final AnimatedMapController _animatedMapController;
  late final PageController _pageController;

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
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<LatLng> markerPoints = widget.geoJsonParser.markers
        .map((Marker marker) => marker.point)
        .toList();
    return Column(
      children: <Widget>[
        Flexible(
          child: BlocConsumer<MapCubit, MapState>(
            listenWhen: (previous, current) {
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
              );
            },
            builder: (BuildContext context, MapState state) => FlutterMap(
              mapController: _animatedMapController.mapController,
              options: MapOptions(
                initialCenter:
                    (state as MapRaceLoaded).vehicleLocation.coordinates,
                initialZoom: 8.2,
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
