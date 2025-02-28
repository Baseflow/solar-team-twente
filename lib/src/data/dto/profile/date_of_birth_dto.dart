import 'package:json_annotation/json_annotation.dart';

part 'date_of_birth_dto.g.dart';

/// Date of birth related data.
@JsonSerializable(createToJson: false)
class DateOfBirthDTO {
  /// Creates a new [DateOfBirthDTO] instance.
  const DateOfBirthDTO({required this.date, required this.age});

  /// Creates a new [DateOfBirthDTO] instance from a [json] map.
  factory DateOfBirthDTO.fromJson(Map<String, dynamic> json) =>
      _$DateOfBirthDTOFromJson(json);

  /// The date of birth of the user in UTC.
  final String date;

  /// The age of the user.
  final int age;
}
