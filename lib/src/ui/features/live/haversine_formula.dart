import 'package:latlong2/latlong.dart';

/// This [HaversineFormula] class extends the already existing [Haversine] class
/// to calculate distances between multiple points.
class HaversineFormula {
  /// Calculates the distance between all coordinates.
  ///
  /// The `coordinates` should be in the correct order.
  /// The function to calculate them will be taking the first two coordinates,
  /// calculating the distance between them. Then it will get the last
  /// coordinate and calculate the distance between that one and the next one.
  /// That distance will be added to the previous one. And so on until the end.
  double distanceBetweenAllCoordinates(List<LatLng> coordinatesList) {
    double currentDistance = 0;
    for (int i = 0; i < coordinatesList.length - 1; i++) {
      currentDistance += const Haversine()
          .distance(coordinatesList[i], coordinatesList[i + 1]);
    }
    return currentDistance;
  }
}
