import 'dart:async';

import '../../../core.dart';

/// Concrete implementation of the [ProjectRepository] interface.
class ApiProjectRepository implements ProjectRepository {
  /// Create a new [ApiProjectRepository] instance.
  const ApiProjectRepository();

  @override
  Future<List<Project>> getAll() async {
    await Future<void>.delayed(const Duration(milliseconds: 1600));
    return List<Project>.generate(20, (int index) {
      return Project(
        name: 'Project ${index + 1}',
        description: 'Description for Project ${index + 1}',
      );
    });
  }
}
