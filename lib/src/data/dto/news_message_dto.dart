import '../../../core.dart';

class NewsMessageDTO {
  NewsMessageDTO._({required this.title, required this.message, this.dateSubmitted});

  factory NewsMessageDTO.fromJson(Map<String, dynamic> json) {
    return NewsMessageDTO._(
      title: json['title'] as String,
      message: json['message'] as String,
      dateSubmitted: json['created_at'] as String,
    );
  }

  factory NewsMessageDTO.fromEntity(NewsMessage entity) {
    return NewsMessageDTO._(title: entity.title, message: entity.message);
  }

  final String message;
  final String title;
  final String? dateSubmitted;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'title': title, 'message': message};
  }

  NewsMessage toEntity() {
    return NewsMessage(title: title, message: message, dateSubmitted: DateTime.parse(dateSubmitted!));
  }
}
