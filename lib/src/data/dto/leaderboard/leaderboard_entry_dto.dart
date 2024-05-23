import 'package:json_annotation/json_annotation.dart';

import '../../../../core.dart';

part 'leaderboard_entry_dto.g.dart';

/// Data Transfer Object to represent a leaderboard entry.
@JsonSerializable(createToJson: false)
class LeaderboardEntryDTO {
  /// Creates a new instance of the [LeaderboardEntryDTO].
  const LeaderboardEntryDTO({
    required this.name,
    required this.number,
    required this.position,
    required this.distance,
  });

  /// Converts [json] to an instance of [LeaderboardEntryDTO].
  factory LeaderboardEntryDTO.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryDTOFromJson(json);

  /// The name of the team.
  @JsonKey(name: 'name', required: true)
  final String name;

  /// The number of the team.
  @JsonKey(name: 'number', required: true)
  final int number;

  /// The position of the team on the leaderboard.
  @JsonKey(name: 'position', required: true)
  final int position;

  /// The distance the team has traversed in the race.
  @JsonKey(name: 'distance', required: true)
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
