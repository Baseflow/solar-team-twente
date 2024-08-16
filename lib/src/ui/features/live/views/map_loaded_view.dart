import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../core.dart';
import '../../../constants/sizes_constants.dart';
import '../cubit/map_cubit.dart';
import '../cubit/map_state.dart';
import '../cubit/race_day_carousel_cubit.dart';
import 'solar_car_marker.dart';

class MapLoadedView extends StatefulWidget {
  const MapLoadedView({super.key});

  @override
  State<MapLoadedView> createState() => _MapLoadedViewState();
}

class _MapLoadedViewState extends State<MapLoadedView>
    with TickerProviderStateMixin {
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

        await _animatedMapController.animateTo(
          dest: state.vehicleLocation.coordinates,
          zoom: _defaultZoom,
        );
      },
      builder: (BuildContext context, MapState mapState) {
        mapState as MapRaceLoaded;
        return BlocListener<RaceDayCarouselCubit, RaceDayCarouselState>(
          listenWhen: (
            RaceDayCarouselState previous,
            RaceDayCarouselState current,
          ) {
            return previous.selectedRaceDay != current.selectedRaceDay;
          },
          listener: (BuildContext context, RaceDayCarouselState state) async {
            await _animateToSection(
              state,
              mapState.vehicleLocation.coordinates,
            );
          },
          child: BlocBuilder<RaceDayCarouselCubit, RaceDayCarouselState>(
            buildWhen: (_, RaceDayCarouselState current) {
              return current is RaceDayCarouselLoaded;
            },
            builder: (
              BuildContext context,
              RaceDayCarouselState carouselState,
            ) {
              final geoJsonString =
                  carouselState.selectedRaceDay == RaceDayType.allDays ||
                          carouselState.selectedRaceDay == RaceDayType.prep
                      ? carouselState.fullRaceGeoJson
                      : carouselState.allRaceDaysGeoJson[
                          carouselState.selectedRaceDay.index - 1];
              final GeoJsonParser geoJson = GeoJsonParser()
                ..parseGeoJsonAsString(geoJsonString);
              return FlutterMap(
                mapController: _animatedMapController.mapController,
                options: MapOptions(
                  initialCenter: mapState.vehicleLocation.coordinates,
                  initialZoom: _defaultZoom,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                  ),
                ),
                children: <Widget>[
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                    markers: <Marker>[
                      Marker(
                        width: 80,
                        height: 80,
                        point: mapState.vehicleLocation.coordinates,
                        child: const SolarCarMarker(),
                      ),
                      ...geoJson.markers,
                    ],
                  ),
                  PolygonLayer<Object>(
                    polygons: geoJson.polygons,
                  ),
                  PolylineLayer<Object>(
                    polylines: geoJson.polylines,
                  ),
                  Positioned(
                    bottom: Sizes.defaultBottomSheetCornerRadius + Sizes.s16,
                    right: Sizes.s16,
                    child: _LiveButton(
                      onPressed: () async {
                        context
                            .read<RaceDayCarouselCubit>()
                            .selectCurrentRaceDay();
                        await _animatedMapController.animateTo(
                          dest: mapState.vehicleLocation.coordinates,
                          zoom: _defaultZoom,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _animateToSection(
    RaceDayCarouselState state,
    LatLng vehicleLocation,
  ) async {
    if (state.selectedRaceDay == RaceDayType.prep) {
      await _animatedMapController.animateTo(
        dest: vehicleLocation,
        zoom: _defaultZoom,
      );
      return;
    }
    final GeoJsonParser parser = GeoJsonParser();
    if (state.selectedRaceDay == RaceDayType.allDays) {
      parser.parseGeoJsonAsString(state.fullRaceGeoJson);
    } else {
      parser.parseGeoJsonAsString(
        state.allRaceDaysGeoJson[state.selectedRaceDay.index - 1],
      );
    }
    await _animatedMapController.animatedFitCamera(
      cameraFit: CameraFit.coordinates(
        maxZoom: state.selectedRaceDay == RaceDayType.allDays ? 5.5 : 7,
        coordinates: <LatLng>[
          parser.markers.first.point,
          parser.markers.last.point,
        ],
      ),
    );
  }
}

class _LiveButton extends StatelessWidget {
  const _LiveButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.my_location_rounded),
      label: const Text('Live'),
    );
  }
}
