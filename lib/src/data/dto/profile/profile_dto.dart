import 'package:json_annotation/json_annotation.dart';

import '../../../../core.dart';
import 'date_of_birth_dto.dart';
import 'location_dto.dart';
import 'name_dto.dart';

part 'profile_dto.g.dart';

/// The data object for a user profile.
@JsonSerializable(createToJson: false)
class ProfileDTO {
  /// Creates a new [ProfileDTO] instance.
  const ProfileDTO({
    required this.name,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.gender,
    required this.location,
  });

  /// Creates a new [ProfileDTO] instance from a [json] map.
  factory ProfileDTO.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> profileJson =
        (json['results'] as List<dynamic>)[0] as Map<String, dynamic>;
    return _$ProfileDTOFromJson(profileJson);
  }

  /// The name of the user
  final NameDTO name;

  /// The email address of the user.
  final String email;

  /// The phone number of the user.
  final String phone;

  /// The gender of the user.
  final String gender;

  /// The location of the user, such as a city and state.
  final LocationDTO location;

  /// The date of birth of the user.
  @JsonKey(name: 'dob')
  final DateOfBirthDTO dateOfBirth;

  /// Creates a new [Profile] instance from this DTO.
  Profile toEntity() {
    return Profile(
      name: '${name.first} ${name.last}',
      email: email,
      phoneNumber: phone,
      address:
          '${location.street.number} ${location.street.name}, ${location.city}'
          ', ${location.state} ${location.postcode}',
    );
  }
}
