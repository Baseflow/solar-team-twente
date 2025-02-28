import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solar_team_twente/src/ui/features/authentication/cubit/authentication_cubit.dart';
import 'package:solar_team_twente/src/ui/features/more/views/more_view.dart';
import 'package:solar_team_twente/src/ui/features/profile/cubit/profile_cubit.dart';

import '../../helpers/material_app_helper.dart';

class MockProfileCubit extends MockCubit<ProfileState>
    implements ProfileCubit {}

class MockAuthenticationCubit extends MockCubit<AuthenticationState>
    implements AuthenticationCubit {}

void main() {
  group('MoreView', () {
    late MockAuthenticationCubit mockAuthenticationCubit;
    late MockProfileCubit mockProfileCubit;

    setUp(() {
      mockAuthenticationCubit = MockAuthenticationCubit();
      mockProfileCubit = MockProfileCubit();
    });

    testWidgets(
        'should display a transparent Scaffold to ensure the '
        'background is visible', (WidgetTester tester) async {
      when(
        () => mockProfileCubit.state,
      ).thenReturn(const ProfileInitialState());

      await tester.pumpWidget(
        _buildMoreView(mockAuthenticationCubit, mockProfileCubit),
      );

      expect(find.byType(Scaffold), findsOneWidget);
      expect(
        tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor,
        Colors.transparent,
      );
    });

    // TODO(anyone): implement these tests after profile is implemented.
    // testWidgets(
    //   'should display user name in AppBar when profile is loaded',
    //   (WidgetTester tester) async {
    //     when(() => mockProfileCubit.state).thenReturn(
    //       ProfileLoadedState(
    //         Profile(
    //           name: 'Test User',
    //           address: '',
    //           email: '',
    //           phoneNumber: '',
    //         ),
    //       ),
    //     );
    //
    //     await tester.pumpWidget(
    //       _buildMoreView(mockAuthenticationCubit, mockProfileCubit),
    //     );
    //
    //     find.byType(AppBar);
    //     expect(find.text('Test User'), findsOneWidget);
    //   },
    // );

    // testWidgets(
    //   'should display profile title in AppBar when no profile is loaded yet',
    //   (WidgetTester tester) async {
    //     when(() => mockProfileCubit.state).thenReturn(
    //       const ProfileInitialState(),
    //     );
    //
    //     await tester.pumpWidget(
    //       _buildMoreView(mockAuthenticationCubit, mockProfileCubit),
    //     );
    //
    //     find.byType(AppBar);
    //     expect(find.text('Profile'), findsOneWidget);
    //   },
    // );
  });
}

MaterialAppHelper _buildMoreView(
  MockAuthenticationCubit mockAuthenticationCubit,
  MockProfileCubit mockProfileCubit,
) {
  return MaterialAppHelper(
    child: MultiBlocProvider(
      providers: <BlocProvider<Cubit<Object>>>[
        BlocProvider<AuthenticationCubit>.value(value: mockAuthenticationCubit),
        BlocProvider<ProfileCubit>.value(value: mockProfileCubit),
      ],
      child: const MoreView(),
    ),
  );
}
