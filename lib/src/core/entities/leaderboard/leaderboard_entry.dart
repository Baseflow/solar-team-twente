/// A class that represents a leaderboard entry.
class LeaderboardEntry {

  /// Creates a new leaderboard entry.
  // TODO(Floyd): Macro.
  const LeaderboardEntry({
    required this.teamName,
    required this.teamNumber,
    required this.position,
    required this.distance,
  });

  /// The name of the team.
  final String teamName;

  /// The number of the team.
  final int teamNumber;

  /// The current position of the team.
  final int position;

  /// The distance of the team.
  final double distance;
}
