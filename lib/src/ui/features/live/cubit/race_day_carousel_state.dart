part of 'race_day_carousel_cubit.dart';

sealed class RaceDayCarouselState extends Equatable {
  const RaceDayCarouselState({
    required this.currentRaceDay,
    required this.selectedRaceDay,
    this.allRaceDaysGeoJson = const <String>[],
    this.fullRaceGeoJson = '',
  });

  final List<String> allRaceDaysGeoJson;
  final String fullRaceGeoJson;
  final RaceDayType selectedRaceDay;
  final RaceDayType currentRaceDay;

  String get currentRaceDayGeoJson;
  bool get hasRaceStarted;

  RaceDayCarouselState copyWith({
    List<String>? allRaceDaysGeoJson,
    String? fullRaceGeoJson,
    RaceDayType? selectedRaceDay,
    RaceDayType? currentRaceDay,
  });
}

final class RaceDayCarouselInitial extends RaceDayCarouselState {
  const RaceDayCarouselInitial({
    required super.currentRaceDay,
    required super.selectedRaceDay,
  });

  @override
  List<Object> get props => <Object>[];

  @override
  String get currentRaceDayGeoJson => '';

  @override
  bool get hasRaceStarted => false;

  @override
  RaceDayCarouselState copyWith({
    List<String>? allRaceDaysGeoJson,
    String? fullRaceGeoJson,
    RaceDayType? selectedRaceDay,
    RaceDayType? currentRaceDay,
  }) {
    return RaceDayCarouselInitial(
      selectedRaceDay: selectedRaceDay ?? this.selectedRaceDay,
      currentRaceDay: currentRaceDay ?? this.currentRaceDay,
    );
  }
}

final class RaceDayCarouselLoaded extends RaceDayCarouselState {
  const RaceDayCarouselLoaded({
    required super.allRaceDaysGeoJson,
    required super.fullRaceGeoJson,
    required super.currentRaceDay,
    super.selectedRaceDay = RaceDayType.prep,
  });

  @override
  String get currentRaceDayGeoJson => allRaceDaysGeoJson[currentRaceDay.index];

  @override
  bool get hasRaceStarted => currentRaceDay != RaceDayType.prep;

  @override
  List<Object> get props => <Object>[
        allRaceDaysGeoJson,
        currentRaceDay,
        currentRaceDayGeoJson,
        fullRaceGeoJson,
        selectedRaceDay,
      ];

  @override
  RaceDayCarouselState copyWith({
    List<String>? allRaceDaysGeoJson,
    String? fullRaceGeoJson,
    RaceDayType? selectedRaceDay,
    RaceDayType? currentRaceDay,
  }) {
    return RaceDayCarouselLoaded(
      allRaceDaysGeoJson: allRaceDaysGeoJson ?? this.allRaceDaysGeoJson,
      fullRaceGeoJson: fullRaceGeoJson ?? this.fullRaceGeoJson,
      currentRaceDay: currentRaceDay ?? this.currentRaceDay,
      selectedRaceDay: selectedRaceDay ?? this.selectedRaceDay,
    );
  }
}
