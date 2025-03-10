part of 'race_day_carousel_cubit.dart';

sealed class RaceDayCarouselState extends Equatable {
  const RaceDayCarouselState({
    required this.currentRaceDay,
    required this.selectedRaceDay,
  });

  final RaceDayType selectedRaceDay;
  final RaceDayType currentRaceDay;

  bool get hasRaceStarted;

  RaceDayCarouselState copyWith({
    RaceDayType? selectedRaceDay,
    RaceDayType? currentRaceDay,
  });
}

final class RaceDayCarouselLoaded extends RaceDayCarouselState {
  const RaceDayCarouselLoaded({
    required super.currentRaceDay,
    super.selectedRaceDay = RaceDayType.prep,
  });

  @override
  bool get hasRaceStarted => currentRaceDay != RaceDayType.prep;

  @override
  List<Object> get props => <Object>[currentRaceDay, selectedRaceDay];

  @override
  RaceDayCarouselState copyWith({
    RaceDayType? selectedRaceDay,
    RaceDayType? currentRaceDay,
  }) {
    return RaceDayCarouselLoaded(
      currentRaceDay: currentRaceDay ?? this.currentRaceDay,
      selectedRaceDay: selectedRaceDay ?? this.selectedRaceDay,
    );
  }
}
