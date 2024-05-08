import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solar_team_twente/core.dart';
import 'package:solar_team_twente/src/ui/features/authentication/cubit/authentication_cubit.dart';
import 'package:solar_team_twente/src/ui/features/profile/cubit/profile_cubit.dart';
import 'package:solar_team_twente/src/ui/features/profile/views/profile_content.dart';
import 'package:solar_team_twente/src/ui/features/shared/widgets/filled_loading_button.dart';

import '../../../helpers/material_app_helper.dart';

class MockProfileCubit extends MockCubit<ProfileState>
    implements ProfileCubit {}

class MockAuthenticationCubit extends MockCubit<AuthenticationState>
    implements AuthenticationCubit {}

void main() {
  group(
    'ProfileContent',
    () {
      late MockAuthenticationCubit mockAuthenticationCubit;
      late MockProfileCubit mockProfileCubit;

      setUp(() {
        mockAuthenticationCubit = MockAuthenticationCubit();
        mockProfileCubit = MockProfileCubit();
      });

      testWidgets(
        'should display sign out button',
        (WidgetTester tester) async {
          when(() => mockProfileCubit.state).thenReturn(
            ProfileLoadedState(
              Profile(
                name: 'Test User',
                address: '',
                email: '',
                phoneNumber: '',
              ),
            ),
          );

          await tester.pumpWidget(
            _buildProfileContentView(mockAuthenticationCubit, mockProfileCubit),
          );

          final Finder signOutButton =
              find.widgetWithText(FilledLoadingButton, 'Sign Out');

          expect(signOutButton, findsOneWidget);
        },
      );
    },
  );
}

MaterialAppHelper _buildProfileContentView(
  MockAuthenticationCubit mockAuthenticationCubit,
  MockProfileCubit mockProfileCubit,
) {
  return MaterialAppHelper(
    child: MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<AuthenticationCubit>.value(
          value: mockAuthenticationCubit,
        ),
        BlocProvider<ProfileCubit>.value(
          value: mockProfileCubit,
        ),
      ],
      child: const SingleChildScrollView(child: ProfileContent()),
    ),
  );
}
