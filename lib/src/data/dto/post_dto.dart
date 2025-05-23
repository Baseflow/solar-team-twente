import '../../../core.dart';

class PostDto {
  PostDto._({required this.title, required this.message, this.dateSubmitted});

  factory PostDto.fromJson(Map<String, dynamic> json) {
    return PostDto._(
      title: json['title'] as String,
      message: json['message'] as String,
      dateSubmitted: json['created_at'] as String,
    );
  }

  factory PostDto.fromEntity(Post entity) {
    return PostDto._(title: entity.title, message: entity.message);
  }

  final String message;
  final String title;
  final String? dateSubmitted;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'title': title, 'message': message};
  }

  Post toEntity() {
    return Post(title: title, message: message, dateSubmitted: DateTime.parse(dateSubmitted!));
  }
}
