import 'package:mocktail/mocktail.dart';
import 'package:solar_team_twente/core.dart';
import 'package:test/test.dart';

void main() {
  test('signIn should emit authenticated state.', () async {
    final AuthenticationRepository mockAuthenticationRepository =
        MockAuthenticationRepository();

    final Token dummyToken = Token(
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
      expiresAt: DateTime.now().add(const Duration(days: 1)),
    );
    final AuthenticationService authenticationService = AuthenticationService(
      authenticationRepository: mockAuthenticationRepository,
    );

    when(
      () => mockAuthenticationRepository.signIn(
        email: 'email',
        password: 'password',
      ),
    ).thenAnswer((_) => Future<Token>.value(dummyToken));

    await authenticationService.signIn(email: 'email', password: 'password');

    expect(
      authenticationService.authStatusStream,
      emitsInOrder(<AuthenticationStatus>[AuthenticationStatus.authenticated]),
    );

    verify(
      () => mockAuthenticationRepository.signIn(
        email: 'email',
        password: 'password',
      ),
    ).called(1);
  });

  test('logout should emit unauthenticated state.', () async {
    final AuthenticationRepository mockAuthenticationRepository =
        MockAuthenticationRepository();
    final AuthenticationService authenticationService = AuthenticationService(
      authenticationRepository: mockAuthenticationRepository,
    );

    when(
      mockAuthenticationRepository.endSession,
    ).thenAnswer((_) => Future<void>.value());

    await authenticationService.logout();

    expect(
      authenticationService.authStatusStream,
      emitsInOrder(<AuthenticationStatus>[
        AuthenticationStatus.unauthenticated,
      ]),
    );

    verify(mockAuthenticationRepository.endSession).called(1);
  });

  test('updatePassword should emit authenticated state', () async {
    final AuthenticationRepository mockAuthenticationRepository =
        MockAuthenticationRepository();

    final Token dummyToken = Token(
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
      expiresAt: DateTime.now().add(const Duration(days: 1)),
    );

    final AuthenticationService authenticationService = AuthenticationService(
      authenticationRepository: mockAuthenticationRepository,
    );

    when(
      () => mockAuthenticationRepository.updatePassword(
        newPassword: 'newPassword',
      ),
    ).thenAnswer((_) => Future<Token>.value(dummyToken));

    await authenticationService.updatePassword(newPassword: 'newPassword');

    expect(
      authenticationService.authStatusStream,
      emitsInOrder(<AuthenticationStatus>[AuthenticationStatus.authenticated]),
    );

    verify(
      () => mockAuthenticationRepository.updatePassword(
        newPassword: 'newPassword',
      ),
    ).called(1);
  });
}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}
