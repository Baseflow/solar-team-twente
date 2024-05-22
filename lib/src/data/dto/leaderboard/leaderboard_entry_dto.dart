import '../../../../core.dart';

/// Data Transfer Object to represent a leaderboard entry.
class LeaderboardEntryDTO {
  /// Creates a new instance of the [LeaderboardEntryDTO].
  const LeaderboardEntryDTO({
    required this.teamName,
    required this.teamNumber,
    required this.position,
    required this.distance,
  });

  /// Creates a new instance of the [LeaderboardEntryDTO] from a JSON object.
  factory LeaderboardEntryDTO.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntryDTO(
      teamName: json['name'] as String,
      teamNumber: json['number'] as int,
      position: json['position'] as int,
      distance: json['distance'] as double,
    );
  }

  /// The name of the team.
  final String teamName;

  /// The number of the team.
  final int teamNumber;

  /// The position of the team on the leaderboard.
  final int position;

  /// The distance the team has traversed in the race.
  final double distance;

  /// Converts the [LeaderboardEntryDTO] to a [LeaderboardEntry].
  LeaderboardEntry toEntity() {
    return LeaderboardEntry(
      teamName: teamName,
      teamNumber: teamNumber,
      position: position,
      distance: distance,
    );
  }
}
