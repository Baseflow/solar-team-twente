import 'package:json_annotation/json_annotation.dart';

import '../../../../core.dart';

part 'race_team_dto.g.dart';

/// {@macro race_team}
@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class RaceTeamDto {
  /// {@macro race_team}
  RaceTeamDto({
    required this.name,
    required this.totalDrivenKilometers,
    required this.number,
    required this.position,
    required this.vehicleClass,
  });

  /// Converts a [json] map to a [RaceTeamDto].
  factory RaceTeamDto.fromJson(Map<String, dynamic> json) {
    return _$RaceTeamDtoFromJson(json);
  }

  /// The team's name.
  final String name;

  /// The total distance in kilometers the team has been able to drive during
  /// the race.
  @JsonKey(name: 'distance', defaultValue: 0)
  final int totalDrivenKilometers;

  /// The team's number.
  final int number;

  /// The team's position.
  final int position;

  /// The vehicle class the team is participating in.
  ///
  /// Can be either `challenger` or `cruiser`.
  final String vehicleClass;

  /// Converts the DTO to a core entity.
  RaceTeam toEntity() {
    return RaceTeam(
      name: name,
      totalDrivenKilometers: totalDrivenKilometers,
      position: position,
    );
  }
}
