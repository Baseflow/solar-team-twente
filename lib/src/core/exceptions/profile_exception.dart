import 'repository_exception.dart';

/// [ProfileException] providing the error codes for the repository.
class ProfileException extends RepositoryException<ProfileExceptionCode> {
  /// Creates a new [ProfileException].
  const ProfileException({
    required super.errorCode,
    super.message,
  });
}

/// [ProfileExceptionCode] providing the error codes for different exceptions.
enum ProfileExceptionCode {
  /// Indicates that the API call to get the profile has failed.
  getFailed,

  /// Indicates that the API call to save the profile has failed.
  saveFailed,

  /// Indicates that the API call to delete the profile has failed.
  deleteFailed,

  /// Indicates that the image to be uploaded is too large.
  imageTooLarge,

  /// Indicates that some of the profile actions have failed, but it's unknown.
  unknown;
}
