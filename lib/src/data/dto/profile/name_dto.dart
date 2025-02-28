import 'package:json_annotation/json_annotation.dart';

part 'name_dto.g.dart';

/// Name related data.
@JsonSerializable(createToJson: false)
class NameDTO {
  /// Creates a new [NameDTO] instance.
  NameDTO({required this.title, required this.first, required this.last});

  /// Creates a new [NameDTO] instance from a [json] map.
  factory NameDTO.fromJson(Map<String, dynamic> json) =>
      _$NameDTOFromJson(json);

  /// The title of the name, e.g. Mr, Mrs, etc.
  final String title;

  /// The first name.
  final String first;

  /// The last name.
  final String last;
}
