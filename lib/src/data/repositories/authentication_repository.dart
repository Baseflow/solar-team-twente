import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core.dart';
import '../data_stores/token_data_store.dart';
import '../dto/authentication/token_dto.dart';

/// Provides access to the authentication token.
///
/// Once the authentication token is acquired via the [signIn] method the
/// [Token] instance is kept in memory and persisted to a local store.
///
/// The [getToken] method can be used to access the token. If the token is not
/// available directly from memory, the token will be retrieved from the data
/// store.
///
/// The [SupabaseAuthenticationRepository] also allows revoking a token using
/// the [endSession] method or refreshing a token via the [refreshToken] method.
class SupabaseAuthenticationRepository implements AuthenticationRepository {
  /// Returns an instance of the [SupabaseAuthenticationRepository] class.
  ///
  /// If an instance is already created, the existing instance will be returned.
  /// Otherwise a new instance will be returned.
  factory SupabaseAuthenticationRepository({
    required SupabaseClient authenticationClient,
    required TokenDataStore tokenDataStore,
  }) {
    return _repositoryInstance ??= SupabaseAuthenticationRepository.private(
      authenticationClient: authenticationClient,
      tokenDataStore: tokenDataStore,
    );
  }

  /// Creates a new [SupabaseAuthenticationRepository].
  ///
  /// This constructor is visible for testing only and should not be used
  /// outside of this class.
  @visibleForTesting
  SupabaseAuthenticationRepository.private({
    required SupabaseClient authenticationClient,
    required TokenDataStore tokenDataStore,
  })  : _authenticationClient = authenticationClient,
        _tokenDataStore = tokenDataStore;

  static SupabaseAuthenticationRepository? _repositoryInstance;

  final SupabaseClient _authenticationClient;
  final TokenDataStore _tokenDataStore;

  Token? _currentToken;

  @override
  Future<Token?> getToken() async {
    if (_currentToken != null) {
      return _currentToken!;
    }

    final TokenDTO? tokenDto = await _tokenDataStore.retrieveToken();
    return _currentToken ??= tokenDto?.toEntity();
  }

  @override
  Future<Token> signIn({
    required String email,
    required String password,
  }) async {
    final AuthResponse response =
        await _authenticationClient.auth.signInWithPassword(
      email: email,
      password: password,
    );

    // TODO(Jurijs): Handle error
    if (response.session == null || response.user == null) {
      throw Exception('Failed to sign in');
    }

    final DateTime expiresAt = DateTime.parse(
      response.session!.expiresAt!.toString(),
    );

    final TokenDTO tokenDto = TokenDTO(
      accessToken: response.session!.accessToken,
      refreshToken: response.session!.refreshToken!,
      expiresAt: expiresAt,
    );

    await _tokenDataStore.saveToken(token: tokenDto);

    _currentToken = tokenDto.toEntity();
    return _currentToken!;
  }

  @override
  Future<void> endSession() async {
    final Token? token = _currentToken;

    if (token == null) {
      return;
    }

    final TokenDTO tokenDto = TokenDTO.fromEntity(token);

    await _authenticationClient.auth.signOut();

    await _tokenDataStore.deleteToken(token: tokenDto);

    _currentToken = null;
  }

  @override
  Future<Token> refreshToken(Token token) async {
    // final TokenDTO tokenDto = await _authenticationClient.refreshToken(
    //   tokenToRefresh: TokenDTO.fromEntity(token),
    // );
    //
    // await _tokenDataStore.saveToken(token: tokenDto);
    //
    // _currentToken = tokenDto.toEntity();
    return _currentToken!;
  }

  @override
  Future<Token> registerAccount({
    required String email,
    required String password,
  }) async {
    // final TokenDTO tokenDto =
    //     await _authenticationClient.registerWithCredentials(
    //   email: email,
    //   password: password,
    // );
    //
    // await _tokenDataStore.saveToken(token: tokenDto);
    //
    // _currentToken = tokenDto.toEntity();
    return _currentToken!;
  }

  @override
  Future<Token> updatePassword({required String newPassword}) async {
    // final TokenDTO tokenDto = await _authenticationClient.updatePassword(
    //   newPassword: newPassword,
    // );
    //
    // await _tokenDataStore.saveToken(token: tokenDto);
    // await Future<void>.delayed(const Duration(seconds: 2));
    //
    // _currentToken = tokenDto.toEntity();
    return _currentToken!;
  }

  @override
  User? get currentUser => _authenticationClient.auth.currentUser;
}
