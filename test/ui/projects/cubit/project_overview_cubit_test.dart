import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solar_team_twente/core.dart';
import 'package:solar_team_twente/src/ui/features/projects/cubit/project_overview_cubit.dart';

class MockProjectService extends Mock implements ProjectService {}

void main() {
  group('ProjectOverviewCubit', () {
    late MockProjectService mockProjectService;

    setUp(() {
      mockProjectService = MockProjectService();
    });

    final List<Project> projects = <Project>[
      Project(
        name: 'Test Project',
        description: 'Test Description',
      ),
    ];

    blocTest<ProjectOverviewCubit, ProjectOverviewState>(
      'Load and successfully fetch projects',
      build: () {
        when(mockProjectService.getAllProjects).thenAnswer((_) {
          return Future<List<Project>>.value(projects);
        });
        return ProjectOverviewCubit(mockProjectService);
      },
      act: (ProjectOverviewCubit cubit) => cubit.getAllProjects(),
      expect: () => <ProjectOverviewState>[
        const ProjectOverviewLoadingState(),
        ProjectOverviewLoadedState(projects),
      ],
    );

    blocTest<ProjectOverviewCubit, ProjectOverviewState>(
      'Load and successfully fetch an empty list of projects',
      build: () {
        when(mockProjectService.getAllProjects).thenAnswer((_) {
          return Future<List<Project>>.value(<Project>[]);
        });
        return ProjectOverviewCubit(mockProjectService);
      },
      act: (ProjectOverviewCubit cubit) => cubit.getAllProjects(),
      expect: () => <ProjectOverviewState>[
        const ProjectOverviewLoadingState(),
        const ProjectOverviewEmptyState(),
      ],
    );

    blocTest<ProjectOverviewCubit, ProjectOverviewState>(
      'Load and fail to fetch projects with a ProjectException',
      build: () {
        when(mockProjectService.getAllProjects).thenAnswer((_) {
          throw const ProjectException(
            errorCode: ProjectExceptionCode.getFailed,
          );
        });
        return ProjectOverviewCubit(mockProjectService);
      },
      act: (ProjectOverviewCubit cubit) => cubit.getAllProjects(),
      expect: () => <ProjectOverviewState>[
        const ProjectOverviewLoadingState(),
        const ProjectOverviewErrorState(
          errorCode: ProjectExceptionCode.getFailed,
        ),
      ],
    );

    blocTest<ProjectOverviewCubit, ProjectOverviewState>(
      'Load and fail to fetch projects with an UnknownException',
      build: () {
        when(mockProjectService.getAllProjects).thenAnswer((_) {
          throw const UnknownException('Unknown error occurred');
        });
        return ProjectOverviewCubit(mockProjectService);
      },
      act: (ProjectOverviewCubit cubit) => cubit.getAllProjects(),
      expect: () => <ProjectOverviewState>[
        const ProjectOverviewLoadingState(),
        const ProjectOverviewErrorState(
          errorCode: ProjectExceptionCode.unknown,
        ),
      ],
    );
  });
}
