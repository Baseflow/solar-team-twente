import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core.dart';
import '../../../../assets/generated/assets.gen.dart';

part 'race_day_carousel_state.dart';

class RaceDayCarouselCubit extends Cubit<RaceDayCarouselState> {
  RaceDayCarouselCubit({
    required RaceDayType currentRaceDay,
    required RaceDayType selectedRaceDay,
  }) : super(
          RaceDayCarouselInitial(
            currentRaceDay: currentRaceDay,
            selectedRaceDay: selectedRaceDay,
          ),
        );

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

    final bool hasRaceStarted =
        Constants.startDate.difference(DateTime.now()).inMinutes < 0;
    final int daysSinceStart =
        DateTime.now().difference(Constants.startDate).inDays;

    emit(
      RaceDayCarouselLoaded(
        allRaceDaysGeoJson: allRaceDaysGeoJson,
        fullRaceGeoJson: fullRaceGeoJson,
        selectedRaceDay: hasRaceStarted ? RaceDayType.day1 : RaceDayType.prep,
        currentRaceDay: hasRaceStarted
            ? RaceDayType.values[daysSinceStart + 1]
            : RaceDayType.prep,
      ),
    );
  }

  void selectRaceDay(int index) {
    final RaceDayType selectedRaceDay = Constants.hasRaceStarted
        ? RaceDayType.values[index + 1]
        : RaceDayType.values[index];
    emit(
      state.copyWith(
        selectedRaceDay: selectedRaceDay,
      ),
    );
  }
}
