import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dto/authentication/token_dto.dart';

part 'authentication_client.g.dart';

/// Client for the Authentication API.
@RestApi()
abstract class AuthenticationClient {
  /// Creates a new instance of the [AuthenticationClient].
  factory AuthenticationClient(Dio dio, {required String baseUrl}) =
  _AuthenticationClient;

  /// Login using the specified [email] and [password] credentials.
  @POST('')
  Future<TokenDTO> loginWithCredentials({
    required String email,
    required String password,
  });

  /// Refresh the specified authentication token.
  @POST('')
  Future<TokenDTO> refreshToken({required TokenDTO tokenToRefresh});

  /// Request the remote API to revoke the specified [token].
  @GET('')
  Future<void> signOut({required TokenDTO token});

  /// Register account with the specified [email] and [password] credentials.
  @POST('')
  Future<TokenDTO> registerWithCredentials({
    required String email,
    required String password,
  });

  /// Update password with the specified [newPassword].
  @POST('')
  Future<TokenDTO> updatePassword({required String newPassword});
}

/// A mock implementation of the [AuthenticationClient] with the sole purpose of
/// allowing the generated app to run. This implementation always returns a
/// fake token.

// TODO(mvanbeusekom): Remove this class for client applications and create a
// proper implementation of the [AuthenticationClient].
class MockAuthenticationClient implements AuthenticationClient {
  static const Duration _tokenLifeSpan = Duration(days: 2);

  @override
  Future<TokenDTO> loginWithCredentials({
    required String email,
    required String password,
  }) async {
    return TokenDTO(
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
      expiresAt: DateTime.now().add(_tokenLifeSpan),
    );
  }

  @override
  Future<TokenDTO> refreshToken({required TokenDTO tokenToRefresh}) async {
    return TokenDTO(
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
      expiresAt: DateTime.now().add(_tokenLifeSpan),
    );
  }

  @override
  Future<void> signOut({required TokenDTO token}) {
    return Future<void>.value();
  }

  @override
  Future<TokenDTO> registerWithCredentials({
    required String email,
    required String password,
  }) async {
    return TokenDTO(
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
      expiresAt: DateTime.now().add(_tokenLifeSpan),
    );
  }

  @override
  Future<TokenDTO> updatePassword({required String newPassword}) async{
    return TokenDTO(
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
      expiresAt: DateTime.now().add(_tokenLifeSpan),
    );
  }
}
