/// General exception for when the issue at hand is unknown.
/// This exception is meant for developers, and ideally should never be shown
/// to the user.
class UnknownException implements Exception {
  /// Creates a new [UnknownException].
  const UnknownException([this.message]);

  /// Optional error message providing more context on the error that occurred.
  final String? message;
}
