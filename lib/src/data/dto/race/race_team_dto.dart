import 'package:json_annotation/json_annotation.dart';

import '../../../../core.dart';

/// {@macro race_team}
@JsonSerializable(
  createToJson: false,
)
class RaceTeamDto {
  /// {@macro race_team}
  RaceTeamDto({
    required this.name,
    required this.totalDrivenKilometers,
  });

  /// The team's name.
  final String name;

  /// The total distance in kilometers the team has been able to drive during
  /// the race.
  final int totalDrivenKilometers;

  /// Converts the DTO to a core entity.
  RaceTeam toEntity() {
    return RaceTeam(
      name: name,
      totalDrivenKilometers: totalDrivenKilometers,
    );
  }
}
