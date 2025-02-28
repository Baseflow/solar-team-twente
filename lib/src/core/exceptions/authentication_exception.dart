import 'repository_exception.dart';

/// Exception thrown when an error occurs in the repository.
class AuthenticationException
    extends RepositoryException<AuthenticationExceptionCode> {
  /// Creates a new [AuthenticationException].
  const AuthenticationException({required super.errorCode, super.message});
}

/// [AuthenticationExceptionCode] providing the error codes for the service.
enum AuthenticationExceptionCode {
  /// Indicates the email or password supplied to authenticate is invalid.
  invalidCredentials,

  /// Indicates that the user corresponding to the email address is disabled.
  userDisabled,

  /// Indicates that no user is found matching the supplied email address.
  userNotFound,

  /// Indicates that the request was made too frequently.
  tooManyRequests,

  /// An unknown error occurred.
  unknown,
}
