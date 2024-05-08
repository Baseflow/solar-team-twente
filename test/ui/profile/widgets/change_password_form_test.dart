import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solar_team_twente/core.dart';
import 'package:solar_team_twente/src/ui/features/profile/cubit/change_password_cubit.dart';
import 'package:solar_team_twente/src/ui/features/profile/widgets/change_password_form.dart';
import 'package:solar_team_twente/src/ui/features/shared/widgets/filled_loading_button.dart';

import '../../../helpers/material_app_helper.dart';

class MockChangePasswordCubit extends MockCubit<ChangePasswordState>
    implements ChangePasswordCubit {}

void main() {
  late MockChangePasswordCubit mockChangePasswordCubit;
  late MaterialAppHelper formView;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockChangePasswordCubit = MockChangePasswordCubit();
    when(() => mockChangePasswordCubit.state).thenReturn(
      const ChangePasswordState(),
    );
    AppConfig.initialize(kdDebugMode: true);
    formView = MaterialAppHelper(
      child: Scaffold(
        body: BlocProvider<ChangePasswordCubit>.value(
          value: mockChangePasswordCubit,
          child: const ChangePasswordForm(),
        ),
      ),
    );
  });

  group(
    'ChangePasswordForm Widget Tests',
        () {
      testWidgets('displays 3 input text fields', (WidgetTester tester) async {
        await tester.pumpWidget(formView);
        expect(find.byType(TextFormField), findsNWidgets(3));
      });

      testWidgets(
        'displays 1 filled loading button widget',
            (WidgetTester tester) async {
          await tester.pumpWidget(formView);
          expect(find.byType(FilledLoadingButton), findsOneWidget);
        },
      );
    },
  );

  group(
    'FilledLoadingButton Widget Tests',
        () {
      testWidgets(
        'displays a CircularLoadingIndicator when in loading state',
            (WidgetTester tester) async {
          when(() => mockChangePasswordCubit.state).thenReturn(
            const ChangePasswordState(isLoading: true),
          );

          await tester.pumpWidget(formView);

          expect(find.byType(CircularProgressIndicator), findsOne);
        },
      );

      testWidgets(
        'does not display a CircularLoadingIndicator when '
            'not in loading state',
            (WidgetTester tester) async {
          when(() => mockChangePasswordCubit.state).thenReturn(
            const ChangePasswordState(),
          );

          await tester.pumpWidget(formView);

          expect(find.byType(CircularProgressIndicator), findsNothing);
        },
      );
    },
  );

  group(
    'SnackBar Tests',
        () {
      testWidgets(
        'shows snack bar when task executed successfully',
            (WidgetTester tester) async {
          when(mockChangePasswordCubit.changePassword).thenAnswer(
                (_) => Future<void>.value(),
          );

          whenListen(
            mockChangePasswordCubit,
            Stream<ChangePasswordState>.fromIterable(
              <ChangePasswordState>[
                const ChangePasswordState(isLoading: true),
                const ChangePasswordState(changePasswordSuccessful: true),
              ],
            ),
            initialState: const ChangePasswordState(),
          );

          await tester.pumpWidget(formView);
          await tester.pumpAndSettle();

          expect(find.byType(SnackBar), findsOne);
        },
      );

      testWidgets(
        'shows snack bar when task does not succeed',
            (WidgetTester tester) async {
          when(mockChangePasswordCubit.changePassword).thenAnswer(
                (_) => Future<void>.value(),
          );

          whenListen(
            mockChangePasswordCubit,
            Stream<ChangePasswordState>.fromIterable(
              <ChangePasswordState>[
                const ChangePasswordState(isLoading: true),
                const ChangePasswordState(
                  authErrorCode: AuthenticationExceptionCode.invalidCredentials,
                ),
              ],
            ),
            initialState: const ChangePasswordState(),
          );

          await tester.pumpWidget(formView);
          await tester.pumpAndSettle();

          expect(find.byType(SnackBar), findsOne);
        },
      );
    },
  );
}
