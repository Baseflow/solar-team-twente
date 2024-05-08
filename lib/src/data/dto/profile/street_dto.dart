import 'package:json_annotation/json_annotation.dart';

part 'street_dto.g.dart';

/// User location street related data.
@JsonSerializable(createToJson: false)
class StreetDTO {
  /// Creates a new [StreetDTO] instance.
  StreetDTO({
    required this.number,
    required this.name,
  });

  /// Creates a new [StreetDTO] instance from a [json] map.
  factory StreetDTO.fromJson(Map<String, dynamic> json) =>
      _$StreetDTOFromJson(json);

  /// The street number.
  final int number;

  /// The street name.
  final String name;
}
