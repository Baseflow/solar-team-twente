/// A news message that is sent out by the Solarteam.
class Post {
  /// Creates a new [Post] with the given [title] and [message].
  const Post({required this.title, required this.message, this.dateSubmitted});

  /// The title of the news message.
  final String title;

  /// The message of the news message.
  final String message;

  /// The date the news message was submitted.
  final DateTime? dateSubmitted;
}
