import 'package:dio/dio.dart';

import '../../../core.dart';

/// Interceptor responsible for adding an authentication token to a request's
/// header, and refreshing tokens on 401 responses.
class AuthenticationTokenInterceptor implements Interceptor {
  /// Creates an Auth token interceptor instance
  AuthenticationTokenInterceptor({
    required AuthenticationRepository authenticationRepository,
    required Dio dio,
  })  : _dioClient = dio,
        _authenticationRepository = authenticationRepository;

  final Dio _dioClient;
  final AuthenticationRepository _authenticationRepository;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final Response<dynamic>? response = err.response;
    final Token? token = await _authenticationRepository.getToken();

    if (response == null || token == null || response.statusCode != 401) {
      return handler.next(err);
    }

    Token newToken;

    try {
      newToken = await _authenticationRepository.refreshToken(token);
    } catch (error) {
      throw const TokenException(
        errorCode: TokenExceptionCode.refreshFailed,
      );
    }

    try {
      err.requestOptions.headers['Authorization'] =
          'Bearer ${newToken.accessToken}';
      final Response<dynamic> newResponse =
          await _dioClient.fetch(err.requestOptions);
      handler.resolve(newResponse);
    } on DioException catch (error) {
      handler.next(error);
    }
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final Token? token = await _authenticationRepository.getToken();

    if (token == null) {
      throw const TokenException(
        errorCode: TokenExceptionCode.noTokenFound,
      );
    }

    options.headers
        .putIfAbsent('Authorization', () => 'Bearer ${token.accessToken}');

    handler.next(options);
  }

  @override
  void onResponse(
    Response<Object?> response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }
}
