import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solar_team_twente/core.dart';
import 'package:solar_team_twente/src/ui/features/authentication/cubit/login_cubit.dart';
import 'package:solar_team_twente/src/ui/features/authentication/views/login_view.dart';
import 'package:solar_team_twente/src/ui/features/authentication/widgets/login_container.dart';
import 'package:solar_team_twente/src/ui/features/settings/cubit/language_cubit.dart';
import 'package:solar_team_twente/src/ui/features/shared/widgets/filled_loading_button.dart';
import 'package:solar_team_twente/src/ui/localizations/generated/app_localizations.dart';

import '../../../helpers/material_app_helper.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

class MockLanguageCubit extends MockCubit<String> implements LanguageCubit {}

void main() {
  late MockLoginCubit mockLoginCubit;
  late MockLanguageCubit mockLanguageCubit;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockLoginCubit = MockLoginCubit();
    mockLanguageCubit = MockLanguageCubit();

    when(() => mockLoginCubit.state).thenReturn(const LoginState());
    when(() => mockLanguageCubit.state).thenReturn('en');
    when(() => mockLanguageCubit.getCountryCode()).thenReturn('US');
  });

  group('LoginContainer', () {
    testWidgets(
      'should show a loading indicator and button text when isLoading '
      'is true',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: FilledLoadingButton(
                buttonText: 'Sign In',
                onPressed: () {},
                isLoading: true,
              ),
            ),
          ),
        );

        expect(
          find.descendant(
            of: find.byType(FilledButton),
            matching: find.byType(CircularProgressIndicator),
          ),
          findsOneWidget,
        );

        expect(
          find.descendant(
            of: find.byType(FilledButton),
            matching: find.text('Sign In'),
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets('should disable the sign in button while loading', (
      WidgetTester tester,
    ) async {
      whenListen(
        mockLoginCubit,
        Stream<LoginState>.fromIterable(<LoginState>[
          const LoginState(isLoading: true),
        ]),
        initialState: const LoginState(),
      );
      await tester.pumpWidget(
        MaterialAppHelper(
          child: BlocProvider<LoginCubit>.value(
            value: mockLoginCubit,
            child: const LoginContainer(),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      final Finder buttonFinder = find.byType(FilledLoadingButton);
      expect(buttonFinder, findsOneWidget);

      final FilledLoadingButton button = tester.widget<FilledLoadingButton>(
        buttonFinder,
      );

      expect(button.isLoading, isTrue);
    });

    testWidgets('should enable the sign in button when not loading and valid '
        'credentials are entered', (WidgetTester tester) async {
      whenListen(
        mockLoginCubit,
        Stream<LoginState>.fromIterable(<LoginState>[
          const LoginState(
            email: 'test@example.com',
            password: 'validPassword',
          ),
        ]),
        initialState: const LoginState(isLoading: true),
      );

      await tester.pumpWidget(
        MaterialAppHelper(
          child: BlocProvider<LoginCubit>.value(
            value: mockLoginCubit,
            child: const LoginContainer(),
          ),
        ),
      );
      await tester.pump();

      final Finder filledLoadingButtonFinder = find.byType(FilledLoadingButton);
      expect(filledLoadingButtonFinder, findsOneWidget);

      final FilledLoadingButton button = tester.widget<FilledLoadingButton>(
        filledLoadingButtonFinder,
      );
      expect(button.isLoading, isFalse);
    });

    testWidgets('should show an error message if the login fails', (
      WidgetTester tester,
    ) async {
      whenListen(
        mockLoginCubit,
        Stream<LoginState>.fromIterable(<LoginState>[
          const LoginState(isLoading: true), // Simulate loading
          const LoginState(
            authErrorCode: AuthenticationExceptionCode.invalidCredentials,
          ),
        ]),
        initialState: const LoginState(),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: <BlocProvider<StateStreamableSource<Object?>>>[
            BlocProvider<LoginCubit>.value(value: mockLoginCubit),
            BlocProvider<LanguageCubit>.value(value: mockLanguageCubit),
          ],
          child: MaterialApp(
            home: Builder(builder: (BuildContext context) => const LoginView()),
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
