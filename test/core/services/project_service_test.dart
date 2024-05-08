import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solar_team_twente/core.dart';

class MockProjectRepository extends Mock implements ProjectRepository {}

void main() {
  final MockProjectRepository mockProjectRepository = MockProjectRepository();

  final ProjectService projectService = ProjectService(
    projectRepository: mockProjectRepository,
  );

  group('getAll', () {
    test('Should return a list of projects.', () async {
      final List<Project> projects = <Project>[
        Project(
          name: 'Test Project',
          description: 'Test Description',
        ),
      ];

      when(mockProjectRepository.getAll).thenAnswer(
        (_) => Future<List<Project>>.value(projects),
      );

      // Act
      final List<Project> result = await projectService.getAllProjects();

      // Assert
      expect(result, projects);
      verify(mockProjectRepository.getAll).called(1);
    });
  });
}
