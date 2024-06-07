import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:latlong2/latlong.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../extensions/build_context_extensions.dart';

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
      body: FutureBuilder<String>(
        future: rootBundle.loadString(Assets.geojson.solarRace24),
        builder: (BuildContext context, AsyncSnapshot<String> snapShot) {
          final GeoJsonParser myGeoJson = GeoJsonParser()
            ..parseGeoJsonAsString(
              snapShot.data ?? '',
            );
          return FlutterMap(
            mapController: MapController(),
            options: const MapOptions(
              // set initial center to center of tsabong
              initialCenter: LatLng(-27.226321, 24.013543),
              initialZoom: 5,
            ),
            children: <Widget>[
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              PolygonLayer(polygons: myGeoJson.polygons),
              PolylineLayer(polylines: myGeoJson.polylines),
              MarkerLayer(
                markers: myGeoJson.markers.map((Marker marker) {
                  return Marker(
                    width: 2,
                    height: 2,
                    point: marker.point,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}
