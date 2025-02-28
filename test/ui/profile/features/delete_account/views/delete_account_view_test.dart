import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solar_team_twente/core.dart';
import 'package:solar_team_twente/src/ui/features/authentication/cubit/authentication_cubit.dart';
import 'package:solar_team_twente/src/ui/features/profile/feature/delete_account/cubit/delete_account_cubit.dart';
import 'package:solar_team_twente/src/ui/features/profile/feature/delete_account/views/delete_account_view.dart';

import '../../../../../helpers/material_app_helper.dart';

class MockDeleteAccountCubit extends MockCubit<DeleteAccountState>
    implements DeleteAccountCubit {}

class MockAuthenticationCubit extends MockCubit<AuthenticationState>
    implements AuthenticationCubit {}

const String mockPassword = 'password';

void main() {
  group('DeleteAccountView', () {
    late MockDeleteAccountCubit mockCubit;
    late MockAuthenticationCubit authCubit;
    late MaterialAppHelper view;

    setUp(() {
      mockCubit = MockDeleteAccountCubit();
      authCubit = MockAuthenticationCubit();

      view = MaterialAppHelper(
        child: MultiBlocProvider(
          providers: <BlocProvider<StateStreamableSource<Object?>>>[
            BlocProvider<AuthenticationCubit>.value(value: authCubit),
            BlocProvider<DeleteAccountCubit>.value(value: mockCubit),
          ],
          child: const DeleteAccountView(),
        ),
      );
    });

    testWidgets('Displays initial state', (WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(const DeleteAccountInitial());

      await tester.pumpWidget(view);

      // A button with the text 'Delete Account' should be displayed.
      expect(find.text('Confirm your password'), findsOne);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('Displays loading state', (WidgetTester tester) async {
      when(
        () => mockCubit.state,
      ).thenReturn(const DeleteAccountLoadingState(password: mockPassword));

      await tester.pumpWidget(view);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('DeleteAccountErrorState with invalid password', (
      WidgetTester tester,
    ) async {
      when(() => mockCubit.state).thenReturn(
        const DeleteAccountErrorState(
          errorCode: DeleteAccountExceptionCode.invalidPassword,
          password: mockPassword,
        ),
      );
      when(
        () => mockCubit.deleteAccount(),
      ).thenAnswer((_) => Future<void>.value());

      // Show DeleteAccountView.
      await tester.pumpWidget(view);

      // Enter a password into the Confirm Password field.
      final Finder textField = find.byType(TextFormField);
      await tester.enterText(textField, mockPassword);

      await tester.pump();

      final Finder deleteAccountButton = find.byKey(
        const Key('delete_account_button'),
      );

      // Find the Scrollable from the SingleChildScrollView.
      final Finder singleChildScrollViewScrollable = find.descendant(
        of: find.byType(SingleChildScrollView),
        matching: find.byType(Scrollable).at(0),
      );

      // Scroll until the delete account button is visible.
      await tester.scrollUntilVisible(
        deleteAccountButton,
        500,
        scrollable: singleChildScrollViewScrollable,
      );

      await tester.tap(deleteAccountButton);
      await tester.pump();

      expect(find.text('Invalid password'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('DeleteAccountSuccessState', (WidgetTester tester) async {
      when(authCubit.signOut).thenAnswer((_) async => Future<void>.value());
      whenListen(
        mockCubit,
        Stream<DeleteAccountState>.fromIterable(<DeleteAccountState>[
          const DeleteAccountSuccessState(password: mockPassword),
        ]),
        initialState: const DeleteAccountInitial(),
      );

      await tester.pumpWidget(view);
      await tester.pump();

      verify(authCubit.signOut).called(1);

      // A SnackerBar with the following message should be displayed.
      expect(
        find.text('Your account data will be removed in 30 days.'),
        findsOne,
      );

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
