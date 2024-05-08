import 'package:meta/meta.dart';

import '../../../core.dart' as core;
import '../clients/authentication_client.dart';
import '../data_stores/token_data_store.dart';
import '../dto/authentication/token_dto.dart';

/// Provides access to the authentication token.
///
/// Once the authentication token is acquired via the [signIn] method the
/// [core.Token] instance is kept in memory and persisted to a local store.
///
/// The [getToken] method can be used to access the token. If the token is not
/// available directly from memory, the token will be retrieved from the data
/// store.
///
/// The [AuthenticationRepository] also allows revoking a token using the
/// [endSession] method or refreshing a token via the [refreshToken] method.
class AuthenticationRepository implements core.AuthenticationRepository {
  /// Returns an instance of the [AuthenticationRepository] class.
  ///
  /// If an instance is already created, the existing instance will be returned.
  /// Otherwise a new instance will be returned.
  factory AuthenticationRepository({
    required AuthenticationClient authenticationClient,
    required TokenDataStore tokenDataStore,
  }) {
    return _repositoryInstance ??= AuthenticationRepository.private(
      authenticationClient: authenticationClient,
      tokenDataStore: tokenDataStore,
    );
  }

  /// Creates a new [AuthenticationRepository].
  ///
  /// This constructor is visible for testing only and should not be used
  /// outside of this class.
  @visibleForTesting
  AuthenticationRepository.private({
    required AuthenticationClient authenticationClient,
    required TokenDataStore tokenDataStore,
  })  : _authenticationClient = authenticationClient,
        _tokenDataStore = tokenDataStore;

  static AuthenticationRepository? _repositoryInstance;

  final AuthenticationClient _authenticationClient;
  final TokenDataStore _tokenDataStore;

  core.Token? _currentToken;

  @override
  Future<core.Token?> getToken() async {
    if (_currentToken != null) {
      return _currentToken!;
    }

    final TokenDTO? tokenDto = await _tokenDataStore.retrieveToken();
    return _currentToken ??= tokenDto?.toEntity();
  }

  @override
  Future<core.Token> signIn({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    final TokenDTO tokenDto = await _authenticationClient.loginWithCredentials(
      email: email,
      password: password,
    );

    await _tokenDataStore.saveToken(token: tokenDto);

    _currentToken = tokenDto.toEntity();
    return _currentToken!;
  }

  @override
  Future<void> endSession() async {
    final core.Token? token = _currentToken;

    if (token == null) {
      return;
    }

    final TokenDTO tokenDto = TokenDTO.fromEntity(token);

    await _authenticationClient.signOut(token: tokenDto);

    await _tokenDataStore.deleteToken(token: tokenDto);

    _currentToken = null;
  }

  @override
  Future<core.Token> refreshToken(core.Token token) async {
    final TokenDTO tokenDto = await _authenticationClient.refreshToken(
      tokenToRefresh: TokenDTO.fromEntity(token),
    );

    await _tokenDataStore.saveToken(token: tokenDto);

    _currentToken = tokenDto.toEntity();
    return _currentToken!;
  }

  @override
  Future<core.Token> registerAccount({
    required String email,
    required String password,
  }) async {
    final TokenDTO tokenDto =
        await _authenticationClient.registerWithCredentials(
      email: email,
      password: password,
    );

    await _tokenDataStore.saveToken(token: tokenDto);

    _currentToken = tokenDto.toEntity();
    return _currentToken!;
  }

  @override
  Future<core.Token> updatePassword({required String newPassword}) async {
    final TokenDTO tokenDto = await _authenticationClient.updatePassword(
      newPassword: newPassword,
    );

    await _tokenDataStore.saveToken(token: tokenDto);
    await Future<void>.delayed(const Duration(seconds: 2));

    _currentToken = tokenDto.toEntity();
    return _currentToken!;
  }
}
