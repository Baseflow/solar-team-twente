import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../dto/authentication/token_dto.dart';

/// Implementation of the [TokenDataStore] allow persisting an authentication
/// [TokenDTO] in a data store so the [TokenDTO] instance can be reused over
/// multiple application life cycles.
abstract interface class TokenDataStore {
  /// Deletes the specified [token] from the data store.
  Future<void> deleteToken({required TokenDTO token});

  /// Retrieves the current [TokenDTO] from the data store.
  ///
  /// If no token was stored, `null` is returned.
  Future<TokenDTO?> retrieveToken();

  /// Saves the specified [token] to the data store.
  ///
  /// Saving a token will overwrite a token that was persisted earlier.
  Future<void> saveToken({required TokenDTO token});
}

/// A secure implementation of the [TokenDataStore] interface. Allows for
/// persisting and retrieving authentication tokens in a secure and encrypted
/// manor.
class FlutterSecureStorageTokenDataStore implements TokenDataStore {
  static const String _tokenStorageKey = 'auth_token';

  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      keyCipherAlgorithm:
          KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    ),
  );

  @override
  Future<void> deleteToken({required TokenDTO token}) {
    return _flutterSecureStorage.delete(key: _tokenStorageKey);
  }

  @override
  Future<TokenDTO?> retrieveToken() async {
    final String? encoded = await _flutterSecureStorage.read(
      key: _tokenStorageKey,
    );

    if (encoded == null) return null;

    return TokenDTO.fromJson(jsonDecode(encoded) as Map<String, dynamic>);
  }

  @override
  Future<void> saveToken({required TokenDTO token}) {
    return _flutterSecureStorage.write(
      key: _tokenStorageKey,
      value: jsonEncode(token.toJson()),
    );
  }
}
