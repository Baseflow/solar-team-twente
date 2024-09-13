import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../core.dart';
import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
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

        if (state.vehicleLocation.coordinates !=
            const LatLng(26.2041, 28.0473)) {
          await _animatedMapController.animateTo(
            dest: state.vehicleLocation.coordinates,
            zoom: _defaultZoom,
          );
        }
      },
      builder: (BuildContext context, MapState mapState) {
        mapState as MapRaceLoaded;
        return BlocConsumer<RaceDayCarouselCubit, RaceDayCarouselState>(
          listenWhen: (
            RaceDayCarouselState previous,
            RaceDayCarouselState current,
          ) {
            return previous.selectedRaceDay != current.selectedRaceDay;
          },
          listener:
              (BuildContext context, RaceDayCarouselState carouselState) async {
            if (carouselState.selectedRaceDay.index > 0) {
              context
                  .read<MapCubit>()
                  .loadSelectedDay(carouselState.selectedRaceDay.index - 1);
            }
            await _animateToSection(
              mapState.selectedRaceDayGeoJson!.markers,
              mapState.vehicleLocation.coordinates,
              carouselState.selectedRaceDay,
              carouselState.currentRaceDay,
            );
          },
          builder: (
            BuildContext context,
            RaceDayCarouselState carouselState,
          ) {
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
                    if (carouselState.selectedRaceDay == RaceDayType.prep ||
                        carouselState.selectedRaceDay == RaceDayType.allDays)
                      ...mapState.selectedRaceDayGeoJson!.markers.map<Marker>(
                        (Marker marker) => Marker(
                          point: marker.point,
                          height: 2,
                          width: 2,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ColoredBox(
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ),
                      )
                    else
                      ...mapState.selectedRaceDayGeoJson!.markers,
                  ],
                ),
                PolygonLayer<Object>(
                  polygons: mapState.selectedRaceDayGeoJson!.polygons,
                ),
                PolylineLayer<Object>(
                  polylines: mapState.selectedRaceDayGeoJson!.polylines,
                ),
                const Positioned(
                  bottom: Sizes.defaultBottomSheetCornerRadius + Sizes.s16,
                  right: Sizes.s16,
                  child: _LiveButton(),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _animateToSection(
    List<Marker> markers,
    LatLng vehicleLocation,
    RaceDayType selectedRaceDay,
    RaceDayType currentRaceDay,
  ) async {
    if (selectedRaceDay == currentRaceDay) {
      await _animatedMapController.animateTo(
        dest: vehicleLocation,
        zoom: _defaultZoom,
      );
      return;
    }
    final double maxZoom = selectedRaceDay == RaceDayType.allDays ? 4 : 5.5;
    await _animatedMapController.animatedFitCamera(
      cameraFit: CameraFit.insideBounds(
        bounds: LatLngBounds.fromPoints(
          markers.map((Marker marker) => marker.point).toList(),
        ),
        maxZoom: maxZoom,
      ),
    );
  }
}

class _LiveButton extends StatelessWidget {
  const _LiveButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: context.read<RaceDayCarouselCubit>().selectCurrentRaceDay,
      icon: const Icon(Icons.my_location_rounded),
      label: const Text('Live'),
    );
  }
}
