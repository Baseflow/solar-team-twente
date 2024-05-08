import '../entities/project/project.dart';

/// Interface for creating a data-layer implementation to manage user profiles.
abstract interface class ProjectRepository {
  /// Get all projects.
  Future<List<Project>> getAll();
}
