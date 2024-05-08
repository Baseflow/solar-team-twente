import 'package:solar_team_twente/core.dart';
import 'package:solar_team_twente/src/data/interceptors/authentication_token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

class MockDio extends Mock implements Dio {}

void main() {
  late MockAuthenticationRepository mockAuthenticationRepository;
  late AuthenticationTokenInterceptor tokenInterceptor;
  late MockErrorInterceptorHandler mockErrorInterceptorHandler;
  late MockDio mockDio;

  setUpAll(() {
    registerFallbackValue(
      Token(
        accessToken: 'accessToken',
        refreshToken: 'refreshToken',
        expiresAt: DateTime.now(),
      ),
    );
    registerFallbackValue(RequestOptions(path: '/some-path'));
  });

  setUp(() {
    mockDio = MockDio();
    mockAuthenticationRepository = MockAuthenticationRepository();
    mockErrorInterceptorHandler = MockErrorInterceptorHandler();
    tokenInterceptor = AuthenticationTokenInterceptor(
      authenticationRepository: mockAuthenticationRepository,
      dio: mockDio,
    );
  });

  group(
    'Add token',
    () => <void>{
      test(
        'Should add token to request',
        () async {
          when(() => mockAuthenticationRepository.getToken()).thenAnswer(
            (_) => Future<Token?>.value(
              Token(
                accessToken: 'accessToken',
                refreshToken: 'refreshToken',
                expiresAt: DateTime.now().add(const Duration(days: 1)),
              ),
            ),
          );

          final RequestOptions requestOptions = RequestOptions(path: '/');
          await tokenInterceptor.onRequest(
            requestOptions,
            RequestInterceptorHandler(),
          );

          expect(
            requestOptions.headers['Authorization'],
            'Bearer accessToken',
          );
        },
      ),
      test('Should not add token if no token is available', () async {
        when(() => mockAuthenticationRepository.getToken()).thenAnswer(
          (_) => Future<Token?>.value(),
        );

        final RequestOptions requestOptions = RequestOptions(path: '/');

        expect(
          () async => tokenInterceptor.onRequest(
            requestOptions,
            RequestInterceptorHandler(),
          ),
          throwsA(
            const TokenException(
              errorCode: TokenExceptionCode.noTokenFound,
            ),
          ),
        );
      }),
      test('Should refresh token and retries request on 401 error', () async {
        final Token initialToken = Token(
          accessToken: 'accessToken',
          refreshToken: 'refreshToken',
          expiresAt: DateTime.now().add(
            const Duration(days: -1),
          ),
        );

        final Token refreshedToken = Token(
          accessToken: 'newAccessToken',
          refreshToken: 'newRefreshToken',
          expiresAt: DateTime.now().add(
            const Duration(days: 1),
          ),
        );

        when(() => mockAuthenticationRepository.getToken()).thenAnswer(
          (_) => Future<Token?>.value(initialToken),
        );
        when(() => mockAuthenticationRepository.refreshToken(any())).thenAnswer(
          (_) => Future<Token>.value(refreshedToken),
        );

        when(() => mockDio.fetch<dynamic>(any())).thenAnswer(
          (_) => Future<Response<dynamic>>.value(
            Response<dynamic>(
              statusCode: 200,
              requestOptions: RequestOptions(path: '/some-path'),
            ),
          ),
        );

        // Trigger 401 response
        final Response<dynamic> response = Response<dynamic>(
          statusCode: 401,
          requestOptions: RequestOptions(path: '/some-path'),
        );
        final DioException dioException = DioException(
          requestOptions: RequestOptions(path: '/some-path'),
          response: response,
        );

        await tokenInterceptor.onError(
          dioException,
          ErrorInterceptorHandler(),
        );

        verify(() => mockAuthenticationRepository.getToken()).called(1);

        verify(
          () => mockAuthenticationRepository.refreshToken(initialToken),
        ).called(1);
        verify(() => mockDio.fetch<dynamic>(any())).called(1);
      }),
      test('Should throw an exception when refresh fails', () async {
        final Token token = Token(
          accessToken: 'accessToken',
          refreshToken: 'refreshToken',
          expiresAt: DateTime.now().add(
            const Duration(days: 1),
          ),
        );
        when(() => mockAuthenticationRepository.getToken()).thenAnswer(
          (_) => Future<Token?>.value(token),
        );
        when(() => mockAuthenticationRepository.refreshToken(token)).thenThrow(
          const TokenException(
            errorCode: TokenExceptionCode.localSaveFailed,
          ),
        );

        final RequestOptions requestOptions =
            RequestOptions(path: 'https://example.com');

        expect(
          () async => tokenInterceptor.onError(
            DioException(
              requestOptions: requestOptions,
              response: Response<dynamic>(
                requestOptions: requestOptions,
                statusCode: 401,
              ),
            ),
            ErrorInterceptorHandler(),
          ),
          throwsA(
            const TypeMatcher<TokenException>(),
          ),
        );
      }),
      test('Should forward exceptions when a non-401 exception is thrown',
          () async {
        when(() => mockAuthenticationRepository.getToken()).thenAnswer(
          (_) => Future<Token?>.value(
            Token(
              accessToken: 'accessToken',
              refreshToken: 'refreshToken',
              expiresAt: DateTime.now().add(
                const Duration(days: -1),
              ),
            ),
          ),
        );

        final Response<dynamic> response = Response<dynamic>(
          statusCode: 403,
          requestOptions: RequestOptions(path: '/some-path'),
        );
        final DioException dioException = DioException.badResponse(
          statusCode: 403,
          requestOptions: RequestOptions(path: '/some-path'),
          response: response,
        );

        when(() => mockErrorInterceptorHandler.next(dioException))
            .thenThrow(dioException);

        expect(
          () => tokenInterceptor.onError(
            dioException,
            mockErrorInterceptorHandler,
          ),
          throwsA(dioException),
        );
      }),
    },
  );
}
