import 'repository_exception.dart';

/// [ProjectException] providing the error codes for the repository.
class ProjectException extends RepositoryException<ProjectExceptionCode> {
  /// Creates a new [ProjectException].
  const ProjectException({required super.errorCode, super.message});
}

/// [ProjectExceptionCode] providing the error codes for different exceptions.
enum ProjectExceptionCode {
  /// Indicates that the API call to get the profile has failed.
  getFailed,

  /// Indicates that some of the profile actions have failed, but it's unknown.
  unknown,
}
