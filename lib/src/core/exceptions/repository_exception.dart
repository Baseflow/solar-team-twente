import 'package:meta/meta.dart';

/// Base class for repository exceptions.
@immutable
abstract class RepositoryException<T> implements Exception {
  /// Creates a new [RepositoryException].
  const RepositoryException({required this.errorCode, this.message});

  /// The enum [errorCode] describing what went wrong.
  final T errorCode;

  /// Optional error message providing more context on the error that occurred.
  final String? message;

  @override
  String toString() {
    return 'RepositoryException: errorCode: $errorCode, '
        'message: ${message ?? 'No message'}';
  }
}
