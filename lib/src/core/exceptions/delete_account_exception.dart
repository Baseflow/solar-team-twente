import 'repository_exception.dart';

/// [DeleteAccountException] providing the error codes for the repository.
class DeleteAccountException
    extends RepositoryException<DeleteAccountExceptionCode> {
  /// Creates a new [DeleteAccountException].
  const DeleteAccountException({required super.errorCode, super.message});
}

/// [DeleteAccountExceptionCode] providing error codes for different exceptions.
enum DeleteAccountExceptionCode {
  /// Indicates that the user entered the wrong password.
  invalidPassword,

  /// Indicates that the password is required.
  passwordRequired,

  /// Indicates that the API call to delete the account has failed.
  deleteFailed,

  /// Indicates that an unknown error occurred.
  unknown,
}
