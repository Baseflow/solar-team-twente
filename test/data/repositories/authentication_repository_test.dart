import 'package:mocktail/mocktail.dart';
import 'package:solar_team_twente/core.dart' as core;
import 'package:solar_team_twente/src/data/clients/clients.dart';
import 'package:solar_team_twente/src/data/data_stores/data_stores.dart';
import 'package:solar_team_twente/src/data/dto/authentication/token_dto.dart';
import 'package:solar_team_twente/src/data/repositories/repositories.dart'
    as data;
import 'package:test/test.dart';

void main() {
  late AuthenticationClient mockAuthenticationClient;
  late TokenDataStore mockTokenDataStore;

  setUpAll(() {
    registerFallbackValue(
      TokenDTO(
        accessToken: 'accessToken',
        refreshToken: 'refreshToken',
        expiresAt: DateTime.now(),
      ),
    );
  });

  setUp(() {
    mockAuthenticationClient = MockAuthenticationClient();
    mockTokenDataStore = MockTokenDataStore();
  });

  group('constructor', () {
    test('constructor - calling multiple times should return the same instance',
        () {
      final data.AuthenticationRepository first = data.AuthenticationRepository(
        authenticationClient: mockAuthenticationClient,
        tokenDataStore: mockTokenDataStore,
      );
      final data.AuthenticationRepository second =
          data.AuthenticationRepository(
        authenticationClient: mockAuthenticationClient,
        tokenDataStore: mockTokenDataStore,
      );

      expect(identical(first, second), isTrue);
    });
  });

  group(
    'getToken',
    () {
      test('should return token from memory if available', () async {
        final core.Token dummyToken = core.Token(
          accessToken: 'accessToken',
          refreshToken: 'refreshToken',
          expiresAt: DateTime.now(),
        );
        final TokenDTO dummyTokenDto = TokenDTO.fromEntity(dummyToken);

        when(
          () => mockAuthenticationClient.loginWithCredentials(
            email: 'email',
            password: 'password',
          ),
        ).thenAnswer((_) => Future<TokenDTO>.value(dummyTokenDto));
        when(
          () => mockTokenDataStore.saveToken(token: dummyTokenDto),
        ).thenAnswer((_) => Future<void>.value());
        when(() => mockTokenDataStore.retrieveToken())
            .thenAnswer((_) => Future<TokenDTO?>.value());

        final data.AuthenticationRepository authenticationRepository =
            data.AuthenticationRepository.private(
          authenticationClient: mockAuthenticationClient,
          tokenDataStore: mockTokenDataStore,
        );

        // Login to ensure a token is stored in memory.
        await authenticationRepository.signIn(
          email: 'email',
          password: 'password',
        );

        final core.Token? retrievedToken =
            await authenticationRepository.getToken();

        expect(retrievedToken, dummyToken);
        verifyNever(() => mockTokenDataStore.retrieveToken());
      });

      test(
        'should return token from data store if not in memory',
        () async {
          when(() => mockTokenDataStore.retrieveToken())
              .thenAnswer((_) => Future<TokenDTO?>.value());

          final data.AuthenticationRepository authenticationRepository =
              data.AuthenticationRepository.private(
            authenticationClient: mockAuthenticationClient,
            tokenDataStore: mockTokenDataStore,
          );

          final core.Token? token = await authenticationRepository.getToken();

          expect(token, null);
          verify(() => mockTokenDataStore.retrieveToken()).called(1);
        },
      );
    },
  );

  group(
    'signIn',
    () {
      test(
        'should return a token',
        () async {
          final core.Token dummyToken = core.Token(
            accessToken: 'accessToken',
            refreshToken: 'refreshToken',
            expiresAt: DateTime.now(),
          );
          final TokenDTO dummyTokenDto = TokenDTO.fromEntity(dummyToken);

          when(
            () => mockAuthenticationClient.loginWithCredentials(
              email: 'email',
              password: 'password',
            ),
          ).thenAnswer((_) => Future<TokenDTO>.value(dummyTokenDto));

          when(
            () => mockTokenDataStore.saveToken(token: dummyTokenDto),
          ).thenAnswer((_) => Future<void>.value());

          final data.AuthenticationRepository authenticationRepository =
              data.AuthenticationRepository.private(
            authenticationClient: mockAuthenticationClient,
            tokenDataStore: mockTokenDataStore,
          );

          final core.Token token = await authenticationRepository.signIn(
            email: 'email',
            password: 'password',
          );

          expect(token, dummyToken);
          verify(
            () => mockAuthenticationClient.loginWithCredentials(
              email: 'email',
              password: 'password',
            ),
          ).called(1);
          verify(
            () => mockTokenDataStore.saveToken(token: dummyTokenDto),
          ).called(1);
        },
      );
    },
  );

  group(
    'endSession',
    () {
      test('should return if no token', () async {
        final data.AuthenticationRepository authenticationRepository =
            data.AuthenticationRepository.private(
          authenticationClient: mockAuthenticationClient,
          tokenDataStore: mockTokenDataStore,
        );

        await authenticationRepository.endSession();

        verifyNever(
          () => mockAuthenticationClient.signOut(
            token: any(named: 'token'),
          ),
        );
        verifyNever(
          () => mockTokenDataStore.deleteToken(
            token: any(named: 'token'),
          ),
        );
      });

      test(
        'should delete token if there is a token',
        () async {
          final core.Token dummyToken = core.Token(
            accessToken: 'accessToken',
            refreshToken: 'refreshToken',
            expiresAt: DateTime.now(),
          );
          final TokenDTO dummyTokenDto = TokenDTO.fromEntity(dummyToken);

          when(
            () => mockAuthenticationClient.loginWithCredentials(
              email: 'email',
              password: 'password',
            ),
          ).thenAnswer((_) => Future<TokenDTO>.value(dummyTokenDto));
          when(
            () => mockAuthenticationClient.signOut(token: dummyTokenDto),
          ).thenAnswer((_) => Future<void>.value());
          when(
            () => mockTokenDataStore.deleteToken(token: dummyTokenDto),
          ).thenAnswer((_) => Future<void>.value());
          when(
            () => mockTokenDataStore.retrieveToken(),
          ).thenAnswer((_) => Future<TokenDTO?>.value());
          when(
            () => mockTokenDataStore.saveToken(token: dummyTokenDto),
          ).thenAnswer((_) => Future<void>.value());

          final data.AuthenticationRepository authenticationRepository =
              data.AuthenticationRepository.private(
            authenticationClient: mockAuthenticationClient,
            tokenDataStore: mockTokenDataStore,
          );

          // Make sure we login so the token is available.
          await authenticationRepository.signIn(
            email: 'email',
            password: 'password',
          );

          // Sanity check to make sure the token is available.
          expect(
            await authenticationRepository.getToken(),
            dummyToken,
          );

          await authenticationRepository.endSession();

          expect(await authenticationRepository.getToken(), null);
          verify(
            () => mockAuthenticationClient.signOut(token: any(named: 'token')),
          ).called(1);
          verify(
            () => mockTokenDataStore.deleteToken(token: any(named: 'token')),
          ).called(1);
        },
      );
    },
  );

  group(
    'refreshToken',
    () {
      test(
        'should save and return a new token',
        () async {
          final core.Token dummyToken = core.Token(
            accessToken: 'accessToken',
            refreshToken: 'refreshToken',
            expiresAt: DateTime.now(),
          );
          final TokenDTO dummyTokenDto = TokenDTO.fromEntity(dummyToken);
          final TokenDTO refreshedTokenDto = TokenDTO(
            accessToken: 'accessToken',
            refreshToken: 'refreshedToken',
            expiresAt: DateTime.now(),
          );

          when(
            () => mockAuthenticationClient.refreshToken(
              tokenToRefresh: dummyTokenDto,
            ),
          ).thenAnswer(
            (_) => Future<TokenDTO>.value(
              refreshedTokenDto,
            ),
          );
          when(
            () => mockTokenDataStore.saveToken(token: refreshedTokenDto),
          ).thenAnswer((_) => Future<void>.value());

          final data.AuthenticationRepository authenticationRepository =
              data.AuthenticationRepository.private(
            authenticationClient: mockAuthenticationClient,
            tokenDataStore: mockTokenDataStore,
          );

          final core.Token refreshedToken =
              await authenticationRepository.refreshToken(dummyToken);

          expect(identical(refreshedToken, dummyToken), isFalse);
          expect(refreshedToken.refreshToken, 'refreshedToken');
          verify(
            () => mockAuthenticationClient.refreshToken(
              tokenToRefresh: any(named: 'tokenToRefresh'),
            ),
          ).called(1);
          verify(
            () => mockTokenDataStore.saveToken(
              token: any(named: 'token'),
            ),
          ).called(1);
        },
      );
    },
  );

  group('updatePassword', () {
    test(
      'should return a token',
      () async {
        final core.Token dummyToken = core.Token(
          accessToken: 'accessToken',
          refreshToken: 'refreshToken',
          expiresAt: DateTime.now(),
        );
        final TokenDTO dummyTokenDto = TokenDTO.fromEntity(dummyToken);

        when(
          () => mockAuthenticationClient.updatePassword(
            newPassword: 'newPassword',
          ),
        ).thenAnswer((_) => Future<TokenDTO>.value(dummyTokenDto));

        when(
          () => mockTokenDataStore.saveToken(token: dummyTokenDto),
        ).thenAnswer((_) => Future<void>.value());

        final data.AuthenticationRepository authenticationRepository =
            data.AuthenticationRepository.private(
          authenticationClient: mockAuthenticationClient,
          tokenDataStore: mockTokenDataStore,
        );

        final core.Token token = await authenticationRepository.updatePassword(
          newPassword: 'newPassword',
        );

        expect(token, dummyToken);
        verify(
          () => mockAuthenticationClient.updatePassword(
            newPassword: 'newPassword',
          ),
        ).called(1);

        verify(
          () => mockTokenDataStore.saveToken(token: dummyTokenDto),
        ).called(1);
      },
    );
  });
}

class MockAuthenticationClient extends Mock implements AuthenticationClient {}

class MockTokenDataStore extends Mock implements TokenDataStore {}
