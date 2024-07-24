/// {@template race_team}
/// Contains the data related to a race team:
/// - the [name] of the team
/// - the [totalDrivenKilometers] the team has driven during the race, which
///  is used to determine the team's position in the leaderboard.
/// {@endtemplate}
class RaceTeam {
  /// {@macro race_team}
  RaceTeam({
    required this.name,
    required this.totalDrivenKilometers,
  });

  /// The team's name.
  final String name;

  /// The total distance in kilometers the team has been able to drive during
  /// the race.
  final int totalDrivenKilometers;
}
