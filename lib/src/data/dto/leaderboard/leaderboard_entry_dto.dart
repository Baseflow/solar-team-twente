import 'package:json_annotation/json_annotation.dart';

import '../../../../core.dart';

/// Data Transfer Object to represent a leaderboard entry.
@JsonSerializable()
class LeaderboardEntryDTO {
  /// Creates a new instance of the [LeaderboardEntryDTO].
  const LeaderboardEntryDTO({
    required this.name,
    required this.number,
    required this.position,
    required this.distance,
  });

  /// The name of the team.
  final String name;

  /// The number of the team.
  final int number;

  /// The position of the team on the leaderboard.
  final int position;

  /// The distance the team has traversed in the race.
  final double distance;

  /// Converts the [LeaderboardEntryDTO] to a [LeaderboardEntry].
  LeaderboardEntry toEntity() {
    return LeaderboardEntry(
      teamName: name,
      teamNumber: number,
      position: position,
      distance: distance,
    );
  }
}
