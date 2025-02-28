import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solar_team_twente/core.dart';
import 'package:solar_team_twente/src/ui/features/authentication/cubit/login_cubit.dart';
import 'package:test/test.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

void main() {
  late MockAuthenticationService mockAuthenticationService;

  setUp(() {
    mockAuthenticationService = MockAuthenticationService();
    // Set up the default return value for signIn to avoid null errors
    when(
      () => mockAuthenticationService.signIn(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => <String, String>{});
  });

  group('updateEmail', () {
    blocTest<LoginCubit, LoginState>(
      'should emit state with updated email',
      build: () => LoginCubit(mockAuthenticationService),
      act: (LoginCubit cubit) => cubit.updateEmail('email@example.com'),
      expect: () => <LoginState>[const LoginState(email: 'email@example.com')],
    );
  });

  group('signIn', () {
    blocTest<LoginCubit, LoginState>(
      'should emit loading, then success state on successful sign in',
      setUp: () {
        when(
          () => mockAuthenticationService.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => Future<void>.value());
      },
      build: () => LoginCubit(mockAuthenticationService),
      act: (LoginCubit cubit) async {
        cubit
          ..updateEmail('test@example.com')
          ..updatePassword('password');
        await cubit.signIn();
      },
      expect:
          () => <LoginState>[
            const LoginState(email: 'test@example.com'),
            const LoginState(email: 'test@example.com', password: 'password'),
            const LoginState(
              email: 'test@example.com',
              password: 'password',
              isLoading: true,
            ),
            const LoginState(
              email: 'test@example.com',
              password: 'password',
              loginSuccessful: true,
            ),
          ],
    );

    blocTest<LoginCubit, LoginState>(
      'should emit loading, then error state when sign in fails',
      setUp: () {
        when(
          () => mockAuthenticationService.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(
          const AuthenticationException(
            errorCode: AuthenticationExceptionCode.userNotFound,
          ),
        );
      },
      build: () => LoginCubit(mockAuthenticationService),
      act: (LoginCubit cubit) async {
        cubit
          ..updateEmail('test@example.com')
          ..updatePassword('password');
        await cubit.signIn();
      },
      expect:
          () => <LoginState>[
            const LoginState(email: 'test@example.com'),
            const LoginState(email: 'test@example.com', password: 'password'),
            const LoginState(
              email: 'test@example.com',
              password: 'password',
              isLoading: true,
            ),
            const LoginState(
              email: 'test@example.com',
              password: 'password',
              authErrorCode: AuthenticationExceptionCode.userNotFound,
            ),
          ],
    );
  });
}
