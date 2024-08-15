import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../core.dart';
import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
import '../cubit/map_cubit.dart';
import '../cubit/map_state.dart';
import '../cubit/race_day_carousel_cubit.dart';
import 'solar_car_marker.dart';

class MapLoadedView extends StatefulWidget {
  const MapLoadedView({
    required this.geoJsonParser,
    super.key,
  });

  final GeoJsonParser geoJsonParser;

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
      builder: (BuildContext context, MapState mapState) {
        mapState as MapRaceLoaded;
        return BlocListener<RaceDayCarouselCubit, RaceDayCarouselState>(
          listenWhen: (previous, current) {
            return previous.selectedRaceDay != current.selectedRaceDay;
          },
          listener: (BuildContext context, RaceDayCarouselState state) {
            if (state.selectedRaceDay == RaceDayType.prep) {
              _animatedMapController.animateTo(
                dest: mapState.vehicleLocation.coordinates,
                zoom: _defaultZoom,
              );
              return;
            }
            final GeoJsonParser parser = GeoJsonParser();
            if (state.selectedRaceDay == RaceDayType.allDays ||
                state.selectedRaceDay == RaceDayType.day8) {
              parser.parseGeoJsonAsString(state.fullRaceGeoJson);
            } else {
              parser.parseGeoJsonAsString(
                state.allRaceDaysGeoJson[state.selectedRaceDay.index],
              );
            }
            _animatedMapController.animatedFitCamera(
              cameraFit: CameraFit.coordinates(
                maxZoom: state.selectedRaceDay == RaceDayType.allDays ? 5.5 : 7,
                coordinates: <LatLng>[
                  parser.markers.first.point,
                  parser.markers.last.point,
                ],
              ),
            );
          },
          child: FlutterMap(
            mapController: _animatedMapController.mapController,
            options: MapOptions(
              initialCenter: mapState.vehicleLocation.coordinates,
              initialZoom: _defaultZoom,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
            ),
            children: [
              Stack(
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
                    bottom: Sizes.defaultBottomSheetCornerRadius + Sizes.s16,
                    right: Sizes.s16,
                    child: _LiveButton(
                      onPressed: () async {
                        context
                            .read<RaceDayCarouselCubit>()
                            .selectCurrentRaceDay();
                        _animatedMapController.animateTo(
                          dest: mapState.vehicleLocation.coordinates,
                          zoom: _defaultZoom,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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
