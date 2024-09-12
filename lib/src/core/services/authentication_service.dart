import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core.dart';

/// Takes care of all authentication related business logic.
class AuthenticationService {
  /// Creates a new instance of [AuthenticationService].
  AuthenticationService({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  final StreamController<AuthenticationStatus> _authStatusController =
      StreamController<AuthenticationStatus>();

  /// A stream of [AuthenticationStatus] to listen to.
  Stream<AuthenticationStatus> get authStatusStream =>
      _authStatusController.stream;

  /// Signs in the user with the given [email] and [password].
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _authenticationRepository.signIn(
      email: email,
      password: password,
    );
    _authStatusController.add(AuthenticationStatus.authenticated);
  }

  /// Logs out the currently user.
  Future<void> logout() async {
    await _authenticationRepository.endSession();
    _authStatusController.add(AuthenticationStatus.unauthenticated);
  }

  /// Registers a new account given [email] and [password].
  Future<void> registerAccount({
    required String email,
    required String password,
  }) async {
    await _authenticationRepository.registerAccount(
      email: email,
      password: password,
    );
    _authStatusController.add(AuthenticationStatus.authenticated);
  }

  /// Updates the password of the user with the [newPassword].
  Future<void> updatePassword({required String newPassword}) async {
    await _authenticationRepository.updatePassword(newPassword: newPassword);
    _authStatusController.add(AuthenticationStatus.authenticated);
  }

  /// Ensures that the current token is valid and refreshes it if necessary.
  ///
  /// If the token is invalid or expired, the authentication status will be set
  /// to [AuthenticationStatus.unauthenticated].
  Future<void> ensureValidToken() async {
    try {
      // Token is temporarily disabled until authentication will be implemented.
      Token? token = await _authenticationRepository.getToken();

      if (token?.isExpired ?? false) {
        token = await _authenticationRepository.refreshToken(token!);
      }

      _authStatusController.add(
        token != null
            ? AuthenticationStatus.authenticated
            : AuthenticationStatus.unauthenticated,
      );
    } catch (e) {
      _authStatusController.add(AuthenticationStatus.unauthenticated);
    }
  }

  User? get currentUser => _authenticationRepository.currentUser;
}
