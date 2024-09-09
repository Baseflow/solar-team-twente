/// A news message that is sent out by the Solarteam.
class NewsMessage {
  /// Creates a new [NewsMessage] with the given [title] and [message].
  const NewsMessage({
    required this.title,
    required this.message,
    required this.dateSubmitted,
  });

  /// The title of the news message.
  final String title;

  /// The message of the news message.
  final String message;

  /// The date the news message was submitted.
  final DateTime dateSubmitted;
}
