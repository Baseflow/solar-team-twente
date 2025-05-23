import 'package:latlong2/latlong.dart';

import '../../../core.dart';

class PostDto {
  PostDto._({
    required this.title,
    required this.message,
    required this.type,
    required this.location,
    required this.images,
    this.videoUrl,
    this.dateSubmitted,
  });

  factory PostDto.fromJson(Map<String, dynamic> json) {
    return PostDto._(
      title: json['title'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
      // TODO(triqoz): Figure out if this makes sense with the backend.
      location: Map<String, double>.from(json['location'] as Map<String, dynamic>),
      images: List<String>.from(json['images'] as List<dynamic>),
      videoUrl: json['video_url'] as String?,
      dateSubmitted: json['created_at'] as String?,
    );
  }

  factory PostDto.fromEntity(Post entity) {
    return PostDto._(
      title: entity.title,
      message: entity.message,
      type: entity.type.name,
      location: <String, double>{'latitude': entity.location.latitude, 'longitude': entity.location.longitude},
      images: entity.images,
      videoUrl: entity.videoUrl,
      dateSubmitted: entity.dateSubmitted?.toIso8601String(),
    );
  }

  final String message;
  final String title;
  final String type;
  final Map<String, double> location;
  final List<String> images;
  final String? videoUrl;
  final String? dateSubmitted;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'message': message,
      'type': type,
      'location': location,
      'images': images,
      'video_url': videoUrl,
      'created_at': dateSubmitted,
    };
  }

  Post toEntity() {
    return Post(
      title: title,
      message: message,
      type: PostType.values.firstWhere((PostType e) => e.name == type),
      location: LatLng(location['latitude']!, location['longitude']!),
      images: images,
      videoUrl: videoUrl,
      dateSubmitted: dateSubmitted != null ? DateTime.parse(dateSubmitted!) : null,
    );
  }
}
