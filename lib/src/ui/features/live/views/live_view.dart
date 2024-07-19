import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:latlong2/latlong.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../extensions/build_context_extensions.dart';
import '../cubit/map_carrousel_cubit.dart';
import '../cubit/map_carrousel_state.dart';

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
        ),
      ),
      body: BlocBuilder<MapCarrouselCubit, MapCarrouselState>(
        builder: (BuildContext _, MapCarrouselState state) {
          return switch (state) {
            final MapCarrouselInitialState _ ||
            final MapCarrouselLoadingState _ =>
              const Center(child: CircularProgressIndicator()),
            final MapCarrouselRaceLoadedState _ => _FlutterMap(
                geoJsonParser: state.geoJsonParser,
              ),
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

  void _animateMap(int index) {
    final List<LatLngBounds> bounds = <LatLngBounds>[
      LatLngBounds(
        const LatLng(-27.318422, 27.824081),
        const LatLng(-26.320134, 29.18415),
      ),
      LatLngBounds(
        const LatLng(-26.8903773, 26.082086),
        const LatLng(-25.517609, 27.831684),
      ),
      LatLngBounds(
        const LatLng(-27.471608, 23.402627),
        const LatLng(-25.541249, 26.082988),
      ),
      LatLngBounds(
        const LatLng(-28.769597, 20.341723),
        const LatLng(-27.471124, 23.402675),
      ),
      LatLngBounds(
        const LatLng(-29.662415, 17.887869),
        const LatLng(-28.623128, 20.534983),
      ),
      LatLngBounds(
        const LatLng(-31.748007, 17.833363),
        const LatLng(-29.661212, 18.730951),
      ),
      LatLngBounds(
        const LatLng(-33.380566, 18.340278),
        const LatLng(-31.559386, 18.899053),
      ),
      LatLngBounds(
        const LatLng(-34.026167, 18.422593),
        const LatLng(-33.300209, 19.49382),
      ),
    ];

    // Make sure the index is within bounds
    if (index >= 0 && index < bounds.length) {
      _animatedMapController.animatedFitCamera(
        cameraFit: CameraFit.bounds(bounds: bounds[index]),
      );
    }
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
          child: MultiBlocListener(
            listeners: <BlocListener<MapCarrouselCubit, MapCarrouselState>>[
              BlocListener<MapCarrouselCubit, MapCarrouselState>(
                listenWhen: (
                  MapCarrouselState previous,
                  MapCarrouselState current,
                ) {
                  return previous is MapCarrouselRaceLoadedState &&
                      current is MapCarrouselRaceLoadedState;
                },
                listener: (BuildContext context, MapCarrouselState state) {
                  final int index =
                      (state as MapCarrouselRaceLoadedState).currentParserIndex;
                  _animateMap(index);
                },
              ),
            ],
            child: FlutterMap(
              mapController: _animatedMapController.mapController,
              options: const MapOptions(
                initialCenter: LatLng(-27.226321, 24.013543),
                initialZoom: 5.2,
              ),
              children: <Widget>[
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                PolylineLayer<Object>(
                  polylines: <Polyline<Object>>[
                    Polyline<Object>(
                      points: markerPoints,
                      color: Colors.black,
                      strokeWidth: 2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const _FlutterMapCarrousel(),
      ],
    );
  }
}

class _FlutterMapCarrousel extends StatelessWidget {
  const _FlutterMapCarrousel();

  @override
  Widget build(BuildContext context) {
    // Left and right buttons to navigate the carousel
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.read<MapCarrouselCubit>().previous(),
          ),
          BlocBuilder<MapCarrouselCubit, MapCarrouselState>(
            builder: (BuildContext _, MapCarrouselState state) {
              if (state is! MapCarrouselRaceLoadedState) {
                return const SizedBox();
              }
              final int index = state.currentParserIndex;
              return Text('Day ${index + 1}');
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () => context.read<MapCarrouselCubit>().next(),
          ),
        ],
      ),
    );
  }
}
