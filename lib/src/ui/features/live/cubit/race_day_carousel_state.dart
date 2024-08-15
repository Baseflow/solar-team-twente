part of 'race_day_carousel_cubit.dart';

sealed class RaceDayCarouselState extends Equatable {
  const RaceDayCarouselState({
    this.allRaceDaysGeoJson = const <String>[],
    this.fullRaceGeoJson = '',
  });

  final List<String> allRaceDaysGeoJson;
  final String fullRaceGeoJson;

  int get currentRaceDay;

  String get currentRaceDayGeoJson;

  RaceDayCarouselState copyWith({
    List<String>? allRaceDaysGeoJson,
    String? fullRaceGeoJson,
  });
}

final class RaceDayCarouselInitial extends RaceDayCarouselState {
  const RaceDayCarouselInitial();

  @override
  List<Object> get props => <Object>[];

  @override
  int get currentRaceDay => 0;

  @override
  String get currentRaceDayGeoJson => '';

  @override
  RaceDayCarouselState copyWith({
    List<String>? allRaceDaysGeoJson,
    String? fullRaceGeoJson,
  }) {
    return const RaceDayCarouselInitial();
  }
}

final class RaceDayCarouselLoaded extends RaceDayCarouselState {
  const RaceDayCarouselLoaded({
    required super.allRaceDaysGeoJson,
    required super.fullRaceGeoJson,
    int currentRaceDayIndex = 0,
  }) : _currentRaceDayIndex = currentRaceDayIndex;

  final int _currentRaceDayIndex;

  @override
  int get currentRaceDay => _currentRaceDayIndex + 1;

  @override
  String get currentRaceDayGeoJson => allRaceDaysGeoJson[_currentRaceDayIndex];

  @override
  List<Object> get props => <Object>[
        allRaceDaysGeoJson,
        currentRaceDay,
        currentRaceDayGeoJson,
        fullRaceGeoJson,
      ];

  @override
  RaceDayCarouselState copyWith({
    List<String>? allRaceDaysGeoJson,
    String? fullRaceGeoJson,
    int? currentRaceDayIndex,
  }) {
    return RaceDayCarouselLoaded(
      allRaceDaysGeoJson: allRaceDaysGeoJson ?? this.allRaceDaysGeoJson,
      fullRaceGeoJson: fullRaceGeoJson ?? this.fullRaceGeoJson,
      currentRaceDayIndex: currentRaceDayIndex ?? _currentRaceDayIndex,
    );
  }
}
