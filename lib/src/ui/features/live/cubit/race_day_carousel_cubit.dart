import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/generated/assets.gen.dart';

part 'race_day_carousel_state.dart';

class RaceDayCarouselCubit extends Cubit<RaceDayCarouselState> {
  RaceDayCarouselCubit() : super(const RaceDayCarouselInitial());

  Future<void> loadAssets() async {
    final List<String> allRaceDaysGeoJson = <String>[];
    for (int i = 0; i < Assets.geojson.values.length - 1; i++) {
      allRaceDaysGeoJson.add(
        await rootBundle.loadString(Assets.geojson.values[i]),
      );
    }
    final String fullRaceGeoJson = await rootBundle.loadString(
      Assets.geojson.fullMap,
    );

    emit(RaceDayCarouselLoaded(
      allRaceDaysGeoJson: allRaceDaysGeoJson,
      fullRaceGeoJson: fullRaceGeoJson,
    ));
  }
}
