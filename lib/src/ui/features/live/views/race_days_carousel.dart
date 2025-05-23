import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core.dart';
import '../cubit/race_day_carousel_cubit.dart';
import 'count_down_view.dart';
import 'race_day_view.dart';

class RaceDaysCarousel extends StatefulWidget {
  const RaceDaysCarousel({super.key});

  static final bool _hasRaceStarted = Constants.hasRaceStarted;

  @override
  State<RaceDaysCarousel> createState() => _RaceDaysCarouselState();
}

class _RaceDaysCarouselState extends State<RaceDaysCarousel> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    final int daysSinceStart = DateTime.now().difference(Constants.startDate).inDays;
    _pageController = PageController(initialPage: daysSinceStart);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: BlocSelector<RaceDayCarouselCubit, RaceDayCarouselState, RaceDayType>(
        selector: (RaceDayCarouselState state) => state.currentRaceDay,
        builder: (BuildContext context, RaceDayType currentRaceDay) {
          return BlocListener<RaceDayCarouselCubit, RaceDayCarouselState>(
            listenWhen: (RaceDayCarouselState previous, RaceDayCarouselState current) {
              final double currentPageIndex = _pageController.page ?? 0;
              return previous.selectedRaceDay != current.selectedRaceDay &&
                  currentPageIndex == currentPageIndex.round() &&
                  currentPageIndex != current.currentRaceDay.index - 1;
            },
            listener: (BuildContext context, RaceDayCarouselState state) {
              final double currentPageIndex = _pageController.page ?? 0;
              if (currentPageIndex == currentPageIndex.round()) {
                _pageController.animateToPage(
                  state.selectedRaceDay.index - 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.bounceInOut,
                );
              }
            },
            child: PageView(
              controller: _pageController,
              onPageChanged: context.read<RaceDayCarouselCubit>().selectRaceDay,
              children: <Widget>[
                if (!RaceDaysCarousel._hasRaceStarted) const CountDownView(),
                ...List<RaceDayView>.generate(RaceDayType.values.length - 1, (int index) {
                  final int raceDayIndex = index + 1;
                  return RaceDayView(
                    showPreviousRace: raceDayIndex > 1 || !RaceDaysCarousel._hasRaceStarted,
                    showNextRace: raceDayIndex < RaceDayType.values.length - 1,
                    isCurrentRaceDone: currentRaceDay.index > raceDayIndex && RaceDaysCarousel._hasRaceStarted,
                    isPreviousRaceDone: currentRaceDay.index >= raceDayIndex && RaceDaysCarousel._hasRaceStarted,
                    isNextRaceDone: raceDayIndex < currentRaceDay.index && RaceDaysCarousel._hasRaceStarted,
                    showCurrentRace: raceDayIndex != RaceDayType.values.last.index,
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
