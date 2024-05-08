import '../entities/project/project.dart';
import '../repositories/project_repository.dart';

/// Service for managing user projects.
class ProjectService {
  /// Creates a new [ProjectService] instance.
  const ProjectService({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;

  final ProjectRepository _projectRepository;

  /// Returns a list of [Project]s.
  Future<List<Project>> getAllProjects() {
    return _projectRepository.getAll();
  }
}
