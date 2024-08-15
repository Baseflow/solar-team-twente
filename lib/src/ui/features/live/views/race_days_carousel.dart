import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core.dart';
import '../cubit/race_day_carousel_cubit.dart';
import 'count_down_view.dart';
import 'race_day_view.dart';

class RaceDaysCarousel extends StatelessWidget {
  const RaceDaysCarousel({super.key});

  static final bool _hasRaceStarted = Constants.hasRaceStarted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child:
          BlocSelector<RaceDayCarouselCubit, RaceDayCarouselState, RaceDayType>(
        selector: (RaceDayCarouselState state) => state.currentRaceDay,
        builder: (BuildContext context, RaceDayType currentRaceDay) {
          return PageView(
            onPageChanged: context.read<RaceDayCarouselCubit>().selectRaceDay,
            children: <Widget>[
              if (!_hasRaceStarted) const CountDownView(),
              ...List<RaceDayView>.generate(
                RaceDayType.values.length - 1,
                (int index) {
                  final int raceDayIndex = index + 1;
                  return RaceDayView(
                    showPreviousRace: raceDayIndex > 1 || !_hasRaceStarted,
                    showNextRace: raceDayIndex < RaceDayType.values.length - 1,
                    isCurrentRaceDone:
                        currentRaceDay.index > raceDayIndex && _hasRaceStarted,
                    isPreviousRaceDone:
                        currentRaceDay.index >= raceDayIndex && _hasRaceStarted,
                    isNextRaceDone:
                        raceDayIndex < currentRaceDay.index && _hasRaceStarted,
                    showCurrentRace:
                        raceDayIndex != RaceDayType.values.last.index,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
