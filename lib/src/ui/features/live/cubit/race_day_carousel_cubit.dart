import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core.dart';

part 'race_day_carousel_state.dart';

class RaceDayCarouselCubit extends Cubit<RaceDayCarouselState> {
  RaceDayCarouselCubit({
    required RaceDayType currentRaceDay,
    required RaceDayType selectedRaceDay,
  }) : super(
          RaceDayCarouselLoaded(
            currentRaceDay: currentRaceDay,
            selectedRaceDay: selectedRaceDay,
          ),
        );

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

  void selectCurrentRaceDay() {
    emit(
      state.copyWith(
        selectedRaceDay: state.currentRaceDay,
      ),
    );
  }
}
