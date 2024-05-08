import 'package:json_annotation/json_annotation.dart';

import 'street_dto.dart';

part 'location_dto.g.dart';

/// User location related data.
@JsonSerializable(createToJson: false)
class LocationDTO {
  /// Creates a new [LocationDTO] instance.
  LocationDTO({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
  });

  /// Creates a new [LocationDTO] instance from a [json] map.
  factory LocationDTO.fromJson(Map<String, dynamic> json) =>
      _$LocationDTOFromJson(json);

  /// The street information.
  final StreetDTO street;

  /// The city of the user.
  final String city;

  /// The state of the user.
  final String state;

  /// The country of the user.
  final String country;

  /// The postcode of the user.
  final dynamic postcode;
}
