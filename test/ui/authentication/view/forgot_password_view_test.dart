import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solar_team_twente/core.dart';
import 'package:solar_team_twente/src/ui/features/authentication/cubit/forgot_password_cubit.dart';
import 'package:solar_team_twente/src/ui/features/authentication/views/forgot_password_view.dart';

import '../../../helpers/material_app_helper.dart';
import '../../../helpers/mock_go_router_provider.dart';

class MockForgotPasswordCubit extends MockCubit<ForgotPasswordState>
    implements ForgotPasswordCubit {}

void main() {
  late MockForgotPasswordCubit mockForgotPasswordCubit;
  late MockGoRouter mockGoRouter;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockForgotPasswordCubit = MockForgotPasswordCubit();
    mockGoRouter = MockGoRouter();
    when(
      () => mockForgotPasswordCubit.state,
    ).thenReturn(const ForgotPasswordState());
  });

  group('ForgotPasswordView', () {
    testWidgets(
      'should show a loading indicator when state.isLoading is true',
      (WidgetTester tester) async {
        whenListen(
          mockForgotPasswordCubit,
          Stream<ForgotPasswordState>.fromIterable(<ForgotPasswordState>[
            const ForgotPasswordState(isLoading: true),
          ]),
          initialState: const ForgotPasswordState(),
        );
        await tester.pumpWidget(
          MaterialAppHelper(
            child: BlocProvider<ForgotPasswordCubit>.value(
              value: mockForgotPasswordCubit,
              child: const ForgotPasswordView(),
            ),
          ),
        );
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets('should show a snackbar when emailSentSuccessfully is true', (
      WidgetTester tester,
    ) async {
      whenListen(
        mockForgotPasswordCubit,
        Stream<ForgotPasswordState>.fromIterable(<ForgotPasswordState>[
          const ForgotPasswordState(emailSentSuccessfully: true),
        ]),
        initialState: const ForgotPasswordState(),
      );

      await tester.pumpWidget(
        MaterialAppHelper(
          child: MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: BlocProvider<ForgotPasswordCubit>.value(
              value: mockForgotPasswordCubit,
              child: const ForgotPasswordView(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Password reset email was sent.'), findsOneWidget);
    });

    testWidgets('should show a snackbar when there is an error', (
      WidgetTester tester,
    ) async {
      whenListen(
        mockForgotPasswordCubit,
        Stream<ForgotPasswordState>.fromIterable(<ForgotPasswordState>[
          const ForgotPasswordState(
            authErrorCode: AuthenticationExceptionCode.userNotFound,
          ),
        ]),
        initialState: const ForgotPasswordState(),
      );

      await tester.pumpWidget(
        MaterialAppHelper(
          child: BlocProvider<ForgotPasswordCubit>.value(
            value: mockForgotPasswordCubit,
            child: const ForgotPasswordView(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(SnackBar), findsOneWidget);
      expect(
        find.text('There was an error resetting the password.'),
        findsOneWidget,
      );
    });
  });
}
