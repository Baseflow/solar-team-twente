import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solar_team_twente/core.dart';
import 'package:solar_team_twente/src/ui/features/projects/cubit/project_overview_cubit.dart';
import 'package:solar_team_twente/src/ui/features/projects/views/project_overview_view.dart';
import 'package:solar_team_twente/src/ui/features/projects/widgets/project_card.dart';
import 'package:solar_team_twente/src/ui/features/shared/widgets/centered_loading_message.dart';
import 'package:solar_team_twente/src/ui/features/shared/widgets/refreshable_state_message.dart';

import '../../../helpers/material_app_helper.dart';

class MockProjectOverviewCubit extends MockCubit<ProjectOverviewState>
    implements ProjectOverviewCubit {}

void main() {
  group('ProjectOverviewView Widget Tests', () {
    late MockProjectOverviewCubit mockCubit;
    late MaterialAppHelper view;

    setUp(() {
      mockCubit = MockProjectOverviewCubit();
      view = MaterialAppHelper(
        child: BlocProvider<ProjectOverviewCubit>.value(
          value: mockCubit,
          child: const ProjectOverviewView(),
        ),
      );
    });

    testWidgets(
      'Displays loaded state with 1 item',
      (WidgetTester tester) async {
        when(() => mockCubit.state).thenReturn(
          ProjectOverviewLoadedState(<Project>[
            Project(name: 'Test Project', description: 'Test Description'),
          ]),
        );

        await tester.pumpWidget(view);

        expect(find.byType(ProjectCard), findsOneWidget);
      },
    );

    testWidgets(
      'Displays loaded state with multiple items',
      (WidgetTester tester) async {
        when(() => mockCubit.state).thenReturn(
          ProjectOverviewLoadedState(<Project>[
            Project(name: 'Test Project 1', description: 'Test Description 1'),
            Project(name: 'Test Project 2', description: 'Test Description 2'),
          ]),
        );

        await tester.pumpWidget(view);

        expect(find.byType(ProjectCard), findsExactly(2));
      },
    );

    testWidgets('Displays loading state', (WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(
        const ProjectOverviewLoadingState(),
      );

      await tester.pumpWidget(view);

      expect(find.byType(CenteredLoadingMessage), findsOneWidget);
    });

    testWidgets('Displays empty state', (WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(
        const ProjectOverviewEmptyState(),
      );

      await tester.pumpWidget(view);

      expect(find.byType(RefreshableStateMessage), findsOneWidget);
      expect(find.text('No projects have been added yet.'), findsOne);
    });

    testWidgets('Displays error state', (WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(
        const ProjectOverviewErrorState(
          errorCode: ProjectExceptionCode.getFailed,
        ),
      );

      await tester.pumpWidget(view);

      expect(find.byType(RefreshableStateMessage), findsOneWidget);
      expect(find.text('Was not able to load projects.'), findsOne);
    });

    testWidgets(
      'Displays error state, reload button',
      (WidgetTester tester) async {
        when(() => mockCubit.state).thenReturn(
          const ProjectOverviewErrorState(
            errorCode: ProjectExceptionCode.getFailed,
          ),
        );

        await tester.pumpWidget(view);

        expect(find.byType(RefreshableStateMessage), findsOneWidget);
        expect(find.text('Was not able to load projects.'), findsOne);
      },
    );
  });
}
