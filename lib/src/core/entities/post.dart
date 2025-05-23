import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

/// A post that is sent out by the Solarteam.
class Post extends Equatable {
  /// Creates a new [Post] with the given [title] and [message].
  const Post({
    required this.type,
    required this.title,
    required this.location,
    required this.message,
    required this.images,
    this.videoUrl,
    this.dateSubmitted,
  });

  /// The type of the post.
  final PostType type;

  /// The images that are attached to the post.
  ///
  /// Images are immediately uploaded and what we see here is the URL of the image.
  final List<String> images;

  /// The title of the post.
  final String title;

  /// The location of the post.
  final LatLng location;

  /// The message of the post.
  final String message;

  /// Possible video url.
  final String? videoUrl;

  /// The date the post was submitted.
  final DateTime? dateSubmitted;

  @override
  List<Object?> get props => <Object?>[type, title, location, message, images, videoUrl, dateSubmitted];
}

enum PostType { news, dayReport, info }
